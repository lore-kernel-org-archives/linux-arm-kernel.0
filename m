Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5092DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:52:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD45E2087F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 11:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oaQU3Pnn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnV6OeKi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD45E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jey5lRh70cWr+hlO6ozvfA3RznF4y4T4fUrrqbeqde0=; b=oaQU3PnniIFhwA
	haL6T3QSDsdwnS3pW7MziFTtkcSRnHhy2InE1nIU84oGy6XQzZczvy7mIVCG8oMFmedrv90UWZVaf
	wFDdwImGFxUZCzynHimApFnopyhGY5ENXHFbLCe+OiwPzjFOFDn393LaQ2m+Q/zlFvEM6mIT8l+TM
	pa9bfKUt3/781cznt4a32DfB6bqNcbUXZk9DtqYLSlZCjT/omsERbcwADxt5fZzqEVdDFrBnMs/Xq
	RQeSOL3uOVeAl0n3leaMOAZmgWDpxGwN5g2T9x8Dd8XF1hMcuk2mY4P/3MJBIHlA9/vEK4VORYbgX
	b4QqwI1VzGJ9LPVmLUkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpAtS-0004hO-Nk; Thu, 31 Jan 2019 11:52:30 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpAst-0004Ey-By
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 11:51:58 +0000
Received: by mail-wr1-x441.google.com with SMTP id p7so2993058wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 03:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=wbMPzpn8NfRgi7RFPH4XE4+uwdPNc56zI0O9bxK6Lg4=;
 b=jnV6OeKi40I3j9lndUeZXwG6TGAcis1nStHp2Ah/zfxLsgeEkthu7OQfjT2jDkwrxS
 QWA3sYMkEycGAwfZi+j0GNoJqFXNvqPqsQS+2tbQBM0FWCv66j28D/7a1wsM1WkkuMSb
 7dcA9ozZf5FFaTlq/f1zFqrCLHVr8rAIDptC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=wbMPzpn8NfRgi7RFPH4XE4+uwdPNc56zI0O9bxK6Lg4=;
 b=mIsogt4rUzvU/vC2xkB/v2+jD8yuuQvVGVzWTlbL0lkK2A/XYfRMOcP3sTXXvrBtsR
 8s9QnfZvIqwdlYrluO+yP/YuOWKEIgiMDEjhDbwYZMZlkTmGJDK/EIT3nrYOGxdiTfoP
 2mai3jd58fjwNA+wl42Zn56CK/rOkhtndR5vz+j3NadIEba2P+TQvAgHiwSToQWci4+O
 ltF4E/mpEkRWa4kYe7q8ZrGJ4RpdFyQ/zSCYm1yi58QzqH6doxeTic44jvqgje6Jg1PM
 oxa6dZJwsARY0KoBdQqw1GkDzNs+UZum9MZ0Q/O3Jwb+PRMGvYxFzPYS4K+SKLz651yf
 m+EA==
X-Gm-Message-State: AJcUukexiOo2/cv3cNl0Hr38Z96icGV/8fHFXU+bTPUD1Fqp2VeIpfzG
 7FCnfG+6Elxp9TDJWfuq2dpPPg==
X-Google-Smtp-Source: ALg8bN42DydoMVwegFD/F8SROPV7s999cqvg7zHs+gygQrSzwc+sXNvrPHGXiKl8uNteD3C+aOZL9A==
X-Received: by 2002:adf:e891:: with SMTP id d17mr36704197wrm.140.1548935513681; 
 Thu, 31 Jan 2019 03:51:53 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-39-7.w90-86.abo.wanadoo.fr. [90.86.94.7])
 by smtp.gmail.com with ESMTPSA id w10sm5807714wmb.1.2019.01.31.03.51.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 03:51:52 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH v3 2/2] efi: x86: convert x86 EFI earlyprintk into generic
 earlycon implementation
