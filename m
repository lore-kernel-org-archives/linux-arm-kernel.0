Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278CEC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:31:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E78B12081C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fHjiGnsM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i4N/8W6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E78B12081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=NrZLgRs2hli9jDhEyl9Sa3djdbWSgzkAqSVvLaEkvHQ=; b=fHjiGnsM4xG+yk
	f/4WXsyJU+k+ODiX6pEJb16AljFQQs5mzw20AapxQcna4FvHvbB6g0KxYbe1uMsA7kSbuhdFX3sLk
	FGUoOA9HJQAFL3uPWn213FBubRIBE4AUyMTRMI5XnLRpWpTFB4jKHKvAZDs21mjnZ1KlmFwvxHx6H
	9hKwUJfNeRH9oAA6NBL822B11qG1rp0fudAC9jh+AC8EA5aTo3Mq7iESSjkFsvLUJp9Wb+yM0zMBL
	MLCA2tbAxYVlFJ8WozppFJYGGXx5fGL1uo5R2zh6w/5yZbXqAQJXKjNDML+IB02G7rusP8mFO3Pb/
	geWItdRinRXRe6czF7sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaGs-0006wx-QY; Sun, 02 Dec 2018 22:31:26 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaGq-0006wi-AH
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 22:31:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qo7I0hRRs35AV7fENb0Vk9rw2AwMZH8coRuKvX4vsgI=; b=i4N/8W6DXkAsRrfSSgVhf4kRpW
 BelyqSyman5Ynt0XNGBGzP36Un6IMpe9yY8+I3JUVa8KDRzuIvOkmAfT5/arzaIF5CJ5K1z07ate2
 oDWQoQiPVqJDrIoHsulVCTKMRkzKLC49vtNtyoW+Mqb5CGecMwAtYjoTbbZ4mG8Ax9sSv9kqmFOOS
 rgRMAOw/WQZSSHuL/IF5RBJQz8b0vqogIxYzteFirQOvmg8UyJJCpVwSjc0/nCipakl57LC/gk1mr
 SUPNwdahN8oYZUm6tJFyt46IvBAt/69F4aTcZ7/+6rvrEEnMDfmRTUeakxOET/3950bNsYNaKhU8o
 +ArHtp/A==;
Received: from mail-qt1-f194.google.com ([209.85.160.194])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZGI-0002kA-Ab
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:26:50 +0000
Received: by mail-qt1-f194.google.com with SMTP id t13so11678199qtn.3
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:26:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=Qo7I0hRRs35AV7fENb0Vk9rw2AwMZH8coRuKvX4vsgI=;
 b=JPOzrjJpv4alyqhhFNnOB3P6OPVda9xpYrj0LAcsRiORzqtcbnVBv88E8V4umnHBJy
 xqo7QatlOKnXT5sgRle6E4EeaFoVxAEd0CHSPsg84PORBcdxKGaJQS5mu7jFgByTduXb
 /GDFWN/bKgBs9UrqiB+qXmy52ndpoLBmTd2on9cz+w25C30Lhtr8f4JR17sU/WyHKj1l
 GPUxBhFoWO/ukSGgzg7fC1HoTFKMLxTdcApovlizQZb3HifCm1cVrCD3jstZxdrRMYxI
 lJ9qjQ4nCfFl3q5hwSG4Df45iDKwZT9yCj+HJMmrgG1CGp4DgOxrALBZy3u6NTrTQefd
 dNrQ==
X-Gm-Message-State: AA+aEWaOmuzhbWtRBHwV+PXpLCZyxY8qOsX+zcc/Hui+VOmP/jafqMaG
 pbPtz1rTWuAqxPawUyowPFNPApaW
X-Google-Smtp-Source: AFSGD/UZWOI5aKtuRxi5ertS3+vtnX7PTK3VjKoYKyAR+vPdaCvgqAG6PIHdKlkGNMt8SeWZHxWuBg==
X-Received: by 2002:ac8:4709:: with SMTP id f9mr12903211qtp.58.1543785994987; 
 Sun, 02 Dec 2018 13:26:34 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id n72sm8178607qki.26.2018.12.02.13.26.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:26:34 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:26:27 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 9/9] ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant
