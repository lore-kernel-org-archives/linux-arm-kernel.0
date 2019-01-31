Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1954C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:57:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3C182082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uiJa33pO";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KxJQkw1P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="t4Dhfll4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C182082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tT2RGpzx0SP4kw/6xLkKak2rPvr9Scj4fj823BBrLNg=; b=uiJa33pONockHi
	f+SHPruoFB9t5UXOW3GWUg5xkak4ge13IhS0r6RhHZKK7CI9hgCEMBXUX5MCYc0kQU6el9ZP4forK
	KVUB7E3mDn8ah3MDxbmhqWWoTKeKtcthOyeIKwuGEl6Ka7gu1z21U1SaQ1nzsZTHOAZZ7UH0dNVzd
	6GKDAiadg0qLrXhlKQaB5BCxvJubH7Q7CAJBY+4U+5NoT+XFMnTQA7Jy8tY2/emTLSIFG9KLeVCSN
	bbm0FUNNbFa2gqZnHUWIOyt0xkD/wyNEEfjQOTA88fnqPIDnWtT8vgxW98Qq/ckRIiKKX0hdOHkdQ
	j3IaChn5S3oCLhVqWVMQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCqH-0001wr-H9; Thu, 31 Jan 2019 13:57:21 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCoj-0000NU-Ql
 for linux-arm-kernel@bombadil.infradead.org; Thu, 31 Jan 2019 13:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K5vMBO4aqrhzgeSw21nioDJfMcdmFayCNuqBHxzCinc=; b=KxJQkw1PoZNgaxy1bLi2ZthW+i
 kuz/4pySxy8vcxQ8kt0C23eW2J0zps9QwejrhV1fJciuncCmSpGUUZ8qFIhv2Q3r7e00+HLx9pUv/
 Kwq4vVvkpElXcE7Rqj3iUGOin2L6qyXc469yghNX05u7cwJQtTY2ILUn7/H6iJmqzmiad7VW0Ihsu
 YRsoJRtQuAUwzU9pLz7YH6dRbLThQtLzfRWDtpupGMTMVFUxZwhKgwemRDP3PzJ7rVGeL+CjZ88O/
 RhibFj6F9593MTtXI6FuSYMAoWxSQh+GE4leZ2R9nmgW2BW8zWw9OPFvzZmG8R2q37uIQs9R/MTgh
 C8mAvo8A==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZa-000595-I9
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:40:13 +0000
Received: by mail-wr1-x441.google.com with SMTP id s12so3342130wrt.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=K5vMBO4aqrhzgeSw21nioDJfMcdmFayCNuqBHxzCinc=;
 b=t4Dhfll4FUhhKqT5NS/ho9aZ106LH3gvp2RZ4l+k/jeHbcR2XkT2RUutoBUP/kuntp
 0csrkM6Ll5qka5MJ64qDlFk7BBR75rEoxN8+ZscVTPdvNLov0XF3V5RFCXtsnBF/Y1HZ
 popx0r0k/zssRDtMemaSIE6t4EV89UF3LMMUjMo9mJsJqtKKe47NO9ojGRZ209n69HtY
 mxJKYITNrObAVYY8C7Os7GwdEBJziWjatG2ofjnMpveHD1BAag+VTirjYFYnVsLSK0AQ
 2EMb37vU66DtliZY7i6OpjXnbol2AJKSIwMxfQYnoHaHQ7t6/O9LxeVPtIBqzW8LASYY
 KCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K5vMBO4aqrhzgeSw21nioDJfMcdmFayCNuqBHxzCinc=;
 b=sLgaiH+Jdb+6lu4vuT+qTgoQuYo9HhT6gUqi+LlimKDER8CKUBq73SzaegGdOXo5/n
 91xCepR0VhDCe3fKQah/37DDGEAns7j2EcxHbN0fyRNxegf3SYzVjTzi8FsZWtWSAHxJ
 dshx6i6qsb4FjmHw3Ez0Lcy6prC2ua5BEwoDxxZBGkCodPPcrGPTntUevuZrFG7qjuJ3
 bxi5pDVnC1eNIAT1ChskbR1uOPMh5Q3F7rjpJulXAqdixY9wEE12q0Sb7dU1JP++43oW
 k05fXF4ntgZoTMkRecrWEXUNo95X4455x6x33AZ0y3TNptRTQOTtmJpDDas2o/BFL+fA
 khHg==
