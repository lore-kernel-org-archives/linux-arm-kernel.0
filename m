Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25995C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D95CD2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R23fJj1H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mbEoOCwn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D95CD2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kdm1E2672BmGbSBX5m48DN8kPj/vHVEwPJAueFHVFJA=; b=R23fJj1Hlx8j0Z
	U7o7m4GAXCXYo9h+JvH6C0l+tJ+9b80WmoTu4uB5XLfH7GuS90bDQ3f0E1AqhQIa4Yjy1fJ1rhg3E
	y/CoP/k1UuG73n8gD5dpHSOzziKG84Zgm0chpTMrTGEeMLUh/kEjDl1jw5XlSZABZ32OdWc7KL59R
	3/6FbcpSYCzGSGRsvUEq+baN2EHSjPsBp6mVCZPfHBmEQSeU5CJq+PIVoLpbVTZSI4aOKFI8cFTXW
	IRMmoP6YfrusOy79AU6a4bqrTZ9iQ2CP63LvWuO7L8cZfkZS9cHm6EsMrKg0QreSa2GdxAwcv0p0O
	UZFSmqyLio7nju7bH6og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTt2G-000512-8i; Mon, 03 Dec 2018 18:33:36 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTt0Q-0003LE-Nn
 for linux-arm-kernel@bombadil.infradead.org; Mon, 03 Dec 2018 18:31:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i8kqVEny1BxLFODzbCS4OoIldxl/VAf8AelIhGS7wlY=; b=mbEoOCwn6JI1ITR/EMYXkeULYM
 cXK4gBy/vD0IZcjxqljlSm4yMTbzyXF6iKfBpa4i35DqQhtVAWAt64PhqBX2CmQz9owtxR+MTGK8N
 jp29v0N7E/mGjsjNaukxrh57E7bzzLJTmhLQI/bSwFmi5GqeX1J9OSqOYunF1YeidorH8ri1/iud9
 xFOxotJBttpiYGpWbTTepVpyNhTx0/989nw2p4LM1NzrrrCRJBgNRdhK3wa/TLhrMDdV3Jo+C6f7n
 /NzrQaKZE9A3lrXbxP3TsnhqLP/AcRiT7LdHOKUeAHBN/O4mdiL6S2xLmnIWnqXdX2AEh34xd68m8
 q+nCEZ+w==;
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]
 helo=foss.arm.com)
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTsdB-0001cn-N7
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 18:07:42 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46A07169E;
 Mon,  3 Dec 2018 10:07:41 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76E263F59C;
 Mon,  3 Dec 2018 10:07:38 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v7 18/25] ACPI / APEI: Split ghes_read_estatus() to allow a
 peek at the CPER length
Date: Mon,  3 Dec 2018 18:06:06 +0000
Message-Id: <20181203180613.228133-19-james.morse@arm.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181203180613.228133-1-james.morse@arm.com>
References: <20181203180613.228133-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_130741_962494_9EC48FCC 
X-CRM114-Status: GOOD (  19.43  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Tony Luck <tony.luck@intel.com>,
 Fan Wu <wufan@codeaurora.org>, Xie XiuQi <xiexiuqi@huawei.com>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ghes_read_estatus() reads the record address, then the record's
header, then performs some sanity checks before reading the
records into the provided estatus buffer.

To provide this estatus buffer the caller must know the size of the
records in advance, or always provide a worst-case sized buffer as
happens today for the non-NMI notifications.

Add a function to peek at the record's header to find the size. This
will let the NMI path allocate the right amount of memory before reading
the records, instead of using the worst-case size, and having to copy
the records.

Split ghes_read_estatus() to create __ghes_peek_estatus() which
returns the address and size of the CPER records.

Signed-off-by: James Morse <james.morse@arm.com>

Changes since v6:
 * Additional buf_addr = 0 error handling
 * Moved checking out of peek-estatus
 * Reworded an error message so we can tell them apart
---
 drivers/acpi/apei/ghes.c | 59 ++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b70f5fd962cc..07a12aac4c1a 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -277,12 +277,12 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	}
 }
 
-static int ghes_read_estatus(struct ghes *ghes,
-			     struct acpi_hest_generic_status *estatus,
-			     u64 *buf_paddr, int fixmap_idx)
+/* Read the CPER block and returning its address, and header in estatus. */
+static int __ghes_peek_estatus(struct ghes *ghes, int fixmap_idx,
+			       struct acpi_hest_generic_status *estatus,
+			       u64 *buf_paddr)
 {
 	struct acpi_hest_generic *g = ghes->generic;
-	u32 len;
 	int rc;
 
 	rc = apei_read(buf_paddr, &g->error_status_address);
@@ -303,29 +303,64 @@ static int ghes_read_estatus(struct ghes *ghes,
 		return -ENOENT;
 	}
 
-	rc = -EIO;
-	len = cper_estatus_len(estatus);
+	return 0;
+}
+
+/* Check the top-level record header has an appropriate size. */
+int __ghes_check_estatus(struct ghes *ghes,
+			 struct acpi_hest_generic_status *estatus)
+{
+	u32 len = cper_estatus_len(estatus);
+	int rc = -EIO;
+
 	if (len < sizeof(*estatus))
 		goto err_read_block;
 	if (len > ghes->generic->error_block_length)
 		goto err_read_block;
 	if (cper_estatus_check_header(estatus))
 		goto err_read_block;
-	ghes_copy_tofrom_phys(estatus + 1,
-			      *buf_paddr + sizeof(*estatus),
-			      len - sizeof(*estatus), 1, fixmap_idx);
-	if (cper_estatus_check(estatus))
-		goto err_read_block;
 	rc = 0;
 
 err_read_block:
 	if (rc)
 		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Failed to read error status block!\n");
+				    "Invalid Error status block!\n");
 
 	return rc;
 }
 
+static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
+			       u64 buf_paddr, size_t buf_len,
+			       int fixmap_idx)
+{
+	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
+	if (cper_estatus_check(estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX
+				   "Failed to read error status block!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int ghes_read_estatus(struct ghes *ghes,
+			     struct acpi_hest_generic_status *estatus,
+			     u64 *buf_paddr, int fixmap_idx)
+{
+	int rc;
+
+	rc = __ghes_peek_estatus(ghes, fixmap_idx, estatus, buf_paddr);
+	if (rc)
+		return rc;
+
+	rc = __ghes_check_estatus(ghes, estatus);
+	if (rc)
+		return rc;
+
+	return __ghes_read_estatus(estatus, *buf_paddr,
+				   cper_estatus_len(estatus), fixmap_idx);
+}
+
 static void ghes_clear_estatus(struct acpi_hest_generic_status *estatus,
 			       u64 buf_paddr, int fixmap_idx)
 {
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
