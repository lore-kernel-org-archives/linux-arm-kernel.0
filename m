Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E1C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:19:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEA0D2133D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cnddCGhG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SDHUpGt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEA0D2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7+6NW6llFNdZaiUV88fr3oVRhoSNY2ypRRQyKKoHBeA=; b=cnddCGhGqkgzJj
	DN64cCH5eciAMBeHrfF31URm0rXzqTwoJfzD0CSOtTRoHnt+IEO+qHXP/Wmt46jVFAFE4AWZXJAGB
	4hw0PwUavg2uQklz5BMnX271hNvkGeonyp4Fi6+xrrdnjc/XDOtnSKRNKPyFBlykK2HZ+rkpLhcHD
	+ZwTYPRwLHokkqA3MOjLZtTG3/idp3yChS7R6xHXFn5UghjA9xqKO0QTqyKytptGIaQ7nh4/OiHlq
	+KwC7r1Qks7aUsCEag/hf0U7q7sz2uPHBcbCOithwUMY1Ar0G0DEJvJk48rbVFpfjvn/Gdy0l2oq0
	yZaQCYoo39Vs9S35c0DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn4C4-0007TD-O1; Fri, 25 Jan 2019 16:19:00 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn4BL-0006sE-LH
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 16:18:17 +0000
Received: by mail-wr1-x444.google.com with SMTP id v13so10893330wrw.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e7hfRvg7EEhxEIz+7R4VwPzkii6wW86sMkKig71bHEE=;
 b=SDHUpGt+8TN/adOdB+I9ciV4r97DoDbJFfbW2tBTMFHGdO/UeqpmLT8LLU6ooUMY6W
 FQ1KZ/3k57t+OWKugtx0igQIo+NphRE5EAXfHPXj5+48+150b3n8d/3vfB9Dua7RBHYN
 28r16qK8gL+oUFsrIj9C8xWbvQFIfKgWvFSDE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e7hfRvg7EEhxEIz+7R4VwPzkii6wW86sMkKig71bHEE=;
 b=ADLsAfe5Xp4EGivY7XDLR97e1YEGYfWYEwTbgzXkM2lgviWzMH10CKUO90gOJKNkz9
 ARGbXcNnfqGbXOKyReNgd16hM8935suqPoHYJ95QzdO9fZ/dx+cb9oLOVUgNV+hs1CmK
 LKdNGqHl18h68D/60rtN1sFYMZV89IVQiZqxw7IcfZw6cbUlioFao86lYsvgnVPAeQ/g
 VQCFbuzoyND74H85nU/NY2N41A1MSQou5Yf7eZ8/0mN0DL2Q+EAX9HiLYSEDLKn/Rs/M
 ccpiqvz9Lcd6+w/B/1QpkGZZacHnXMpxArmygPh/0cxvjTE72iTKtnPQLmkfwOcwL9qb
 OpLA==
X-Gm-Message-State: AJcUukcudxRBN6T2gdVzKu2EWAyBZVAijj3nLQ0IsT4fik4X9ZbwoeVc
 OKuxFC+z0GetCmmQorxv9Fqv2Q==
X-Google-Smtp-Source: ALg8bN7N1c+TDtP1asRYGjmlMml21k9zDWhJikXvKQTvEyy1MD509ZahoeLOSgsHUi8d1Fv5LK5soQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr11814287wrs.290.1548433093909; 
 Fri, 25 Jan 2019 08:18:13 -0800 (PST)
Received: from localhost.localdomain
 (laubervilliers-657-1-83-120.w92-154.abo.wanadoo.fr. [92.154.90.120])
 by smtp.gmail.com with ESMTPSA id t76sm68987212wme.33.2019.01.25.08.18.12
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 08:18:12 -0800 (PST)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: linux-efi@vger.kernel.org
Subject: [PATCH 2/2] efi: arm64: Enable earlycon for the GOP framebuffer
Date: Fri, 25 Jan 2019 17:18:06 +0100
Message-Id: <20190125161806.13472-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125161806.13472-1-ard.biesheuvel@linaro.org>
References: <20190125161806.13472-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_081815_691865_F96522A8 
X-CRM114-Status: GOOD (  19.31  )
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

This repurposes the existing EFI earlyprintk support and exposes it
as an earlycon implementation, which can be enabled by passing the
kernel parameter 'earlycon=efi' on the command line.

Note that the early console is initialized before we have discovered
anything about the memory map, and so we cannot determine automatically
whether the framebuffer is backed by system memory that must be mapped
with cacheable attributes. So instead, a 'ram' earlycon option is
implemented to force this manually.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 ++++-
 arch/arm64/include/asm/efi.h                    |  6 +++
 drivers/firmware/efi/Kconfig                    |  1 +
 drivers/firmware/efi/earlycon.c                 | 42 +++++++++++++++-----
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b799bcf67d7b..be6b4972cc3c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1073,9 +1073,16 @@
 			specified address. The serial port must already be
 			setup and configured. Options are not yet supported.
 
