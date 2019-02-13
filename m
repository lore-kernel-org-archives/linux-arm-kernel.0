Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E55C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 746882075D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ODzfroYL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYNHnr2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 746882075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9b0WQ2pNKY49M5O1cmyqXP2lNe3nzyH1iRrGNTCJFDk=; b=ODzfroYLBDDZQT
	qeHt5xQOe7CGH2Gm0xpwzwG6yDCR8jsMx/cOl7+HRur2ca0vnPUVp7I4hbk5aYfxnKYO2oR2Ir6n1
	uF2O/p06EHIi8UpW3XbKRq8aA9DcBV7HsUzz7ztyyod3wnI/smzsD1PlDfnoS0KmHf7jdXPXpZaDY
	xGU7J84VUea1DKPro36jFA83WOrpdvPY3ySHCFupocjrHk2wAL2pLpzpCyBVuayOsCeD6pSE/0R41
	iMw2HOL5+t+M4LwdwoQGBg2Skg8h6I41xElixodTyvgEbb0TNbpEyjBbfje7LgrqoH9AIpxM/8jls
	gsL32gZoRDLUlGeSTTxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtube-0006jA-TH; Wed, 13 Feb 2019 13:29:43 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuad-0005RU-R4
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:29:09 +0000
Received: by mail-wr1-x443.google.com with SMTP id l5so1409559wrw.6
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 13 Feb 2019 05:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SvFSLn76SFJDwEu/S0bVHnKlVxmVyL4jfmZ7pu7W45E=;
 b=nYNHnr2Zsxh+UaDXNN6yzU0ly6IkH762vDdfRfYhFGRyB9VVEUhGSKXoIhjVWQ29Bt
 l2yS5gAG5bivhvIuH0KftYXcDIWlzChYzt8+KrCFslMDBc9AieVDkLJ84502Gr6BKIUv
 74QqC+GSpz2LRAsaf+0fS+l0UCI4NBnbriNKoblA6yN2j4sTfAZYqAxr7bkQ+Pc6a7z6
 wc6XYmVEWEcK/Yo+ukBHyLnIlHl8bULoeyucuYm8aaN4NS4MdkhKx0wukq6yCP/kZcZL
 2eZLLQzFUC3BFc9hN1aD2HD1GE2dpll2qP3LLEGP6wmqJfLJeYp5NXI0lhY5YG7sV3sb
 Wt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SvFSLn76SFJDwEu/S0bVHnKlVxmVyL4jfmZ7pu7W45E=;
 b=QlanOSN7UY+Xbp+1mwaLUgeZ21CarPP63YXL3pUxBa5oC44IzHqT1x18kptv3Bbp1n
 besAhU2Q1mG5NIFeYdaCXGZTnKM9jylBY0/ld8dW99eZMWfaSCYBuIIJlqBdNTbUq+8L
 H1yNbWDhXFyykV5oE550jGkrS+awBcXu2xrGjvz7/tY/gxd/i21DeSv87Ur2TFxc9lEO
 3p9x2ml5TmjVou0Zc3Px4V07zOMCL44vrY7/dt7w5mP3Jvam0aOPrEPSuK/5qCX6Vzoi
 m6QaSMvjynegt0+/Fty1Wnjfga4rvnAscWMMWxfgVn1gTbSekSzLvVBpOlgm46kCsscU
 lsdA==
X-Gm-Message-State: AHQUAuYiwrZhoyYWulNl33NglCKBMyituc5QEs0+hKh0MX1cVIpP2jiX
 VYJ04GMCdhNqie7OLfrphvZ/tA83X3I=
X-Google-Smtp-Source: AHgI3IZVubh1ey1AnRQ8u+x4lnSZlgsf8/ratFtS4LSrAz+twyaMAqm54+WCe3g/zrNVCc7jXNwozg==
X-Received: by 2002:adf:fa0d:: with SMTP id m13mr402593wrr.93.1550064518026;
 Wed, 13 Feb 2019 05:28:38 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-27-200.w90-86.abo.wanadoo.fr. [90.86.252.200])
 by smtp.gmail.com with ESMTPSA id x3sm22841195wrd.19.2019.02.13.05.28.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 13 Feb 2019 05:28:37 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH 2/2] efi/arm: Revert "Defer persistent reservations until
 after paging_init()"
Date: Wed, 13 Feb 2019 14:27:38 +0100
Message-Id: <20190213132738.10294-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
References: <20190213132738.10294-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052840_362702_5AACF5F8 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org,
 James Morse <james.morse@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit eff896288872d687d9662000ec9ae11b6d61766f, which
deferred the processing of persistent memory reservations to a point
where the memory may have already been allocated and overwritten,
defeating the purpose.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/setup.c               | 1 -
 drivers/firmware/efi/efi.c              | 4 ----
 drivers/firmware/efi/libstub/arm-stub.c | 3 ---
 include/linux/efi.h                     | 7 -------
 4 files changed, 15 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 4b0e1231625c..d09ec76f08cf 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -313,7 +313,6 @@ void __init setup_arch(char **cmdline_p)
 	arm64_memblock_init();
 
 	paging_init();
-	efi_apply_persistent_mem_reservations();
 
 	acpi_table_upgrade();
 
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4c46ff6f2242..55b77c576c42 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -592,11 +592,7 @@ int __init efi_config_parse_tables(void *config_tables, int count, int sz,
 
 		early_memunmap(tbl, sizeof(*tbl));
 	}
-	return 0;
-}
 
-int __init efi_apply_persistent_mem_reservations(void)
-{
 	if (efi.mem_reserve != EFI_INVALID_TABLE_ADDR) {
 		unsigned long prsv = efi.mem_reserve;
 
diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index eee42d5e25ee..c037c6c5d0b7 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -75,9 +75,6 @@ void install_memreserve_table(efi_system_table_t *sys_table_arg)
 	efi_guid_t memreserve_table_guid = LINUX_EFI_MEMRESERVE_TABLE_GUID;
 	efi_status_t status;
 
-	if (IS_ENABLED(CONFIG_ARM))
-		return;
-
 	status = efi_call_early(allocate_pool, EFI_LOADER_DATA, sizeof(*rsv),
 				(void **)&rsv);
 	if (status != EFI_SUCCESS) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 45ff763fba76..28604a8d0aa9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1198,8 +1198,6 @@ static inline bool efi_enabled(int feature)
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
 
 extern bool efi_is_table_address(unsigned long phys_addr);
-
-extern int efi_apply_persistent_mem_reservations(void);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1218,11 +1216,6 @@ static inline bool efi_is_table_address(unsigned long phys_addr)
 {
 	return false;
 }
-
-static inline int efi_apply_persistent_mem_reservations(void)
-{
-	return 0;
-}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
