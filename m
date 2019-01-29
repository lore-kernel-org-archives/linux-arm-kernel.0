Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27DEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913F020989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jd6e0Rpr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R8aNpKUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913F020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YsUo666lhKgGlcFSxeZEkdcUlD5j6i0qqptU4ufOgbk=; b=jd6e0Rpr5k1DgR
	iccQoHQIkKn1xicV8qU9Exk0LuT0q3AHBmN8Xk9PnSr39bLrDWvxQGS+azQWLAmE8fgRuBTixu1CS
	0nWgaqjda+HNpqnAqlkANGGnEl+yGkb584e4YLWZbnxVpi4bw8TRXc84am8optf+DqjHo7Cpk4Q1W
	9AcuBEaLsEOFLBey2aeg2Dx4UBKj8XHNvncg3Mk79ULBRxNdj7G2//jgC4XlTujhvdwXkPzGP051P
	SFckDUZVDxOPNhsOYiTrdE1LQ5TGXtiNFuQlUx7oQ/hvMON/sk8nUA8wI6iUZ6+kr1Z5MZIcBwmOt
	P9GcTStvDgEd0ylTDRIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goYWN-00024Y-Cj; Tue, 29 Jan 2019 18:54:07 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYSw-0007Su-Ur
 for linux-arm-kernel@bombadil.infradead.org; Tue, 29 Jan 2019 18:50:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=81UVWBzuiiLWxlt5Zhyss5LIIbWmTL+dhjejw8e0YyU=; b=R8aNpKUKf7uabCENUkY0mmT9BX
 x3zmIMk3PWczgPg+6R0HmEEYRgvpPrfJiZVa7QLoom/I6aoQDO8GoM1iBTCIZxMKar2Wtv9NLG17T
 ec/li5mhxHqYUzjj2rCVoCrmGyym+3ziFTziZqz9n2n54xBLgQmlRNIauggg/OI36jUfx65YD8baI
 x76e+cdNx1DV0bpML6v2jERzjNZsX1S+525jawYRoUIdy4etjPAgdyn9kY8A1QzWzE247w2aUpQoJ
 yYciOP+OQQtuNYp2EmKwS0GRu9gEvGYF/+ZpMRWPIex5d5ooZ5vNvHX3AKuPCr8jk+7bzTNj078L9
 37o9PcHg==;
Received: from foss.arm.com ([217.140.101.70])
 by merlin.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goYSt-0005YO-G4
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 18:50:33 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5894715AB;
 Tue, 29 Jan 2019 10:50:31 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.105])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AB9013F557;
 Tue, 29 Jan 2019 10:50:28 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: linux-acpi@vger.kernel.org
Subject: [PATCH v8 18/26] ACPI / APEI: Make GHES estatus header validation
 more user friendly
Date: Tue, 29 Jan 2019 18:48:54 +0000
Message-Id: <20190129184902.102850-19-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129184902.102850-1-james.morse@arm.com>
References: <20190129184902.102850-1-james.morse@arm.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_135032_037389_AAADA372 
X-CRM114-Status: GOOD (  14.40  )
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

ghes_read_estatus() checks various lengths in the top-level header to
ensure the CPER records to be read aren't obviously corrupt.

Take the opportunity to make this more user-friendly, printing a
(ratelimited) message about the nature of the header format error.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 46 ++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f95db2398dd5..9391fff71344 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -293,6 +293,30 @@ static void ghes_copy_tofrom_phys(void *buffer, u64 paddr, u32 len,
 	}
 }
 
+/* Check the top-level record header has an appropriate size. */
+int __ghes_check_estatus(struct ghes *ghes,
+			 struct acpi_hest_generic_status *estatus)
+{
+	u32 len = cper_estatus_len(estatus);
+
+	if (len < sizeof(*estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Truncated error status block!\n");
+		return -EIO;
+	}
+
+	if (len > ghes->generic->error_block_length) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid error status block length!\n");
+		return -EIO;
+	}
+
+	if (cper_estatus_check_header(estatus)) {
+		pr_warn_ratelimited(FW_WARN GHES_PFX "Invalid CPER header!\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
 static int ghes_read_estatus(struct ghes *ghes,
 			     struct acpi_hest_generic_status *estatus,
 			     u64 *buf_paddr, enum fixed_addresses fixmap_idx)
@@ -319,27 +343,21 @@ static int ghes_read_estatus(struct ghes *ghes,
 		return -ENOENT;
 	}
 
-	rc = -EIO;
+	rc = __ghes_check_estatus(ghes, estatus);
+	if (rc)
+		return rc;
+
 	len = cper_estatus_len(estatus);
-	if (len < sizeof(*estatus))
-		goto err_read_block;
-	if (len > ghes->generic->error_block_length)
-		goto err_read_block;
-	if (cper_estatus_check_header(estatus))
-		goto err_read_block;
 	ghes_copy_tofrom_phys(estatus + 1,
 			      *buf_paddr + sizeof(*estatus),
 			      len - sizeof(*estatus), 1, fixmap_idx);
-	if (cper_estatus_check(estatus))
-		goto err_read_block;
-	rc = 0;
-
-err_read_block:
-	if (rc)
+	if (cper_estatus_check(estatus)) {
 		pr_warn_ratelimited(FW_WARN GHES_PFX
 				    "Failed to read error status block!\n");
+		return -EIO;
+	}
 
-	return rc;
+	return 0;
 }
 
 static void ghes_clear_estatus(struct ghes *ghes,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
