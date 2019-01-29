Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF227C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FD820881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CbdHtutQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WltQuzTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FD820881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Xf+lMWyCn70TfU+Wp/+kOnl2YUq2nsF+CzivlE+a4PY=; b=CbdHtutQh8GWDX
	Go63TDQ6RKSEXJBxM4XvofsaxdRKb59KvuVs+sPN+0YmQHyugGe34tPLRpIClHWosNh+FjBZTNuRe
	RnVq1ONRyfHFKONbNXrRXbmrA1Vx2iPb65Sj8DKiL9BnfgbGkTglGvFC8zJSxxTBB6E9GKreCswE7
	sLHD5Z5uJwtKZMftnStGGTHxOOXUnCJX/9ZlBLfS3N+4IRVDaf8Nmp/82KtnSi0u9oatME1pSfdHk
	ggoWW9ogfLhiybNdYK2f7X/YSLipco7lX+Q/h9wIszQppR+3u5eRdsvmP2LVOi2O8wgCJ3lDVM5a+
	JUr0zLeBWMhmFiwc0CQw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goPbN-0003I0-R1; Tue, 29 Jan 2019 09:22:41 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goPal-0002ip-IX
 for linux-arm-kernel@lists.infradead.org; Tue, 29 Jan 2019 09:22:07 +0000
Received: by mail-wr1-x443.google.com with SMTP id 96so21197691wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 29 Jan 2019 01:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ofzQUozutv7j3/9AAs8XxX4ZwWP98NAjvft5NulEseI=;
 b=WltQuzTDIRHvYrtjReLj1FiK274v8gmbOWRrBJcQpZotxT0iAI4NESrIPtaKy3K4bb
 K9zd8oW5ckjy/+pMuftWclmYMzkhGV7K/372LySyDeTjwvq+s6cP/LdgXBhI6bgB3M2Z
 kM7UehiwapaUMXVsrOGLS4CTximplqFnNo0VU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ofzQUozutv7j3/9AAs8XxX4ZwWP98NAjvft5NulEseI=;
 b=uU2VG+iKYH5dBqqRriLc0sggZ3ZR4U2Vb6VnHN5i6mjWQNR18owlxTCjMQ5pOaIKxR
 cTIDL87aGThTbsSlI+8aZF/+uAHnVsG40QjQY4ue0bHAGlt1Zz2VOIpnD7nBNatRQTpa
 q9sR74t7XaEyTccHou4ZsXmcfWlYXO5pVkKJO/g7KCAmJyQwERTcD+3yew8tsBDmX6b9
 eeBN2DxcQJ7LJSg2E7XkHbaHGNSiv+9FMdv6LlLDrqE4qWTl8Wx4FQhZUBTetZWtFb0i
 ZRyj/W4dMeh7Ep5gTRVTgRHqL35JWHvZo2Mx6QN7K1IXG6IdfPyKKfXtLkcsSy0p/JKJ
 gnLw==
X-Gm-Message-State: AJcUukcCNRLm0V5W0/o5d7W95u7K7LKuwqSctpr/nXf0VuZyxo2QnZF7
 cA3oGaexXnW9oW9jDCK5aXODt/4Mxxg=
X-Google-Smtp-Source: ALg8bN4ttm5S8UULVzpRcHYgTZ/vHwSPkWUATYd6OWA/3W/g9sIqqNfloIya+jSoQBSe7HON8nKKoQ==
X-Received: by 2002:adf:ae1a:: with SMTP id x26mr24377353wrc.0.1548753721959; 
 Tue, 29 Jan 2019 01:22:01 -0800 (PST)
Received: from sudo.home ([2a01:cb1d:112:6f00:61d3:a2fc:db63:aa38])
 by smtp.gmail.com with ESMTPSA id x1sm28751755wru.34.2019.01.29.01.22.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 29 Jan 2019 01:22:00 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH v2 2/2] efi: x86: convert x86 EFI earlyprintk into generic
 earlycon implementation
