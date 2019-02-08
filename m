Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C02DC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:51:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FD2220863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u8ZrRzl0";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EPME40rB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="o6PhnZun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD2220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z3TXJyyJ0MDIV3EbX8MIQKmHLCWIVI28NbNeoo+gbiM=; b=u8ZrRzl0aRDPhh
	WLX74NN9mGkLa1rLw4kXOSbCfW+pfrHP8Ziyesd3rk+4INsgO7ko//+FOU5fKx1lhuApJ0q46tv+q
	pxuvyxLOCKZ8g7IHXvKKgVEk8GeJmGH1p+IF/n2CJTqg9iyzGTf2kltQNS+YfG33V1Cow1u4IWLss
	mwGRdYHNkAaYCZ2ljUpzqHYbEdEtOAFL01XLGSngACxrtpveteXtYzo72yHpjogLtGHERz2cElGta
	wvoeW/EpjYw+kXErRbKMxJFtnD5H9wGTBZBTQ+PmSKYeGpEVBaU9rjq9JggB2Sffxjx0yvBoCDRfn
	rqgUToBw8fdJumsw/2Cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAJX-0004ma-C6; Fri, 08 Feb 2019 17:51:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsAJB-0003t2-4s
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 17:51:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E2oKCm2aHyIkLmsWfLt1xuMZ3si46gMPXE7rlXDV4Gg=; b=EPME40rBtIlnFy9mIZrqNvbzLt
 rpbZmsQ3Reh8Vp/cns0+FK2ploxU1KLgjwS32xZ7Gnw7dXkDqEkDa2CmvchPLAjYZfzbMdYizohIM
 rHHBZzEKBy5yTTdOyFo/c6I3tV+LsXanb8qTzdIuWLvydVphABBQIiCXP+VE1UwPAvsTUCa/+hcpi
 sEK3Jabb/s3oyhoDIwGHWuOWOsFMtVy1nJpyf9EhmgbokpKX+W1YwPPg+/B6yr3XJjE3XFIDmKSbT
 PNOI4TDnT5gEjVS7l5jxzTI+y0GyXLFE5RaqTnY0LGoe9JAJFbPPkr5TtRetqNXdWnQb+xdoNStlC
 Yy03ZqzA==;
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA41-0006dx-EX
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:47 +0000
Received: by mail-wm1-x341.google.com with SMTP id q21so4293986wmc.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E2oKCm2aHyIkLmsWfLt1xuMZ3si46gMPXE7rlXDV4Gg=;
 b=o6PhnZungxBl1FHWb+8WwNsDkJDXfkICZjZtgPmXQm/Zn9kgKjsopyBPsSJcPQXCBq
 6l1skgJzlRFtC9/6b/P47gLlxrnsH/csAYVW6DIZvRqmmAtlL5RhgXiKMdSG0HvxDQ3J
 W9FBPhHEtmkSEPrFX0T/fy0DRtIc5MBG1iRNq7EUA0OkAiGkJcYDo96n2hHeo6gWCXed
 YU87zAssNGzamz2NhKgPGaULwsfTGJGvbBZXP5Oe47j6sqeKdWBt/19y/y5rAWVddIlO
 n1d95uPyfKLIEoN+U45If9HSqUPsNpjJYwc272tReyug5Itohv2gFJ6n/hmC/O4a+Mtl
 xNyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E2oKCm2aHyIkLmsWfLt1xuMZ3si46gMPXE7rlXDV4Gg=;
 b=okEXDX499ru+FB78oM92GJk9AdQYRQ36rCS1lMMhWKRco8xW3tLYxkKaoMXm9Sjim9
 1aFSAmFo/YgGUcTnVKstHo6vVkh7JIAOVWY2uoqIcth56dzQDUROtw9Tj85j4/l7oM1q
 oyfO/qzLQPUAlkHKJOsIQalTdUCHKcDPzO1CWWfwm4vtSbXSK2syVuqMynEM6LBoabuk
 ncJuOu0qzMYfpYklfQh+imtDUHX82ahJQFwDyGpmLnFCQF+h1zztMV7mCOUe7wOOfFRZ
 lldV3gT9CFOlrRQrNetXObdArzmTYwAZZaTSvNjFqxxies+rIlUdB4sBGwVzx3nrpOvf
 uB1g==
