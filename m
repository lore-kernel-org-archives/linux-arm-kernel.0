Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41ECDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:57:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BE772075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 13:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HwOygMgX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="S4CM0YUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE772075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SmgR1ltryEKIeBQcw+4Efqz6s2jX2d7H7iF7S3q+RvM=; b=HwOygMgXh5Dwlx
	Gq6UATYUw/JS5bWYdi9o3Yfnf4YpMLoErdQoTLP3te9VCzNTwY55HFRqetZXowB0++3XeIRowX9oH
	Rd2oGNl4NcPKMAzsQcv5BEajYJLzKcVEOVop/iqQDQbyAr5CQQnBfPDT68gT9FrqRbzFr5ieWcGFZ
	CL+T+Oe7UnzR1kpVpBOLX4kev0N/Aia7UIJwQC9+8Cv+189S9rvnZfyP2KYCabDPnQylcuevcthbf
	/NubLWkSOZX9kFFS92/WRJPwG0XhFOXoZZ6t3TAmasgyD793KczCL6dCfG4PsavTHIf6+VS1/3643
	NPPK8Fqxe5cnmQpnJdTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghEMX-0006YD-QC; Wed, 09 Jan 2019 13:57:41 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghEMU-0006Xm-Do
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 13:57:39 +0000
Received: by mail-lf1-x142.google.com with SMTP id a8so5705329lfk.5
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 09 Jan 2019 05:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CrLCXJLQQUUYMd5YhwLkvEwKAbovTZmbtHVYNl4rBco=;
 b=S4CM0YUexUPddBL2xlGljhV5q0X4AH47j9wruZBswXSJeQPMC/GnEtNwHLEyXNrDaB
 LdrX0YUEPE8aiT0kighXi7yVTWGSEGHSEelqejY2uZSoa5VZzg2J7e1gVaGTOm2YWjUZ
 i/ahW8GLBUklPCcr66RnCpT/RrhBoZ5gKmnz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CrLCXJLQQUUYMd5YhwLkvEwKAbovTZmbtHVYNl4rBco=;
 b=BAnR+M9aONIDm8MjmkehkCdXfuU30uyqz24IGSeYtkdynZYrUZAzWvWDiwiDBVlF8w
 ol0L/Sms4vFgRNvyrAhf5j4nNuES9nByG7rnI6BHy+eDvmwrYXN4GIDc3QthgSZ10v38
 j4p2JHX9Gn/Vna6LyxTym/QfEQ+Gg2WxsWgIwM3cT5ZnTsl9oNldeafIBvI43pEnEFvf
 PEtWOiGBUXZO+o2aZ2lcCUGlwTDn/2OmyUGOMpQEu7yumxveJwL89z8x0rc63DPdd/4t
 15yAErIzV0C7GWSqLZoYrcidsLY6yKcT14cQ3idcHHzGDEBxODke7j263hhd2HdEm+0O
 IQpA==
X-Gm-Message-State: AJcUukcRwxaznbZMKjfgtaHA8Xo/fIuOZ63SHGtaHN0uaYz1Al0jqq7K
 rBTdbLFnvussd+aTdctRu+r1k1p7qRLwJ3yt
X-Google-Smtp-Source: ALg8bN4mWQ+HJ5DE8Z9Qn8J2UsOiXuzg0+OMW2yny66gGt8Tu+5nu/iqM7X0uRDGEbKBpWtvQhy3kA==
X-Received: by 2002:ac2:554b:: with SMTP id l11mr3412953lfk.92.1547042255731; 
 Wed, 09 Jan 2019 05:57:35 -0800 (PST)