Date: Tue, 29 Jan 2019 10:21:50 +0100
Message-Id: <20190129092150.15184-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
References: <20190129092150.15184-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190129_012203_758493_C9EB02E6 
X-CRM114-Status: GOOD (  27.14  )
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
Cc: graeme.gregory@linaro.org, corbet@lwn.net, pjones@redhat.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-doc@vger.kernel.org,
 agraf@suse.de, leif.lindholm@linaro.org, mingo@redhat.com, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Move the x86 EFI earlyprintk implementation to a shared location under
drivers/firmware and tweak it slightly so we can expose it as an earlycon
implementation (which is generic) rather than earlyprintk (which is only
implemented for a few architectures)

This also involves switching to write-combine mappings by default (which
is required on ARM since device mappings lack memory semantics, and so
memcpy/memset may not be used on them), and adding support for shared
memory framebuffers on cache coherent non-x86 systems (which do not
tolerate mismatched attributes)

Note that 32-bit ARM does not populate its struct screen_info early
enough for earlycon=efifb to work, so it is disabled there.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   8 +-
 arch/x86/Kconfig.debug                          |  10 -
 arch/x86/include/asm/efi.h                      |   1 -
 arch/x86/kernel/early_printk.c                  |   4 -
 arch/x86/platform/efi/Makefile                  |   1 -
 arch/x86/platform/efi/early_printk.c            | 240 --------------------
 drivers/firmware/efi/Kconfig                    |   6 +
 drivers/firmware/efi/Makefile                   |   1 +
 drivers/firmware/efi/earlycon.c                 | 208 +++++++++++++++++
 9 files changed, 222 insertions(+), 257 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..76dd3baa31e0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1073,9 +1073,15 @@
 			specified address. The serial port must already be
 			setup and configured. Options are not yet supported.
 
+		efifb,[options]
+			Start an early, unaccelerated console on the EFI
+			memory mapped framebuffer (if available). On cache
+			coherent non-x86 systems that use system memory for
+			the framebuffer, pass the 'ram' option so that it is
+			mapped with the correct attributes.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
-			earlyprintk=efi
 			earlyprintk=sclp
 			earlyprintk=xen
 			earlyprintk=serial[,ttySn[,baudrate]]
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 0723dff17e6c..15d0fbe27872 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -40,16 +40,6 @@ config EARLY_PRINTK_DBGP
 	  with klogd/syslogd or the X server. You should normally say N here,
 	  unless you want to debug such a crash. You need usb debug device.
 
-config EARLY_PRINTK_EFI
-	bool "Early printk via the EFI framebuffer"
-	depends on EFI && EARLY_PRINTK
-	select FONT_SUPPORT
-	---help---
-	  Write kernel log output directly into the EFI framebuffer.
-
-	  This is useful for kernel debugging when your machine crashes very
-	  early before the console code is initialized.
-
 config EARLY_PRINTK_USB_XDBC
 	bool "Early printk via the xHCI debug port"
 	depends on EARLY_PRINTK && PCI
diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 107283b1eb1e..606a4b6a9812 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -170,7 +170,6 @@ static inline bool efi_runtime_supported(void)
 	return false;
 }
 
-extern struct console early_efi_console;
 extern void parse_efi_setup(u64 phys_addr, u32 data_len);
 
 extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 374a52fa5296..9b33904251a9 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -388,10 +388,6 @@ static int __init setup_early_printk(char *buf)
 		if (!strncmp(buf, "xen", 3))
 			early_console_register(&xenboot_console, keep);
 #endif
-#ifdef CONFIG_EARLY_PRINTK_EFI
-		if (!strncmp(buf, "efi", 3))
-			early_console_register(&early_efi_console, keep);
-#endif
 #ifdef CONFIG_EARLY_PRINTK_USB_XDBC
 		if (!strncmp(buf, "xdbc", 4))
 			early_xdbc_parse_parameter(buf + 4);
diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index e4dc3862d423..fe29f3f5d384 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -3,5 +3,4 @@ OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 OBJECT_FILES_NON_STANDARD_efi_stub_$(BITS).o := y
 
 obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
