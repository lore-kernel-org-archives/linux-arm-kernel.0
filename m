Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7415EC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 422922192B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 12:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lMGJ3W8k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXkaI2hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 422922192B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zdxp9+1PawT+oOx5UbdpGOy4EoUA5RWMmnTZyDhKgO8=; b=lMGJ3W8kW5moxM
	hSzXgtsx4AlfKq5Ma3VqDYAomqQHUdflNYMg3COTlh56nRtP2NZkDa0pOYpro8aTlOJEz5JICkA7T
	Na+Hk+ahxXZCojgSGCmIv06wXGVOPn5ViDd+h6tqMoPoEIK3pqdE+LBRsBKCJdd4jQOdWn2bUqp9I
	zqee2//hYKCB88aQqZd7SHDu1vBJVCcoCdR99nkrN1DOA4rbujhwfeUEcgcBmsNdNCuiCm6sXJxD5
	mEs2XlLHBq7TceqLCJYNfZlM3teSzN9eye+eO/Xm0fiVKErL83EOd18Kn2el+Brit/LCU2eB1nXNm
	ED8i0NaSfxhkusUaoafw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guciS-00086V-7D; Fri, 15 Feb 2019 12:35:40 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guci1-0007c2-Tx
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 12:35:16 +0000
Received: by mail-wm1-x343.google.com with SMTP id r17so9688575wmh.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 15 Feb 2019 04:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MSWVPDeW6Y6e3BJiwHPZzYiuddTe78aLBSeVRNBTdIU=;
 b=bXkaI2hDvhnNO685cjXMTl9TOoxG4WUy+qHiluxj0OGFHJq+7rZipSimJ7jrNtSG9r
 Sl7PaCtHqWSF0uuHMb+zLktaPsApxMDuRiyTgRBPEQ2JQTlEMA6vyJ+tkUCJ/A5i10MM
 tM5bx4tfQmIav9aLtYitKhxHeHMAyLc+YMqLMZ6uBxZQhFLeKA0qTjt7zwlQ03EJo+S3
 vNSAA7ND7GdHMBM9pwtxcrYAj6npI9roSiQfpZTDeN4gvOAWLlR08BRoZfsuX1uZZ0Ac
 5lk21fnOa7cUT31Zf27u1xdYwmGHhbkcdo0CMxCZDOa7vvkMN9WtHXan07LC+jyo/QRu
 9JKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MSWVPDeW6Y6e3BJiwHPZzYiuddTe78aLBSeVRNBTdIU=;
 b=bk7AXw0/VeLrgoIvKhlAbflNc1v6AwFgbZEnVYkKAuRBXyzEJaQW1ZuG4pdUurnXk2
 xkHXY3n75Qyk2S13l+GHdUEDd5ZOKdYFSl3IXRsp9Q6p7R3r1IMAiJcRythTsxSs91rT
 sm+o9G326I+U5kc5vzyghJNc45zJw1t/liTUQJF9wYxgyOKegKsurNy1T6jx9NnzLnZF
 sy1/KJe5Sl7tG1GqTnCLIfKxJaN8PKkNnYm+LS06tw+eQWynjbzecBx/7TvLS6/+VgZn
 vggsrH0uOE8CsJsgdS7lHiuHkLWcH/znT6pxyQnePKqlxvIMOAT+09I/G0vTZs02xZ5U
 imlQ==
X-Gm-Message-State: AHQUAubV18jyaTG09ieV4bK+X3y4CUWhDFL77fw7NJD8J099qZb7gvVe
 Ku22Cy5ZAhAFXQoZbBN0n8wUdVziKcI=
X-Google-Smtp-Source: AHgI3IYHeM5q4fTg1ijZObcvzdP+a1hAOUuVxDEYHVDh71jsZw6sHk+Q6qDMIcppMc4arEzfw05/jw==
X-Received: by 2002:a1c:7510:: with SMTP id o16mr6412702wmc.38.1550234112073; 
 Fri, 15 Feb 2019 04:35:12 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id y13sm636673wrw.31.2019.02.15.04.35.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 15 Feb 2019 04:35:10 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] efi/arm: Revert "Defer persistent reservations until
 after paging_init()"
Date: Fri, 15 Feb 2019 13:33:33 +0100
Message-Id: <20190215123333.21209-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
References: <20190215123333.21209-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_043513_961303_92D3DCE5 
X-CRM114-Status: GOOD (  12.30  )
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
Cc: linux-efi@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This reverts commit eff896288872d687d9662000ec9ae11b6d61766f, which
deferred the processing of persistent memory reservations to a point
where the memory may have already been allocated and overwritten,
defeating the purpose.

Acked-by: Will Deacon <will.deacon@arm.com>
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