X-Gm-Message-State: AHQUAubSa4NnsHvEwOplrp+rFZT4ABxzpAV2D+nFPSdRadsWMSjjcNeG
 c3guu35hIJkT9H5UdebIRfYW0Q==
X-Google-Smtp-Source: AHgI3IatjZg4b0SSZmF0nwmCk5wLo+FpN6T0UdaHP7JlJFCzz077RBt1+NSq82ChDezEKwDZuI785A==
X-Received: by 2002:a1c:f00a:: with SMTP id a10mr2802502wmb.148.1549647344390; 
 Fri, 08 Feb 2019 09:35:44 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.43
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:43 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 32/33] irqchip: davinci-cp-intc: move the driver to
 drivers/irqchip
Date: Fri,  8 Feb 2019 18:34:57 +0100
Message-Id: <20190208173458.4801-33-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_173545_543040_B27CF125 
X-CRM114-Status: GOOD (  14.82  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The cp-intc driver has now been cleaned up. Move it to drivers/irqchip
where it belongs.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/Kconfig                             | 8 ++------
 arch/arm/mach-davinci/Makefile                            | 2 --
 drivers/irqchip/Kconfig                                   | 5 +++++
 drivers/irqchip/Makefile                                  | 1 +
 .../cp_intc.c => drivers/irqchip/irq-davinci-cp-intc.c    | 0
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename arch/arm/mach-davinci/cp_intc.c => drivers/irqchip/irq-davinci-cp-intc.c (100%)

diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index 71a4d875dd39..5a59cebc7d0a 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,10 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if ARCH_DAVINCI
 
-config CP_INTC
-	bool
-	select IRQ_DOMAIN
-
 config ARCH_DAVINCI_DMx
 	bool
 
@@ -33,13 +29,13 @@ config ARCH_DAVINCI_DA830
 	select ARCH_DAVINCI_DA8XX
 	# needed on silicon revs 1.0, 1.1:
 	select CPU_DCACHE_WRITETHROUGH if !CPU_DCACHE_DISABLE
-	select CP_INTC
+	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA850
 	bool "DA850/OMAP-L138/AM18x based system"
 	depends on !ARCH_DAVINCI_DMx || (AUTO_ZRELADDR && ARM_PATCH_PHYS_VIRT)
 	select ARCH_DAVINCI_DA8XX
-	select CP_INTC
+	select DAVINCI_CP_INTC
 
 config ARCH_DAVINCI_DA8XX
 	bool
diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index 983865a99616..f76a8482784f 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -18,8 +18,6 @@ obj-$(CONFIG_ARCH_DAVINCI_DM365)	+= dm365.o devices.o
 obj-$(CONFIG_ARCH_DAVINCI_DA830)	+= da830.o devices-da8xx.o usb-da8xx.o
 obj-$(CONFIG_ARCH_DAVINCI_DA850)	+= da850.o devices-da8xx.o usb-da8xx.o
 
-obj-$(CONFIG_CP_INTC)			+= cp_intc.o
-
 # Board specific
 obj-$(CONFIG_MACH_DA8XX_DT)		+= da8xx-dt.o pdata-quirks.o
 obj-$(CONFIG_MACH_DAVINCI_EVM)  	+= board-dm644x-evm.o
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index ea0eb82bf1d2..48fc5024c073 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -134,6 +134,11 @@ config DAVINCI_AINTC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config DAVINCI_CP_INTC
+	bool
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 623e0ec5f9d0..e6cd0c98eff2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_ATH79)			+= irq-ath79-misc.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2836.o
 obj-$(CONFIG_DAVINCI_AINTC)		+= irq-davinci-aintc.o
+obj-$(CONFIG_DAVINCI_CP_INTC)		+= irq-davinci-cp-intc.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
 obj-$(CONFIG_FARADAY_FTINTC010)		+= irq-ftintc010.o
 obj-$(CONFIG_ARCH_HIP04)		+= irq-hip04.o
diff --git a/arch/arm/mach-davinci/cp_intc.c b/drivers/irqchip/irq-davinci-cp-intc.c
similarity index 100%
rename from arch/arm/mach-davinci/cp_intc.c
rename to drivers/irqchip/irq-davinci-cp-intc.c
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
