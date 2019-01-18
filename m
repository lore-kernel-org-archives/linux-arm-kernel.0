Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69816C61CE3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:44:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D2D20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZkJm+8K4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d9aPAOV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D2D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IeN5Ize9uCtht9RhPJF2NdgI1cTGtr23ArvWy/AGXyE=; b=ZkJm+8K4ssoinC
	v+42bE9dCjopcckUOuwxoWReTtHUgqN6Us0f8emsJYz2CoSBkhyyBJUbJ7fQ4jl8eSezA7VrVOIP4
	GKd6iwwpc2o3tIXBbQyd9wReFfU56w7JSo736Ycbg38tnO74sfxfIKCYEOcjTJJh9vixDGstYAoFw
	U5/j1LndgiH5f4YI5s6JUIf8knkrgELiav4jchREl23aWm/IKih8K0hlzNRfMGT0jkJWpy1U3j31j
	jX9lvbJOLAzIFrV74Z/Y8rWGSVm7Az6rpMTdkxdTCdBQaSgQQpCDfFXYtt7DP0n78WoPY33CmEY3T
	yzM1HduBhS6Fn3076QdQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkdoH-0005Qz-Uu; Fri, 18 Jan 2019 23:44:25 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkdni-0004sh-Sg; Fri, 18 Jan 2019 23:43:52 +0000
Received: by mail-wr1-x442.google.com with SMTP id s12so17066775wrt.4;
 Fri, 18 Jan 2019 15:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b8iF22LUkWvDIB7WAhLCpBIoGZvslkNjok08zXr0mj0=;
 b=d9aPAOV2/D7Q9MSjwWsBeAzy2Ek4MR+9VgFXqUXcDx0oYFVvvxAphA2Am9lbALMGee
 t2mTo+1j1ArxT/am2d1iOVp5XxwH09xTjztVRbJu3Gp7nUSJ5z+fsJ397dfcd3fwBhvE
 RtlUk614gUNiXU1yjMMJEAExfV9rX2+UMjTiLLHzyPEfC2cCrgEIUTTKIq91bAwEcvbt
 zBEQEQNKXtA6DwiTIm1YCtUyRxQKeq4phlqiS5Gdkt8M/i0QCI+8Ul70uCwQtF3CqGjj
 hj52Fk7Pu0bdfS7H4FWYMca6zPu3fxrDbHhSUbJ1udxHJ1v9DbOGFfPA9AoKNFb2Va8c
 NzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b8iF22LUkWvDIB7WAhLCpBIoGZvslkNjok08zXr0mj0=;
 b=pdoxFxgGJEN6Gtkgp5t2JrGONIX65tpZh4PpFYMsNK2aaoT1ikA0ijirI1Fk6fQjUA
 RKslpuXHi3QIpw1Ax0k87GTblLvErC0tPP72oaeP0f9r1Cpd6T43wNtQY+y3v9KLN8x8
 /Iy1JOeVXTiFLphGLEsmhDxB13TFaixJ1hryQDupw19q+NE5j75lu+gdD7vD27gE4NWA
 +mPofJa/BLWD3bmZ5eZsscnlbtHQQgwcb7tzjzTTAJG/qD3uQdBS1D5ijgbCRb1sCXHG
 A070ug0PKe9SMJtbQPaba03gPPsEn+6vVxJMYrWIAaz/upAx91A/zyfNXQ2IlS+2Vtch
 8BAA==
X-Gm-Message-State: AJcUukeJxKlQT7jPE5fgZfPrW9WFb5LV8bCADQafg3OjGwpnK6FJnyDB
 AxTmaSgLIVN24OEr322F+LvfUhwF
X-Google-Smtp-Source: ALg8bN7AvZAmhdmvwEScHfxu11cEgns7itF8yUOocUoncn40SsYi4VVXD+BBd0ONIDKsNJPfOeOZHw==
X-Received: by 2002:adf:f903:: with SMTP id b3mr19304216wrr.82.1547855029164; 
 Fri, 18 Jan 2019 15:43:49 -0800 (PST)
Received: from blackbox.darklights.net
 (p200300DCD73A810039E290CB771389D7.dip0.t-ipconnect.de.
 [2003:dc:d73a:8100:39e2:90cb:7713:89d7])
 by smtp.googlemail.com with ESMTPSA id j8sm108970024wmd.0.2019.01.18.15.43.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 18 Jan 2019 15:43:48 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	khilman@baylibre.com
Subject: [PATCH 2/3] ARM: dts: meson8b: ec100: improve the description of the
 regulators