-obj-$(CONFIG_EARLY_PRINTK_EFI)	+= early_printk.o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/arch/x86/platform/efi/early_printk.c b/arch/x86/platform/efi/early_printk.c
deleted file mode 100644
index 7138bc7a265c..000000000000
--- a/arch/x86/platform/efi/early_printk.c
+++ /dev/null
@@ -1,240 +0,0 @@
-/*
- * Copyright (C) 2013 Intel Corporation; author Matt Fleming
- *
- *  This file is part of the Linux kernel, and is made available under
- *  the terms of the GNU General Public License version 2.
- */
-
-#include <linux/console.h>
-#include <linux/efi.h>
-#include <linux/font.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <asm/setup.h>
-
-static const struct font_desc *font;
-static u32 efi_x, efi_y;
-static void *efi_fb;
-static bool early_efi_keep;
-
-/*
- * efi earlyprintk need use early_ioremap to map the framebuffer.
- * But early_ioremap is not usable for earlyprintk=efi,keep, ioremap should
- * be used instead. ioremap will be available after paging_init() which is
- * earlier than initcall callbacks. Thus adding this early initcall function
- * early_efi_map_fb to map the whole efi framebuffer.
- */
-static __init int early_efi_map_fb(void)
-{
-	u64 base, size;
-
-	if (!early_efi_keep)
-		return 0;
-
-	base = boot_params.screen_info.lfb_base;
-	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
-	size = boot_params.screen_info.lfb_size;
-	efi_fb = ioremap(base, size);
-
-	return efi_fb ? 0 : -ENOMEM;
-}
-early_initcall(early_efi_map_fb);
-
-/*
- * early_efi_map maps efi framebuffer region [start, start + len -1]
- * In case earlyprintk=efi,keep we have the whole framebuffer mapped already
- * so just return the offset efi_fb + start.
- */
-static __ref void *early_efi_map(unsigned long start, unsigned long len)
-{
-	u64 base;
-
-	base = boot_params.screen_info.lfb_base;
-	if (boot_params.screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)boot_params.screen_info.ext_lfb_base << 32;
-
-	if (efi_fb)
-		return (efi_fb + start);
-	else
-		return early_ioremap(base + start, len);
-}
-
-static __ref void early_efi_unmap(void *addr, unsigned long len)
-{
-	if (!efi_fb)
-		early_iounmap(addr, len);
-}
-
-static void early_efi_clear_scanline(unsigned int y)
-{
-	unsigned long *dst;
-	u16 len;
-
-	len = boot_params.screen_info.lfb_linelength;
-	dst = early_efi_map(y*len, len);
-	if (!dst)
-		return;
-
-	memset(dst, 0, len);
-	early_efi_unmap(dst, len);
-}
-
-static void early_efi_scroll_up(void)
-{
-	unsigned long *dst, *src;
-	u16 len;
-	u32 i, height;
-
-	len = boot_params.screen_info.lfb_linelength;
-	height = boot_params.screen_info.lfb_height;
-
-	for (i = 0; i < height - font->height; i++) {
-		dst = early_efi_map(i*len, len);
-		if (!dst)
-			return;
-
-		src = early_efi_map((i + font->height) * len, len);
-		if (!src) {
-			early_efi_unmap(dst, len);
-			return;
-		}
-
-		memmove(dst, src, len);
-
-		early_efi_unmap(src, len);
-		early_efi_unmap(dst, len);
-	}
-}
-
-static void early_efi_write_char(u32 *dst, unsigned char c, unsigned int h)
-{
-	const u32 color_black = 0x00000000;
-	const u32 color_white = 0x00ffffff;
-	const u8 *src;
-	u8 s8;
-	int m;
-
-	src = font->data + c * font->height;
-	s8 = *(src + h);
-
-	for (m = 0; m < 8; m++) {
-		if ((s8 >> (7 - m)) & 1)
-			*dst = color_white;
-		else
-			*dst = color_black;
-		dst++;
-	}
-}
-
-static void
-early_efi_write(struct console *con, const char *str, unsigned int num)
-{
-	struct screen_info *si;
-	unsigned int len;
-	const char *s;
-	void *dst;
-
-	si = &boot_params.screen_info;
-	len = si->lfb_linelength;
-
-	while (num) {
-		unsigned int linemax;
-		unsigned int h, count = 0;
-
-		for (s = str; *s && *s != '\n'; s++) {
-			if (count == num)
-				break;
-			count++;
-		}
-
-		linemax = (si->lfb_width - efi_x) / font->width;
-		if (count > linemax)
-			count = linemax;
-
-		for (h = 0; h < font->height; h++) {
-			unsigned int n, x;
-
-			dst = early_efi_map((efi_y + h) * len, len);
-			if (!dst)
-				return;
-
-			s = str;
-			n = count;
-			x = efi_x;
-
-			while (n-- > 0) {
-				early_efi_write_char(dst + x*4, *s, h);
-				x += font->width;
-				s++;
-			}
-
-			early_efi_unmap(dst, len);
-		}
-
-		num -= count;
-		efi_x += count * font->width;
-		str += count;
-
-		if (num > 0 && *s == '\n') {
-			efi_x = 0;
-			efi_y += font->height;
-			str++;
-			num--;
-		}
-
-		if (efi_x + font->width > si->lfb_width) {
-			efi_x = 0;
-			efi_y += font->height;
-		}
-
-		if (efi_y + font->height > si->lfb_height) {
-			u32 i;
-
-			efi_y -= font->height;
-			early_efi_scroll_up();
-
-			for (i = 0; i < font->height; i++)
-				early_efi_clear_scanline(efi_y + i);
-		}
-	}
-}
-
-static __init int early_efi_setup(struct console *con, char *options)
-{
-	struct screen_info *si;
-	u16 xres, yres;
-	u32 i;
-
-	si = &boot_params.screen_info;
-	xres = si->lfb_width;
-	yres = si->lfb_height;
-
-	/*
-	 * early_efi_write_char() implicitly assumes a framebuffer with
-	 * 32-bits per pixel.
-	 */
-	if (si->lfb_depth != 32)
-		return -ENODEV;
-
-	font = get_default_font(xres, yres, -1, -1);
-	if (!font)
-		return -ENODEV;
-
-	efi_y = rounddown(yres, font->height) - font->height;
-	for (i = 0; i < (yres - efi_y) / font->height; i++)
-		early_efi_scroll_up();
-
-	/* early_console_register will unset CON_BOOT in case ,keep */
-	if (!(con->flags & CON_BOOT))
-		early_efi_keep = true;
-	return 0;
-}
-
-struct console early_efi_console = {
-	.name =		"earlyefi",
-	.write =	early_efi_write,
-	.setup =	early_efi_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-};
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 89110dfc7127..3b2f12fa620c 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -198,3 +198,9 @@ config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
 	default n