Date: Thu, 31 Jan 2019 12:51:45 +0100
Message-Id: <20190131115145.4634-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131115145.4634-1-ard.biesheuvel@linaro.org>
References: <20190131115145.4634-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_035155_430151_C64F766B 
X-CRM114-Status: GOOD (  24.71  )
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
 corbet@lwn.net, pjones@redhat.com, x86@kernel.org, linux-doc@vger.kernel.org,
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
enough for earlycon=efifb to work, nor is its early_memremap operational
early enough, so it is disabled there. Itanium has its own
asm/early_ioremap.h header which does not declare early_memremap_prot
(and it never implemented earlyprintk=efi in the first place) so
let's just disable it there as well.

Reviewed-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt                         |   8 +-
 arch/x86/Kconfig.debug                                                  |  10 --
 arch/x86/include/asm/efi.h                                              |   1 -
 arch/x86/kernel/early_printk.c                                          |   4 -
 arch/x86/platform/efi/Makefile                                          |   1 -
 drivers/firmware/efi/Kconfig                                            |   6 +
 drivers/firmware/efi/Makefile                                           |   1 +
 arch/x86/platform/efi/early_printk.c => drivers/firmware/efi/earlycon.c | 130 ++++++++------------
 8 files changed, 63 insertions(+), 98 deletions(-)

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
index a37378f986ec..08ebb2270d87 100644
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
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 89110dfc7127..190be0b1d109 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -198,3 +198,9 @@ config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
 	default n
+
+config EFI_EARLYCON
+	def_bool y
+	depends on SERIAL_EARLYCON && !ARM && !IA64
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
diff --git a/arch/x86/platform/efi/early_printk.c b/drivers/firmware/efi/earlycon.c
similarity index 45%
rename from arch/x86/platform/efi/early_printk.c
rename to drivers/firmware/efi/earlycon.c
index 7138bc7a265c..163d8204b190 100644
--- a/arch/x86/platform/efi/early_printk.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -10,104 +10,68 @@
 #include <linux/font.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <asm/setup.h>
+#include <linux/serial_core.h>
+#include <linux/screen_info.h>
+
+#include <asm/early_ioremap.h>
 
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
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
+static u64 fb_base;
+static pgprot_t fb_prot;
 
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
+static __ref void *efi_earlycon_map(unsigned long start, unsigned long len)
 {
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
+	return early_memremap_prot(fb_base + start, len, pgprot_val(fb_prot));
 }
 
-static __ref void early_efi_unmap(void *addr, unsigned long len)
+static __ref void efi_earlycon_unmap(void *addr, unsigned long len)
 {
-	if (!efi_fb)
-		early_iounmap(addr, len);
+	early_memunmap(addr, len);
 }
 
-static void early_efi_clear_scanline(unsigned int y)
+static void efi_earlycon_clear_scanline(unsigned int y)
 {
 	unsigned long *dst;
 	u16 len;
 
-	len = boot_params.screen_info.lfb_linelength;
-	dst = early_efi_map(y*len, len);
+	len = screen_info.lfb_linelength;
+	dst = efi_earlycon_map(y*len, len);
 	if (!dst)
 		return;
 
 	memset(dst, 0, len);
-	early_efi_unmap(dst, len);
+	efi_earlycon_unmap(dst, len);
 }
 
-static void early_efi_scroll_up(void)
+static void efi_earlycon_scroll_up(void)
 {
 	unsigned long *dst, *src;
 	u16 len;
 	u32 i, height;
 
-	len = boot_params.screen_info.lfb_linelength;
-	height = boot_params.screen_info.lfb_height;
+	len = screen_info.lfb_linelength;
+	height = screen_info.lfb_height;
 
 	for (i = 0; i < height - font->height; i++) {
-		dst = early_efi_map(i*len, len);
+		dst = efi_earlycon_map(i*len, len);
 		if (!dst)
 			return;
 
-		src = early_efi_map((i + font->height) * len, len);
+		src = efi_earlycon_map((i + font->height) * len, len);
 		if (!src) {
-			early_efi_unmap(dst, len);
+			efi_earlycon_unmap(dst, len);
 			return;
 		}
 
 		memmove(dst, src, len);
 
-		early_efi_unmap(src, len);
-		early_efi_unmap(dst, len);
+		efi_earlycon_unmap(src, len);
+		efi_earlycon_unmap(dst, len);
 	}
 }
 