Date: Sat, 19 Jan 2019 00:43:38 +0100
Message-Id: <20190118234339.16050-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118234339.16050-1-martin.blumenstingl@googlemail.com>
References: <20190118234339.16050-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190118_154350_921959_6B3A13CA 
X-CRM114-Status: GOOD (  12.60  )
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
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

USB_VBUS is a controlled by a Silergy SY6288CCAC-GP 2A Power
Distribution Switch. The name of it's enable GPIO signal is USB_PWR_EN.

VCC5V is supplied by the main power input called PWR_5V_STB. The name of
it's enable GPIO signal is 3V3_5V_EN.

VCC3V3, VCC_DDR3_1V5 and VCCK (the CPU power supply) each use a separate
Silergy SY8089AAC-GP 2A step down regulator. They are all supplied by the
board's main 5V. VCC3V3 and VCC_DDR3_1V5 are fixed regulators while the
voltage of VCCK can be changed by changing it's feedback voltage via
PWM_C.

VCC1V8 is an ABLIC S-1339D18-M5001-GP fixed voltage regulator which is
supplied by VCC3V3.

VCC_RTC is a Global Mixed-mode Technology Inc. G918T12U-GP LDO which. It
is supplied by either VCC3V3 (when the board is powered) or the RTC coin
cell battery.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b-ec100.dts | 68 +++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b-ec100.dts b/arch/arm/boot/dts/meson8b-ec100.dts
index 1a41d89d1fa5..5ecd787e9265 100644
--- a/arch/arm/boot/dts/meson8b-ec100.dts
+++ b/arch/arm/boot/dts/meson8b-ec100.dts
@@ -88,6 +88,9 @@
 	};
 
 	usb_vbus: regulator-usb-vbus {
+		/*
+		 * Silergy SY6288CCAC-GP 2A Power Distribution Switch.
+		 */
 		compatible = "regulator-fixed";
 
 		regulator-name = "USB_VBUS";
@@ -95,11 +98,20 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		vin-supply = <&vcc_5v>;
+
+		/*
+		 * signal name from the schematics: USB_PWR_EN
+		 */
 		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
 	vcc_5v: regulator-vcc5v {
+		/*
+		 * supplied by the main power input which called PWR_5V_STB
+		 * in the schematics
+		 */
 		compatible = "regulator-fixed";
 
 		regulator-name = "VCC5V";
@@ -107,6 +119,9 @@
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 
+		/*
+		 * signal name from the schematics: 3V3_5V_EN
+		 */
 		gpio = <&gpio GPIODV_29 GPIO_ACTIVE_LOW>;
 
 		regulator-boot-on;
@@ -114,12 +129,18 @@
 	};
 
 	vcck: regulator-vcck {
+		/*
+		 * Silergy SY8089AAC-GP 2A continuous, 3A peak, 1MHz
+		 * Synchronous Step Down Regulator.
+		 */
 		compatible = "pwm-regulator";
 
 		regulator-name = "VCCK";
 		regulator-min-microvolt = <860000>;
 		regulator-max-microvolt = <1140000>;
 
+		vin-supply = <&vcc_5v>;
+
 		pwms = <&pwm_cd 0 1148 0>;
 		pwm-dutycycle-range = <100 0>;
 
@@ -128,19 +149,66 @@
 	};
 
 	vcc_1v8: regulator-vcc1v8 {
+		/*
+		 * ABLIC S-1339D18-M5001-GP
+		 */
 		compatible = "regulator-fixed";
 
 		regulator-name = "VCC1V8";
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
+
+		vin-supply = <&vcc_3v3>;
 	};
 
 	vcc_3v3: regulator-vcc3v3 {
+		/*
+		 * Silergy SY8089AAC-GP 2A continuous, 3A peak, 1MHz
+		 * Synchronous Step Down Regulator. Also called
+		 * VDDIO_AO3.3V in the schematics.
+		 */
 		compatible = "regulator-fixed";
 
 		regulator-name = "VCC3V3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+
+		vin-supply = <&vcc_5v>;
+	};
+
+	vcc_ddr3: regulator-vcc-ddr3 {
+		/*
+		 * Silergy SY8089AAC-GP 2A continuous, 3A peak, 1MHz
+		 * Synchronous Step Down Regulator. Also called
+		 * DDR3_1.5V in the schematics.
+		 */
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC_DDR3_1V5";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+
+		vin-supply = <&vcc_5v>;
+
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vcc_rtc: regulator-vcc-rtc {
+		/*
+		 * Global Mixed-mode Technology Inc. G918T12U-GP
+		 */
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC_RTC";
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
+
+		/*
+		 * When the board is powered then the input is VCC3V3,
+		 * otherwise power is taken from the coin cell battery.
+		 */
+		vin-supply = <&vcc_3v3>;
 	};
 };
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
