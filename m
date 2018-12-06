Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C5C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:12:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6341C20989
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S6qBIPJg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6341C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=myd1ks2mIXj+TeO05OjfxChH1lOJDMdxcf1L8doxrGw=; b=S6qBIPJgwtRokV
	dwe4S8r7sn5e3p6ECWISGKySq1ycrppDqlaKGXW94Ugkft6kicnr2UypTMx3D6GYyjwFR3CckT2vS
	rhQbhCd2nH7qQm/ePZEK0ChJMgWE66Me3Es+grFydMib07PTpcMIqPkJjFWaVMoFlAJhs17FXO4DQ
	OAkTOSjuh8SfdBcawMg1Wg8I66emrQ4GoS0382xa+dM/2UvP9pq6vFuMitZ9qux0wWKH5RqRqCeL7
	rOITH8/Cv4AGRmahAd1RFxbPgatf2s66VBiAZeDyqPOdfMhl31hYGYmaA/uCtnkRdjqLumsalMSvV
	FDPCFddDIlP3VK9yYMIw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUqdW-0004QH-JG; Thu, 06 Dec 2018 10:12:02 +0000
Received: from mail-qt1-f195.google.com ([209.85.160.195])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUqc6-0002qk-Mc
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 10:10:57 +0000
Received: by mail-qt1-f195.google.com with SMTP id v11so25647807qtc.2
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 06 Dec 2018 02:10:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=nbaHCr1rOrTleJfZck6q7uF/Z4+VZl11yabsEEpO5fc=;
 b=X880TZ6odHSY+nvyDM1MwEMFvRInEhSjYkp2CGNmx03waHOLKOoWnP7Kmc6zPAoh4n
 qTbWiZBYruDQ8LG+1o9YtFd/swLRT77nd97yN7cGvs7pHK+KOpJBwxcmTMxlFrH4M5lv
 CAZ6wrzfmPVIG6ytQObKaN8c9R7lE/gEB2wSVwVhg8zq1j+AzWr/IVjA73xrcHFkg7DG
 ntUdweufmao6QFCM0mjS74L9XTcQCL3xPXXEJylv1sj+m/OPeN+xuWDMNIPCybpdtWOx
 kqhGLCiQyIxjCre3E34xQU0d3HrLNH0SfZJSHHrKRkP38WUqTyjzamb3qnSXujl2y1SE
 HiYw==
X-Gm-Message-State: AA+aEWb6jltTXdGite6UusZ3K5MFBa+NJVR5oRtZwo0g+HLCzYTqnKeM
 7qbiwORyb0oUsvPxL+mXbLsMOd5X
X-Google-Smtp-Source: AFSGD/X4Q1AScDcASPtBtgv+1eno9R+1rKtyDo6hKbnTXGFdB9jLXObaf+aou1dSb9lHMvK85BI6DQ==
X-Received: by 2002:a0c:8164:: with SMTP id 91mr26754603qvc.100.1544091023221; 
 Thu, 06 Dec 2018 02:10:23 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id v50sm14296297qtc.7.2018.12.06.02.10.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 06 Dec 2018 02:10:22 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Thu, 06 Dec 2018 08:10:16 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 9/9] ARM: dts: imx7d-pico: Add the imx7d-pico-hobbit variant
Date: Thu,  6 Dec 2018 08:09:05 -0200
Message-Id: <20181206100905.15053-10-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206100905.15053-1-otavio@ossystems.com.br>
References: <20181206100905.15053-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_021034_890567_4989136D 
X-CRM114-Status: GOOD (  17.85  )
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

Changes in v2: None

 arch/arm/boot/dts/Makefile              |   1 +
 arch/arm/boot/dts/imx7d-pico-hobbit.dts | 105 ++++++++++++++++++++++++
 2 files changed, 106 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx7d-pico-hobbit.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1d6d916c2195..5c7dc0b4aaa8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -572,6 +572,7 @@ dtb-$(CONFIG_SOC_IMX7D) += \
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
