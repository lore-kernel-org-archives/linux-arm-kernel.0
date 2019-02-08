Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D525C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:13:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56E4821916
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l4RbZacj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fSRTq98b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YlgtiiAF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E4821916
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OGCrbOSYJbN17+JiNRarATcO0pjOl6CQ1SzariXrFtM=; b=l4RbZacjbHK6ey
	WkbkxWL8fJ3hWN05v6UoJfojJxIHwO83dVOAYwDmjIhcN0FHE7Iw0D4GhC8qOpqT0PPbgJuB541yE
	ra5TorsXQQynuSl1xLPldB7KCKX9Yw+51QT17Wc6razqofOxRmf2167o1JMfUR+E69rYTYtOLyioy
	wqRaGKlQ+G6G4WOnIJB1r+dsPfcbBmaQq2Pme7Qj9ncm7VPVbY1OYQfzOQri0kpbyODmc5Hv1Y6PC
	N2ggPVuio5oOVRWiF13GuVXj49qPvQyENYOwRLNfgmjwz2ZII+WumUovMUhgb5yc+luODi6WajaIj
	g41Hn1VcLr7g7UC5L4cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsAYq-0003hN-Da; Fri, 08 Feb 2019 18:07:36 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsAJE-0003yF-6M
 for linux-arm-kernel@bombadil.infradead.org; Fri, 08 Feb 2019 17:51:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=; b=fSRTq98bz/VCZFLsnJIrB4Tzv7
 ZrkDOTsqk8moNwBZjhv/MuPAvVKo3CvGnE2Aw1Caz8NvOanmFVqAlzRHJwZg83nn3SIfsZ4zjYhKA
 DvYHRHzpsrofX5SvaB+l6umRnHBj29VFPQ2bs1bGEurBn/c3eBBsoV44bXq98tNlXCiQi5Vu0Tv8H
 7dvLfJRLecrsHOWyHlh6d7DEUIl8obq6+/36KfWjB6l6SGV/vJLLXKPVjf1K0wjvy1EIoCqMScYO5
 Dby7BCNK8zUBebOUterLMRzc3zmg5WVQS0bw/YwzRiF5vbzouDgdt8UxkXUMq8m7UtrVnznnPeMTK
 1Ptf+V5Q==;
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3r-0006cR-4z
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:36 +0000
Received: by mail-wm1-x344.google.com with SMTP id d15so4362008wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=YlgtiiAF+AvM6zkhhEmUfOtnG0N6MpYzvOfMvM/RA3KVT4ZJ80KCd186b5NdXKoFC1
 DOJN9PGnAz+LWemGz/+qBieD39hfoDcecoVq3Jxv4xaefgrBCU3PzsOWOuhnmJdQTfte
 559o3KshmtchmXfjfhpk9U/cAx5TVm+Pm1saM7JCXKrJTu8bDAKeALYe0U2yWm8R8RyC
 ob2JunMKg4oF8IRdvtXRNmn+vTjNOw692XfOYtlfxc3DZRojSM2q+z69QHIH0HKMveOw
 TVsN78lRIizirn93vfUv7Sy2Remc+GdgrKxq5RckHwFry1idz+vBmsK4adxNmO7Hu/Ey
 xxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=Iu6jUBEdT/JWjjKifndLmqYlPpnVCdROcLDXk+ntpDMYWgPDYUUKdPt5yiSyjHbeX/
 Kxfq87Wh+CzRT3Fj1T6zpeQY8EM0opTQ/x3mUWKFnzpFYkImad24YG6aA3xioW+o4eXu
 C6iPQrEej/3T0PuZi98ea+n1cyGIlC/z6BofIGZoAoYHi4opNVgoT27Y0fvf1pwu0Kl8
 QMw6gMbmWn/gAIaJR5Dh9tDER5aqx1LK03V3BeTdkoCexVciWd+sO5S3cHHNskrFp79b
 94Es00kxTKHcGgOTPcYSKuenfMeqEFYqjmCoalr8R6yjghs8cDvvkGKEhyVzDoo/TRoV
 g0sQ==
X-Gm-Message-State: AHQUAuZFsjR//ZNvyqZ0T3FTMiK2UxTkAS+vN9I/38PZu4Bim+9qNVvJ
 b4w4hqeaSrMyAItnJE0s+Yr2Hg==
X-Google-Smtp-Source: AHgI3IZda11KYRPw2eSJI8uzt5B/eMh/HR9zpmlIB9OgnhaCxWQ4r9hcIZrz5Ctai1T6vNsXlGhjbg==
X-Received: by 2002:a1c:5656:: with SMTP id k83mr12651966wmb.125.1549647333817; 
 Fri, 08 Feb 2019 09:35:33 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:33 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 23/33] ARM: davinci: cp-intc: add the new config structures
 for da8xx SoCs
Date: Fri,  8 Feb 2019 18:34:48 +0100
Message-Id: <20190208173458.4801-24-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_173535_221712_8F17E14C 
X-CRM114-Status: GOOD (  14.53  )
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

Add the new-style config structures for da8xx SoCs. They will be used
once we make the cp-intc driver stop using davinci_soc_info.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c | 10 ++++++++++
 arch/arm/mach-davinci/da850.c | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 5cfd30c57429..38af72be1a85 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -12,6 +12,7 @@
 #include <linux/clk/davinci.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/platform_data/gpio-davinci.h>
 
 #include <asm/mach/map.h>
@@ -821,6 +822,15 @@ void __init da830_init(void)
 	WARN(!da8xx_syscfg0_base, "Unable to map syscfg0 module");
 }
 
+static const struct davinci_cp_intc_config da830_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA830_N_CP_INTC_IRQ,
+};
+
 void __init da830_init_irq(void)
 {
 	cp_intc_init();
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 6df6994c0f26..9a3ce68c0de4 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -18,6 +18,7 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/mfd/da8xx-cfgchip.h>
 #include <linux/platform_data/clk-da8xx-cfgchip.h>
 #include <linux/platform_data/clk-davinci-pll.h>
@@ -759,6 +760,15 @@ void __init da850_init(void)
 	WARN(!da8xx_syscfg1_base, "Unable to map syscfg1 module");
 }
 
+static const struct davinci_cp_intc_config da850_cp_intc_config = {
+	.reg = {
+		.start		= DA8XX_CP_INTC_BASE,
+		.end		= DA8XX_CP_INTC_BASE + SZ_8K - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	.num_irqs		= DA850_N_CP_INTC_IRQ,
+};
+
 void __init da850_init_irq(void)
 {
 	cp_intc_init();
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