Date: Sun,  2 Dec 2018 19:25:20 -0200
Message-Id: <20181202212520.16650-10-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202212520.16650-1-otavio@ossystems.com.br>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_162646_446158_C5803B77 
X-CRM114-Status: GOOD (  17.58  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

The imx7d-pico-hobbit contains a imx7d-pico SoM and a hobbit baseboard.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 ++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d625b9..12a3cfb7d280 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -569,6 +569,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-colibri-emmc-eval-v3.dtb \
 	imx7d-colibri-eval-v3.dtb \
 	imx7d-nitrogen7.dtb \
+	imx7d-pico-hobbit.dtb \
 	imx7d-pico-pi.dtb \
 	imx7d-sbc-imx7.dtb \
 	imx7d-sdb.dtb \
diff --git a/arch/arm/boot/dts/imx7d-pico-hobbit.dts b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
new file mode 100644
index 000000000000..7b2198a9372c
--- /dev/null
+++ b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+//
+// Copyright 2017 NXP
+
+#include "imx7d-pico.dtsi"
+
+/ {
+	model = "TechNexion PICO-IMX7D Board using Hobbit baseboard";
+	compatible = "technexion,imx7d-pico-hobbit", "fsl,imx7d";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led {
+			label = "gpio-led";
+			gpios = <&gpio2 13 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "imx7-sgtl5000";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&dailink_master>;
+		simple-audio-card,frame-master = <&dailink_master>;
+		simple-audio-card,cpu {
+			sound-dai = <&sai1>;
+		};
+
+		dailink_master: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+			clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		};
+	};
+};
+
+&i2c1 {
+	sgtl5000: codec@a {
+		#sound-dai-cells = <0>;
+		reg = <0x0a>;
+		compatible = "fsl,sgtl5000";
+		clocks = <&clks IMX7D_AUDIO_MCLK_ROOT_CLK>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_vref_1v8>;
+	};
+};
+
+&i2c4 {
+	status = "okay";
+
+	adc081c: adc@50 {
+		compatible = "ti,adc081c";
+		reg = <0x50>;
+		vref-supply = <&reg_3p3v>;
+	};
+};
+
+&ecspi3 {
+	ads7846@0 {
+		reg = <0>;
+		compatible = "ti,ads7846";
+		interrupt-parent = <&gpio2>;
+		interrupts = <7 0>;
+		spi-max-frequency = <1000000>;
+		pendown-gpio = <&gpio2 7 0>;
+		vcc-supply = <&reg_3p3v>;
+		ti,x-min = /bits/ 16 <0>;
+		ti,x-max = /bits/ 16 <4095>;
+		ti,y-min = /bits/ 16 <0>;
+		ti,y-max = /bits/ 16 <4095>;
+		ti,pressure-max = /bits/ 16 <1024>;
+		ti,x-plate-ohms = /bits/ 16 <90>;
+		ti,y-plate-ohms = /bits/ 16 <90>;
+		ti,debounce-max = /bits/ 16 <70>;
+		ti,debounce-tol = /bits/ 16 <3>;
+		ti,debounce-rep = /bits/ 16 <2>;
+		ti,settle-delay-usec = /bits/ 16 <150>;
+		wakeup-source;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA00__GPIO2_IO0		0x14
+			MX7D_PAD_EPDC_DATA01__GPIO2_IO1		0x14
+			MX7D_PAD_EPDC_DATA02__GPIO2_IO2		0x14
+			MX7D_PAD_EPDC_DATA03__GPIO2_IO3		0x14
+			MX7D_PAD_EPDC_DATA05__GPIO2_IO5		0x14
+			MX7D_PAD_EPDC_DATA12__GPIO2_IO12	0x14
+			MX7D_PAD_EPDC_DATA07__GPIO2_IO7		0x14
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX7D_PAD_EPDC_DATA13__GPIO2_IO13	0x14
+		>;
+	};
+};
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