+
+config EFI_EARLYCON
+	def_bool y
+	depends on SERIAL_EARLYCON && !ARM
+	select FONT_SUPPORT
+	select ARCH_USE_MEMREMAP_PROT
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 5f9f5039de50..d2d0d2030620 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -30,5 +30,6 @@ arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
+obj-$(CONFIG_EFI_EARLYCON)		+= earlycon.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
 obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
new file mode 100644
index 000000000000..163d8204b190
--- /dev/null
+++ b/drivers/firmware/efi/earlycon.c
@@ -0,0 +1,208 @@
+/*
+ * Copyright (C) 2013 Intel Corporation; author Matt Fleming
+ *
+ *  This file is part of the Linux kernel, and is made available under
+ *  the terms of the GNU General Public License version 2.
+ */
+
+#include <linux/console.h>
+#include <linux/efi.h>
+#include <linux/font.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/serial_core.h>
+#include <linux/screen_info.h>
+
+#include <asm/early_ioremap.h>
+
+static const struct font_desc *font;
+static u32 efi_x, efi_y;
+static u64 fb_base;
+static pgprot_t fb_prot;
+
+static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
+{
+	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
+}
+
+static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
+{
+	early_memunmap(addr, len);
+}
+
+static void efi_earlycon_clear_scanline(unsigned int y)
+{
+	unsigned long *dst;
+	u16 len;
+
+	len = screen_info.lfb_linelength;
+	dst = efi_earlycon_map(y*len, len);
+	if (!dst)
+		return;
+
+	memset(dst, 0, len);
+	efi_earlycon_unmap(dst, len);
+}
+
+static void efi_earlycon_scroll_up(void)
+{
+	unsigned long *dst, *src;
+	u16 len;
+	u32 i, height;
+
+	len = screen_info.lfb_linelength;
+	height = screen_info.lfb_height;
+
+	for (i = 0; i < height - font->height; i++) {
+		dst = efi_earlycon_map(i*len, len);
+		if (!dst)
+			return;
+
+		src = efi_earlycon_map((i + font->height) * len, len);
+		if (!src) {
+			efi_earlycon_unmap(dst, len);
+			return;
+		}
+
+		memmove(dst, src, len);
+
+		efi_earlycon_unmap(src, len);
+		efi_earlycon_unmap(dst, len);
+	}
+}
+
+static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
+{
+	const u32 color_black = 0x00000000;
+	const u32 color_white = 0x00ffffff;
+	const u8 *src;
+	u8 s8;
+	int m;
+
+	src = font->data + c * font->height;
+	s8 = *(src + h);
+
+	for (m = 0; m < 8; m++) {
+		if ((s8 >> (7 - m)) & 1)
+			*dst = color_white;
+		else
+			*dst = color_black;
+		dst++;
+	}
+}
+
+static void
+efi_earlycon_write(struct console *con, const char *str, unsigned int num)
+{
+	struct screen_info *si;
+	unsigned int len;
+	const char *s;
+	void *dst;
+
+	si = &screen_info;
+	len = si->lfb_linelength;
+
+	while (num) {
+		unsigned int linemax;
+		unsigned int h, count = 0;
+
+		for (s = str; *s && *s != '\n'; s++) {
+			if (count == num)
+				break;
+			count++;
+		}
+
+		linemax = (si->lfb_width - efi_x) / font->width;
+		if (count > linemax)
+			count = linemax;
+
+		for (h = 0; h < font->height; h++) {
+			unsigned int n, x;
+
+			dst = efi_earlycon_map((efi_y + h) * len, len);
+			if (!dst)
+				return;
+
+			s = str;
+			n = count;
+			x = efi_x;
+
+			while (n-- > 0) {
+				efi_earlycon_write_char(dst + x*4, *s, h);
+				x += font->width;
+				s++;
+			}
+
+			efi_earlycon_unmap(dst, len);
+		}
+
+		num -= count;
+		efi_x += count * font->width;
+		str += count;
+
+		if (num > 0 && *s == '\n') {
+			efi_x = 0;
+			efi_y += font->height;
+			str++;
+			num--;
+		}
+
+		if (efi_x + font->width > si->lfb_width) {
+			efi_x = 0;
+			efi_y += font->height;
+		}
+
+		if (efi_y + font->height > si->lfb_height) {
+			u32 i;
+
+			efi_y -= font->height;
+			efi_earlycon_scroll_up();
+
+			for (i = 0; i < font->height; i++)
+				efi_earlycon_clear_scanline(efi_y + i);
+		}
+	}
+}
+
+static int __init efi_earlycon_setup(struct earlycon_device *device,
+				     const char *opt)
+{
+	struct screen_info *si;
+	u16 xres, yres;
+	u32 i;
+
+	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
+		return -ENODEV;
+
+	fb_base = screen_info.lfb_base;
+	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)screen_info.ext_lfb_base << 32;
+
+	if (opt && !strcmp(opt, "ram"))
+		fb_prot = PAGE_KERNEL;
+	else
+		fb_prot = pgprot_writecombine(PAGE_KERNEL);
+
+	si = &screen_info;
+	xres = si->lfb_width;
+	yres = si->lfb_height;
+
+	/*
+	 * efi_earlycon_write_char() implicitly assumes a framebuffer with
+	 * 32-bits per pixel.
+	 */
+	if (si->lfb_depth != 32)
+		return -ENODEV;
+
+	font = get_default_font(xres, yres, -1, -1);
+	if (!font)
+		return -ENODEV;
+
+	efi_y = rounddown(yres, font->height) - font->height;
+	for (i = 0; i < (yres - efi_y) / font->height; i++)
+		efi_earlycon_scroll_up();
+
+	device->con->write = efi_earlycon_write;
+	return 0;
+}
+EARLYCON_DECLARE(efifb, efi_earlycon_setup);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
