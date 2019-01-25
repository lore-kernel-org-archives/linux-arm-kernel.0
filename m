Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBACC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:18:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E178620844
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:18:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ko40gLVR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZcZ4Pgwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E178620844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d/eV9lgO0gdf2oLIJUdpk1wdRRlbGhakK2NRjBCxaHk=; b=Ko40gLVRNityyS
	BjFo/S7qcf2TH/wuUdMGTmm/9RlOEacTnYhWcLYxbLk5dGNThAsSENH2Fmx9ROK+Ju6xU3PMs22vL
	SEEo3w53MJ/4x47BWhtuB4j7FUin+SbkTXFJZhFxwFZWrCpKTST1yl0ExlgijlKZmHfcqqh6ON5Yp
	9WMzsyFdJPb77a3Dqx//GqEjiWohUCFJcWpNSTatgrCeNo+74fpnsSIPwxG8/InNdYf7kznZ6CcHX
	hGh5+wzLpvwE82H7Xlr1yk+3WMdocB44X/py255dEm1ozqQmu2vH3CcVwDeJ9xGYJL0sPHt+xDCOL
	1MUCrnoHke0Chl/UaSVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4BW-00071W-Ki; Fri, 25 Jan 2019 16:18:26 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4BJ-0006rn-W0
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:18:15 +0000
Received: by mail-wr1-x443.google.com with SMTP id x10so10892253wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 08:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kXfEZq52cZ0/nqk4AkmgAb2q1S2R98chAyM1XAevOXo=;
 b=ZcZ4Pgwp+nsetNADwvYWavI5DWF/gHaBCp3w2iW0cguhbDQEbkm4ArLIZ5gHZ2nOHD
 n2eu23bT55JCaib488W1/G9Ku2GaIbQtiyAX+tGPlMA4m99Wb5cflWAyaVuQrSv5b8Sb
 09WG7YER+P7BcVJUfFun1D+DVSTjJfJAWJPdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kXfEZq52cZ0/nqk4AkmgAb2q1S2R98chAyM1XAevOXo=;
 b=rEWhHrCZ9mspwMYjDg5iGG36PgmdThxGrfgRDtIh7Nem76KNYh1xqTgOYT7JUNSidL
 mBayOpZCi71+p2J2hipO11rUUkwTaf/1hcWa1C1umXsPDvO1+V/qg/dC/B70aZAN+59O
 EBCVbO7gTT0Yjir/xXQ13XFvCMOXKCih0EvsDYCTx2hU9J3q1IYp24+JIL/HptULl9sr
 xftjYoQ0rSPapgkV1+4xW7Tro+gHu0NtYAnJBeQZUttwNZWlr4c+xobtOBzH9iEEgfan
 yQzFyY/5IEwDWE+C3FTWDNiAMsO5b5bEee/4QHl/KQse+cVBAckzqSxWFhQ1K5JX50Mv
 VDYw==
X-Gm-Message-State: AJcUukeeGtH1UXvLu8RiBhYI2o9q2U1Qb6jPCo00cAGsCT8E/DUkoPKx
 akMo3RoALZS5DPXx+RH2ckhBSA==
X-Google-Smtp-Source: ALg8bN5q2NVnuOcuW6UetfxKWmUh9viVjRKpWeXslhGgNEGu5Vxmyc4++duQym44Y/h2ZUenKUolTA==
X-Received: by 2002:adf:8001:: with SMTP id 1mr11668254wrk.23.1548433092208;
 Fri, 25 Jan 2019 08:18:12 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id t76sm68987212wme.33.2019.01.25.08.18.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 08:18:11 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH 1/2] efi: x86: move EFI earlyprintk code to shared location
Date: Fri, 25 Jan 2019 17:18:05 +0100
Message-Id: <20190125161806.13472-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125161806.13472-1-ard.biesheuvel@linaro.org>
References: <20190125161806.13472-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_081814_025700_5E7C946A 
X-CRM114-Status: GOOD (  14.06  )
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
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, graeme.gregory@linaro.org,
 linux-doc@vger.kernel.org, pjones@redhat.com, corbet@lwn.net, agraf@suse.de,
 leif.lindholm@linaro.org, mingo@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move the x86 EFI earlyprintk to a shared location under drivers/firmware
