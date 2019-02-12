Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459EFC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 116792186A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="A2Z18/AY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zVj6yIe6";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="noXiFlsk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 116792186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OGCrbOSYJbN17+JiNRarATcO0pjOl6CQ1SzariXrFtM=; b=A2Z18/AYIyAcCg
	bQaSQcT2lTeHMzjEZC1z4CIKS/Flkn7HiTossUmooYTW1vgOlX+GGuPB9bvd2wLsea3gQGJo/CZDg
	AETstp5UAWOJnWk5OwShyXdrs2ddK+NJRNbuqbLKPP5ZT4kA+wVwSbA2qHryOhV25W7uQEbCRPxWs
	297SYlEuoYgb6gf6D4zz+A+OujWghY8To1ZMX8NmCOKNDrOSpXYiy43azA/X43sdAuCrfCfnxRqY8
	9BmnU9IXwx86RCo4zUXsbOgLKYuoNsaBLfsXPcL0oHRk7XwaNPKhgWbNphHA4vMgM2cEbDHFLq3Ec
	RKRPxYgfJbIR31HIXxpQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtW8p-0000W6-AY; Tue, 12 Feb 2019 11:22:19 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVxk-00037j-PS
 for linux-arm-kernel@bombadil.infradead.org; Tue, 12 Feb 2019 11:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=; b=zVj6yIe6rIgNExO+hSyMrlo+H+
 SV9mytPeeouID+en23cRgKO3qFof/2xeUqdEpTxFgRbi0sqdkTzOXUZrrTtZhO5DEaxvWlaN44i5n
 g0znUS68OsvQQB4R1WZqmNyH0iPDNiD5pqeuXK4ema0kI15UpQYnXXjPphW67NCHSlCTHE6T7QAO8
 9TqAU7D21aqQE55SyO2YLZyfc936Wr2d1W0k/gGPI7UvWaP48CcFF6VlUYzOJrdnMLqr14/pYft0k
 l846V0BFXkgnyS9u905dTUKv0oWFUMnK3gH7sxB50favrSBhyZQxU2DZeRy01J8xHPvTnSndv7Azs
 OELslItw==;
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtVTN-0002FI-30
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 10:39:29 +0000
Received: by mail-wr1-x441.google.com with SMTP id c8so2103883wrs.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 02:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=noXiFlsk0XM0GY5v/0rDPEojjLKffV7SGApQvAinYkj3OpmJ7sOBaQPClXyLGgYtI5
 qHq8lZfUozJXp1jOqVPr5JTX0c6p0oQ3YyERVoJnSEiS0qUXbsyZFfk9FIqbqHMLRS0q
 Ih3Z8bM99U+8hzPpvn4k6SuTmkDEpuzBlmPvTf1gmyPfRTMvVhBqmD48MLQuHfCTcagK
 CNB0QO2fJQSM3uHp5Wvoy6yYAUy9Pa/YuAwNDmHwf6RblNWHnnVTJ8MMcC+vOqQwi9yl
 Hce1auYFASgCJwDsm7laNgafeuaDThHP99MK8xrU+MrSSRSN8XNF8Ma/X+7y9hzyzieg
 xxJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OE+68BkD2Gvi09w8U3xAg2OuU34U9g+A9X06DXSG8XE=;
 b=lSagsyrFF66zwMV02axeTG5cdErRFYK8D97clh4r8S3Eqhj0W0gJyGyL3S1lytI+Hv
 aMAGP1DB/XGuILqydaNdUEaLg89DpM1myqUOhxAVB/13XhVgq9DYpFMkGImuIRcK9Jhv
 R4goRD++1grtB+ObtBdEMtdItQRfRbBCbd/OVqLl4uy0Hbh5elfRfZpD59phsCM/q8NB
 pYtAnWr2IIlN1o+qcj/RdiZSF0IHAlicsZU5VKQ6bdml/5whw+/WSsgRn3dWKizoV/Kt
 LMmfj8CWprI1+nYG8OusAw6RFELp3RAlOZoyblfu/rnAAsKksNm8iUjJ/wOYGDyKPBmo
 tm0w==
X-Gm-Message-State: AHQUAubNCCc2L4q8H5qByzpg4LAjTfqf8/mXT0Mu3eZGMh9fojiC922V
 icdd2Cbr3870tnB5Sz+esbzs/w==
X-Google-Smtp-Source: AHgI3IYPI7+zQsrk1SPIERBtzaaT7PFiVqZZUtGXZ8wyhlL8nCMLOfT++q6zRqxuTYoR4Fpz4X/geA==
X-Received: by 2002:adf:d845:: with SMTP id k5mr2336065wrl.145.1549967967094; 
 Tue, 12 Feb 2019 02:39:27 -0800 (PST)
Received: from localhost.localdomain
 (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
 by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Feb 2019 02:39:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [PATCH v3 26/37] ARM: davinci: cp-intc: add the new config structures
 for da8xx SoCs
Date: Tue, 12 Feb 2019 11:38:24 +0100
Message-Id: <20190212103835.7768-27-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_053929_221889_31593B9C 
X-CRM114-Status: GOOD (  14.83  )
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