+		efi[,options]                       # arm64 or x86
+			Start an early, unaccelerated console on the EFI
+			framebuffer. On DMA coherent arm64 systems that use
+			system memory for the framebuffer, pass the 'ram'
+			option so that it is mapped with the correct
+			attributes.
+
 	earlyprintk=	[X86,SH,ARM,M68k,S390]
 			earlyprintk=vga
-			earlyprintk=efi
+			earlyprintk=efi             # x86 only
 			earlyprintk=sclp
 			earlyprintk=xen
 			earlyprintk=serial[,ttySn[,baudrate]]
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 7ed320895d1f..7f555f1c8d48 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -11,6 +11,7 @@
 #include <asm/neon.h>
 #include <asm/ptrace.h>
 #include <asm/tlbflush.h>
+#include <linux/screen_info.h>
 
 #ifdef CONFIG_EFI
 extern void efi_init(void);
@@ -149,4 +150,9 @@ static inline void efi_set_pgd(struct mm_struct *mm)
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
+static inline struct screen_info *efi_get_screen_info(void)
+{
+	return &screen_info;
+}
+
 #endif /* _ASM_EFI_H */
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 70335c7f0fe4..9d67aab94cbf 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -201,4 +201,5 @@ config EFI_DEV_PATH_PARSER
 
 config UEFI_EARLYCON
 	bool
+	default y if ARM64
 	select FONT_SUPPORT
diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index c065c482d12b..4e8dba21673e 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -10,13 +10,17 @@
 #include <linux/font.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/serial_core.h>
 #include <asm/efi.h>
 
 static const struct font_desc *font;
 static u32 efi_x, efi_y;
 static void *efi_fb;
 static bool early_efi_keep;
+static bool fb_is_ram;
+static u64 fb_base;
 
+#ifdef CONFIG_EARLY_PRINTK_EFI
 /*
  * efi earlyprintk need use early_ioremap to map the framebuffer.
  * But early_ioremap is not usable for earlyprintk=efi,keep, ioremap should
@@ -40,6 +44,7 @@ static __init int early_efi_map_fb(void)
 	return efi_fb ? 0 : -ENOMEM;
 }
 early_initcall(early_efi_map_fb);
+#endif
 
 /*
  * early_efi_map maps efi framebuffer region [start, start + len -1]
@@ -48,21 +53,21 @@ early_initcall(early_efi_map_fb);
  */
 static __ref void *early_efi_map(unsigned long start, unsigned long len)
 {
-	u64 base;
-
-	base = efi_get_screen_info()->lfb_base;
-	if (efi_get_screen_info()->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)efi_get_screen_info()->ext_lfb_base << 32;
-
 	if (efi_fb)
 		return (efi_fb + start);
+	else if (fb_is_ram)
+		return early_memremap(fb_base + start, len);
 	else
-		return early_ioremap(base + start, len);
+		return early_ioremap(fb_base + start, len);
 }
 
 static __ref void early_efi_unmap(void *addr, unsigned long len)
 {
-	if (!efi_fb)
+	if (efi_fb)
+		return;
+	if (fb_is_ram)
+		early_memunmap(addr, len);
+	else
 		early_iounmap(addr, len);
 }
 
@@ -210,6 +215,10 @@ static __init int early_efi_setup(struct console *con, char *options)
 	xres = si->lfb_width;
 	yres = si->lfb_height;
 
+	fb_base = efi_get_screen_info()->lfb_base;
+	if (efi_get_screen_info()->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
+		fb_base |= (u64)efi_get_screen_info()->ext_lfb_base << 32;
+
 	/*
 	 * early_efi_write_char() implicitly assumes a framebuffer with
 	 * 32-bits per pixel.
@@ -226,11 +235,12 @@ static __init int early_efi_setup(struct console *con, char *options)
 		early_efi_scroll_up();
 
 	/* early_console_register will unset CON_BOOT in case ,keep */
-	if (!(con->flags & CON_BOOT))
+	if (con && !(con->flags & CON_BOOT))
 		early_efi_keep = true;
 	return 0;
 }
 
+#ifdef CONFIG_EARLY_PRINTK_EFI
 struct console early_efi_console = {
 	.name =		"earlyefi",
 	.write =	early_efi_write,
@@ -238,3 +248,17 @@ struct console early_efi_console = {
 	.flags =	CON_PRINTBUFFER,
 	.index =	-1,
 };
+#endif
+
+static int __init efi_earlycon_setup(struct earlycon_device *device,
+				     const char *opt)
+{
+	if (efi_get_screen_info()->orig_video_isVGA != VIDEO_TYPE_EFI)
+		return -ENODEV;
+
+	device->con->write = early_efi_write;
+	early_efi_setup(NULL, NULL);
+	fb_is_ram = !strcmp(opt, "ram");
+	return 0;
+}
+EARLYCON_DECLARE(efi, efi_earlycon_setup);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