X-Gm-Message-State: AJcUukfIQWTd6LhiHDM0YcADXRQhWSVbZKnALmiGZpynAsRup1QmCioQ
 12yuBRQ8upLvoqTqBzH3XPLhSw==
X-Google-Smtp-Source: ALg8bN5hUwCJjr1gj4uhLw8ONv9cOqoXimEo8PzFjEShjsowbkc8ULqWmH+L/oRnF//7MOLQ8eP9Kw==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr33108437wrv.308.1548942005475; 
 Thu, 31 Jan 2019 05:40:05 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.40.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:40:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 20/35] ARM: davinci: cp-intc: add a wrapper around
 cp_intc_init()
Date: Thu, 31 Jan 2019 14:39:13 +0100
Message-Id: <20190131133928.17985-21-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_134006_706078_CFD6F43C 
X-CRM114-Status: GOOD (  16.60  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We're going to extend the cp_intc_init() function with a config
structure so we can drop the intc-related fields from davinci_soc_info.

Once we do it, we won't be able to use this routine directly as the
init_irq callback. Wrap the calls in additional helpers that don't
take parameters and can be assigned to init_irq.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/board-da830-evm.c     | 2 +-
 arch/arm/mach-davinci/board-da850-evm.c     | 2 +-
 arch/arm/mach-davinci/board-mityomapl138.c  | 2 +-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 2 +-
 arch/arm/mach-davinci/da830.c               | 5 +++++
 arch/arm/mach-davinci/da850.c               | 5 +++++
 arch/arm/mach-davinci/include/mach/da8xx.h  | 2 ++
 7 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 4c1836fa654e..b3a0148f7f1a 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -693,7 +693,7 @@ static void __init da830_evm_map_io(void)
 MACHINE_START(DAVINCI_DA830_EVM, "DaVinci DA830/OMAP-L137/AM17x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da830_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da830_init_irqs,
 	.init_time	= da830_init_time,
 	.init_machine	= da830_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 548a3c351c02..efc9a33da6e1 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1521,7 +1521,7 @@ static void __init da850_evm_map_io(void)
 MACHINE_START(DAVINCI_DA850_EVM, "DaVinci DA850/OMAP-L138/AM18x EVM")
 	.atag_offset	= 0x100,
 	.map_io		= da850_evm_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irqs,
 	.init_time	= da850_init_time,
 	.init_machine	= da850_evm_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index eb6a9465f229..59a6f5db4222 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -623,7 +623,7 @@ static void __init mityomapl138_map_io(void)
 MACHINE_START(MITYOMAPL138, "MityDSP-L138/MityARM-1808")
 	.atag_offset	= 0x100,
 	.map_io		= mityomapl138_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irqs,
 	.init_time	= da850_init_time,
 	.init_machine	= mityomapl138_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 7f852722ff08..af6580ce71eb 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -461,7 +461,7 @@ static void __init omapl138_hawk_map_io(void)
 MACHINE_START(OMAPL138_HAWKBOARD, "AM18x/OMAP-L138 Hawkboard")
 	.atag_offset	= 0x100,
 	.map_io		= omapl138_hawk_map_io,
-	.init_irq	= cp_intc_init,
+	.init_irq	= da850_init_irqs,
 	.init_time	= da850_init_time,
 	.init_machine	= omapl138_hawk_init,
 	.init_late	= davinci_init_late,
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index f1e7b6c644e5..8b9220badef5 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -742,6 +742,11 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+void __init da830_init_irqs(void)
+{
+	cp_intc_init();
+}
+
 void __init da830_init_time(void)
 {
 	void __iomem *pll;
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 40b90730e847..9f48e1ac61fb 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -671,6 +671,11 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+void __init da850_init_irqs(void)
+{
+	cp_intc_init();
+}
+
 void __init da850_init_time(void)
 {
 	void __iomem *pll0;
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index ab4a57f433f4..a5b4b1b964fd 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -88,10 +88,12 @@ extern unsigned int da850_max_speed;
 #define DA8XX_ARM_RAM_BASE	0xffff0000
 
 void da830_init(void);
+void da830_init_irqs(void);
 void da830_init_time(void);
 void da830_register_clocks(void);
 
 void da850_init(void);
+void da850_init_irqs(void);
 void da850_init_time(void);
 void da850_register_clocks(void);
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
