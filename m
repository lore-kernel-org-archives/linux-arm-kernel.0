Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C075AC282C7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:12:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 764D621848
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 19:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IDTThSFf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MMzBr9wy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 764D621848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2Q+gquvy0BCx75nWLor2And9CijEJw8k4sGKGaZg+tk=; b=IDTThSFflMW4cB
	E0tZLXVolpU7tp0S0vEs/1Hj2GQW4T8c0SlqlslyrsrtO5J/RdvSYS3COsjGdvxUaBerEAqAwNxqD
	EoOer1m+zUgmrWIaMCP5ciNlCeOtiH8WLw2Vy1g+6oKSh1j4SkJ5F46p4/YggT8aDAOLCuW7PRtyC
	1KJxvlcSv6mFUJJEHp5hpynCiyFujhBfNzn0YlLty1tfXEXkG2Y2LTht/sNopSEOofXZ10lrdD0Kc
	Y7YS4pYhUnNKNoe4HQOMuJI9jDbnyU5QKqC4A5jh0tjha6hL1CGfIJqko2vIpn7yZsL6xNdDNnkWo
	K5B9uihdpu65VLVJZZ0g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYoP-0006FE-Gz; Tue, 29 Jan 2019 19:12:45 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYma-0004kD-Nf
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 19:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cB5Vc/XqlFzwaz7GNJcyfHSezxcsXClhbOckn8nvs0Q=; b=MMzBr9wyXBpGiz2AxJm9p0ZWvD
 M6e8axCr3skQDzO60GHk+mc3cKP5z9CKkaO8LuolmN6UxjccZNd840SFSzttM2Cx36tcpHTD8xXfT
 ixNSVjE4mlKzuTSPqPp8cW7b3cxHxodglDyHEEqCtbnCSAYGaqlOH1lKs71xE4jGs8Lj+2mQFi023
 feCt2UFaX1s8s+7oK3Kx4lLqp8+fqFLa2kdPZ1LVVLMsKzKZ7+OUxj7rOiM4cSSOeE1eeD09LvI06
 nZhg+kmedCFPiAwxadw0wggvWnzsT8nsdSSxWNk5JJ3Zl5UX2LpM/aeY3T+QTserJYhml9wONrFz6
 VEHxCzBA==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYSw-0005YO-Jc
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C9115AB;
 Tue, 29 Jan 2019 10:50:34 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9741E3F557;
 Tue, 29 Jan 2019 10:50:31 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 19/26] ACPI / APEI: Split ghes_read_estatus() to allow a
 peek at the CPER length
Date: Tue, 29 Jan 2019 18:48:55 +0000
Message-Id: <20190129184902.102850-20-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135034_857289_8782A3CA 
X-CRM114-Status: GOOD (  14.84  )
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
 Xie XiuQi <xiexiuqi@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>,
 Dongjiu Geng <gengdongjiu@huawei.com>, linux-mm@kvack.org,
 Borislav Petkov <bp@alien8.de>, james.morse@arm.com,
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

Changes since v7:
 * Grammar
 * concistent argument ordering

Changes since v6:
 * Additional buf_addr = 0 error handling
 * Moved checking out of peek-estatus
 * Reworded an error message so we can tell them apart
---
 drivers/acpi/apei/ghes.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 9391fff71344..12375a82fa03 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -317,12 +317,12 @@ int __ghes_check_estatus(struct ghes *ghes,
 	return 0;
 }
 
-static int ghes_read_estatus(struct ghes *ghes,
-			     struct acpi_hest_generic_status *estatus,
-			     u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+/* Read the CPER block, returning its address, and header in estatus. */
+static int __ghes_peek_estatus(struct ghes *ghes,
+			       struct acpi_hest_generic_status *estatus,
+			       u64 *buf_paddr, enum fixed_addresses fixmap_idx)
 {
 	struct acpi_hest_generic *g = ghes->generic;
-	u32 len;
 	int rc;
 
 	rc = apei_read(buf_paddr, &g->error_status_address);
@@ -343,14 +343,14 @@ static int ghes_read_estatus(struct ghes *ghes,
 		return -ENOENT;
 	}
 
-	rc = __ghes_check_estatus(ghes, estatus);
-	if (rc)
-		return rc;
+	return __ghes_check_estatus(ghes, estatus);
+}
 
-	len = cper_estatus_len(estatus);
-	ghes_copy_tofrom_phys(estatus + 1,
-			      *buf_paddr + sizeof(*estatus),
-			      len - sizeof(*estatus), 1, fixmap_idx);
+static int __ghes_read_estatus(struct acpi_hest_generic_status *estatus,
+			       u64 buf_paddr, enum fixed_addresses fixmap_idx,
+			       size_t buf_len)
+{
+	ghes_copy_tofrom_phys(estatus, buf_paddr, buf_len, 1, fixmap_idx);
 	if (cper_estatus_check(estatus)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 				    "Failed to read error status block!\n");
@@ -360,6 +360,24 @@ static int ghes_read_estatus(struct ghes *ghes,
 	return 0;
 }
 
+static int ghes_read_estatus(struct ghes *ghes,
+			     struct acpi_hest_generic_status *estatus,
+			     u64 *buf_paddr, enum fixed_addresses fixmap_idx)
+{
+	int rc;
+
+	rc = __ghes_peek_estatus(ghes, estatus, buf_paddr, fixmap_idx);
+	if (rc)
+		return rc;
+
+	rc = __ghes_check_estatus(ghes, estatus);
+	if (rc)
+		return rc;
+
+	return __ghes_read_estatus(estatus, *buf_paddr, fixmap_idx,
+				   cper_estatus_len(estatus));
+}
+
 static void ghes_clear_estatus(struct ghes *ghes,
 			       struct acpi_hest_generic_status *estatus,
 			       u64 buf_paddr, enum fixed_addresses fixmap_idx)
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