-static void early_efi_write_char(u32 *dst, unsigned char c, unsigned int h)
+static void efi_earlycon_write_char(u32 *dst, unsigned char c, unsigned int h)
 {
 	const u32 color_black = 0x00000000;
 	const u32 color_white = 0x00ffffff;
@@ -128,14 +92,14 @@ static void early_efi_write_char(u32 *dst, unsigned char c, unsigned int h)
 }
 
 static void
-early_efi_write(struct console *con, const char *str, unsigned int num)
+efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 {
 	struct screen_info *si;
 	unsigned int len;
 	const char *s;
 	void *dst;
 
-	si = &boot_params.screen_info;
+	si = &screen_info;
 	len = si->lfb_linelength;
 
 	while (num) {
@@ -155,7 +119,7 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 		for (h = 0; h < font->height; h++) {
 			unsigned int n, x;
 
-			dst = early_efi_map((efi_y + h) * len, len);
+			dst = efi_earlycon_map((efi_y + h) * len, len);
 			if (!dst)
 				return;
 
@@ -164,12 +128,12 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 			x = efi_x;
 
 			while (n-- > 0) {
-				early_efi_write_char(dst + x*4, *s, h);
+				efi_earlycon_write_char(dst + x*4, *s, h);
 				x += font->width;
 				s++;
 			}
 
-			early_efi_unmap(dst, len);
+			efi_earlycon_unmap(dst, len);
 		}
 
 		num -= count;
@@ -192,26 +156,39 @@ early_efi_write(struct console *con, const char *str, unsigned int num)
 			u32 i;
 
 			efi_y -= font->height;
-			early_efi_scroll_up();
+			efi_earlycon_scroll_up();
 
 			for (i = 0; i < font->height; i++)
-				early_efi_clear_scanline(efi_y + i);
+				efi_earlycon_clear_scanline(efi_y + i);
 		}
 	}
 }
 
-static __init int early_efi_setup(struct console *con, char *options)
+static int __init efi_earlycon_setup(struct earlycon_device *device,
+				     const char *opt)
 {
 	struct screen_info *si;
 	u16 xres, yres;
 	u32 i;
 
-	si = &boot_params.screen_info;
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
 	xres = si->lfb_width;
 	yres = si->lfb_height;
 
 	/*
-	 * early_efi_write_char() implicitly assumes a framebuffer with
+	 * efi_earlycon_write_char() implicitly assumes a framebuffer with
 	 * 32-bits per pixel.
 	 */
 	if (si->lfb_depth != 32)
@@ -223,18 +200,9 @@ static __init int early_efi_setup(struct console *con, char *options)
 
 	efi_y = rounddown(yres, font->height) - font->height;
 	for (i = 0; i < (yres - efi_y) / font->height; i++)
-		early_efi_scroll_up();
+		efi_earlycon_scroll_up();
 
-	/* early_console_register will unset CON_BOOT in case ,keep */
-	if (!(con->flags & CON_BOOT))
-		early_efi_keep = true;
+	device->con->write = efi_earlycon_write;
 	return 0;
 }
-
-struct console early_efi_console = {
-	.name =		"earlyefi",
-	.write =	early_efi_write,
-	.setup =	early_efi_setup,
-	.flags =	CON_PRINTBUFFER,
-	.index =	-1,
-};
+EARLYCON_DECLARE(efifb, efi_earlycon_setup);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