Received: from localhost.bredbandsbolaget
 (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id p10-v6sm14904457ljg.19.2019.01.09.05.57.34
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 09 Jan 2019 05:57:34 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: nomadik: Augment NHK15 panel setting
Date: Wed,  9 Jan 2019 14:57:30 +0100
Message-Id: <20190109135730.15464-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_055738_464452_384F8FA7 
X-CRM114-Status: GOOD (  15.91  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The NHK15 panel is specified inside the display controller,
which works for the DPI-type DT parsing the old fbdev code
used, but for the DRM driver it needs to be spawn as its own
device, so we move it out of the display controller.

We also drop the panel timings: this should be determined
by the hardware or a device-specific compatible string, not
by this type of encoding into the device tree. It turns out
that this hardware is strapped to the right configuration
at boot already and we the driver just reads out the
hardware-specified resolution and timings. Drop the
"panel,dpi" compatible string altogether.

Fix a comment error in the DTS file while we're at it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 85 +++++++++++++++----------
 1 file changed, 51 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index 12afdc7467e7..04066f9cb8a3 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Device Tree for the ST-Ericsson Nomadik S8815 board
- * Produced by Calao Systems
+ * Device Tree for the ST Microelectronics Nomadik NHK8815 board
  */
 
 /dts-v1/;
@@ -182,43 +181,12 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&clcd_24bit_mux>;
 			port {
-				nomadik_clcd_pads: endpoint {
+				nomadik_clcd: endpoint {
 					remote-endpoint = <&nomadik_clcd_panel>;
 					arm,pl11x,tft-r0g0b0-pads = <16 8 0>;
 				};
 			};
 
-			/*
-			 * WVGA connector 21
-			 * WVGA (800x480): 4.3" TPG110 TDO43MTEA2 24-bit RGB
-			 * with TPO touch screen.
-			 */
-			panel {
-				compatible = "tpo,tpg110", "panel-dpi";
-				grestb-gpios = <&stmpe_gpio44 5 GPIO_ACTIVE_LOW>;
-				scen-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
-				scl-gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
-				sda-gpios = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-				backlight = <&bl>;
-
-				port {
-					nomadik_clcd_panel: endpoint {
-						remote-endpoint = <&nomadik_clcd_pads>;
-					};
-				};
-
-				panel-timing {
-					clock-frequency = <33200000>;
-					hactive = <800>;
-					hback-porch = <216>;
-					hfront-porch = <40>;
-					hsync-len = <1>;
-					vactive = <480>;
-					vback-porch = <35>;
-					vfront-porch = <10>;
-					vsync-len = <1>;
-				};
-			};
 		};
 
 		/* Activate RX/TX and CTS/RTS on UART 0 */
@@ -233,6 +201,55 @@
 		};
 	};
 
+	spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/*
+		 * As we're dealing with 3wire SPI, we only define SCK
+		 * and MOSI (in the spec MOSI is called "SDA").
+		 */
+		gpio-sck = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+		gpio-mosi = <&gpio0 4 GPIO_ACTIVE_HIGH>;
+		/*
+		 * It's not actually active high, but the frameworks assume
+		 * the polarity of the passed-in GPIO is "normal" (active
+		 * high) then actively drives the line low to select the
+		 * chip.
+		 */
+		cs-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+
+		/*
+		 * WVGA connector 21
+		 * WVGA (800x480): 4.3" TPG110 TDO43MTEA2 24-bit RGB
+		 * with TPO touch screen.
+		  */
+		panel: display@0 {
+			/*
+			 * The TPO display driver is connected to a
+			 * 5.7" OSD OSD057VA01CT TFT display.
+			 */
+			compatible = "tpo,tpg110";
+			reg = <0>;
+			spi-3wire;
+			/* 320 ns min period ~= 3 MHz */
+			spi-max-frequency = <3000000>;
+			/* Width and height from the OSD data sheet */
+			width-mm = <116>;
+			height-mm = <87>;
+			grestb-gpios = <&stmpe_gpio44 5 GPIO_ACTIVE_LOW>;
+			backlight = <&bl>;
+
+			port {
+				nomadik_clcd_panel: endpoint {
+					remote-endpoint = <&nomadik_clcd>;
+				};
+			};
+		};
+	};
+
 	bl: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&stmpe0_pwm 0 500000>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