and tweak it slightly so we can easily reuse it for other architectures
going forward.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/Kconfig.debug                                                  |  2 +-
 arch/x86/include/asm/efi.h                                              |  6 +++++
 arch/x86/platform/efi/Makefile                                          |  1 -
 drivers/firmware/efi/Kconfig                                            |  4 +++
 drivers/firmware/efi/Makefile                                           |  1 +
 arch/x86/platform/efi/early_printk.c => drivers/firmware/efi/earlycon.c | 26 ++++++++++----------
 6 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 0723dff17e6c..078c633771e6 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -43,7 +43,7 @@ config EARLY_PRINTK_DBGP
 config EARLY_PRINTK_EFI
 	bool "Early printk via the EFI framebuffer"
 	depends on EFI && EARLY_PRINTK
-	select FONT_SUPPORT
+	select UEFI_EARLYCON
 	---help---
 	  Write kernel log output directly into the EFI framebuffer.
 
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 107283b1eb1e..79e9b5b10cb5 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -8,6 +8,7 @@
 #include <asm/tlb.h>
 #include <asm/nospec-branch.h>
 #include <asm/mmu_context.h>
+#include <asm/setup.h>
 
 /*
  * We map the EFI regions needed for runtime services non-contiguously,
@@ -244,6 +245,11 @@ static inline bool efi_is_64bit(void)
 
 extern bool efi_reboot_required(void);
 
+static inline struct screen_info *efi_get_screen_info(void)
+{
+	return &boot_params.screen_info;
+}
+
 #else
 static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
 static inline bool efi_reboot_required(void)
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index e4dc3862d423..fe29f3f5d384 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -3,5 +3,4 @@ OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 OBJECT_FILES_NON_STANDARD_efi_stub_$(BITS).o := y
 
 obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
-obj-$(CONFIG_EARLY_PRINTK_EFI)	+= early_printk.o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 89110dfc7127..70335c7f0fe4 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -198,3 +198,7 @@ config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
 	default n
+
+config UEFI_EARLYCON
+	bool
+	select FONT_SUPPORT
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 5f9f5039de50..d18cfd83155c 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -32,3 +32,4 @@ obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
+obj-$(CONFIG_UEFI_EARLYCON)		+= earlycon.o
diff --git a/arch/x86/platform/efi/early_printk.c b/drivers/firmware/efi/earlycon.c
similarity index 87%
rename from arch/x86/platform/efi/early_printk.c
rename to drivers/firmware/efi/earlycon.c
index 7138bc7a265c..c065c482d12b 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -10,7 +10,7 @@
 #include <linux/font.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <asm/setup.h>
+#include <asm/efi.h>
 
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
@@ -31,10 +31,10 @@ static __init int early_efi_map_fb(void)
 	if (!early_efi_keep)
 		return 0;
 
-	base = boot_params.screen_info.lfb_base;
-	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
-	size = boot_params.screen_info.lfb_size;
+	base = efi_get_screen_info()->lfb_base;
+	if (efi_get_screen_info()->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)efi_get_screen_info()->ext_lfb_base << 32;
+	size = efi_get_screen_info()->lfb_size;
 	efi_fb = ioremap(base, size);
 
 	return efi_fb ? 0 : -ENOMEM;
@@ -50,9 +50,9 @@ static __ref void *early_efi_map(unsigned long start, unsigned long len)
 {
 	u64 base;
 
-	base = boot_params.screen_info.lfb_base;
-	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
+	base = efi_get_screen_info()->lfb_base;
+	if (efi_get_screen_info()->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		base |= (u64)efi_get_screen_info()->ext_lfb_base << 32;
 
 	if (efi_fb)
 		return (efi_fb + start);
@@ -71,7 +71,7 @@ static void early_efi_clear_scanline(unsigned int y)
 	unsigned long *dst;
 	u16 len;
 
-	len = boot_params.screen_info.lfb_linelength;
+	len = efi_get_screen_info()->lfb_linelength;
 	dst = early_efi_map(y*len, len);
 	if (!dst)
 		return;
@@ -86,8 +86,8 @@ static void early_efi_scroll_up(void)
 	u16 len;
 	u32 i, height;
 
-	len = boot_params.screen_info.lfb_linelength;
-	height = boot_params.screen_info.lfb_height;
+	len = efi_get_screen_info()->lfb_linelength;
+	height = efi_get_screen_info()->lfb_height;
 
 	for (i = 0; i < height - font->height; i++) {
 		dst = early_efi_map(i*len, len);
@@ -135,7 +135,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 	const char *s;
 	void *dst;
 
-	si = &boot_params.screen_info;
+	si = efi_get_screen_info();
 	len = si->lfb_linelength;
 
 	while (num) {
@@ -206,7 +206,7 @@ static __init int early_efi_setup(struct console *con, char *options)
 	u16 xres, yres;
 	u32 i;
 
-	si = &boot_params.screen_info;
+	si = efi_get_screen_info();
 	xres = si->lfb_width;
 	yres = si->lfb_height;
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
