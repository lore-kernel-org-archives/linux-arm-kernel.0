Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB33C282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8331E21855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cQYngV0r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QXQNyql8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8331E21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qEAAw+cxhLYa59jVoPVquz6LOaMhqI6UeNbBHNdK6Ic=; b=cQYngV0rqoExHv
	jUE/Op5X5FXBV0aMeV2BSoqVvtxbj7qr+RYru45CbwEZWUYy+CkAlksnOuivIq28zF+9lXdx8lSHf
	7G2TaBThcVYuSss8w5of3Pg3nfptuvhaZIxRn0WYiY4vEgLcrDT0t0IKvvDAsWYD0qBa1RP98WfBd
	795tq6xOuXj9Wjfr4Zb2/nI8Tp48S6VXsyEMKmBBf84Z3RhIQ+ZSUbmosJQkx3gyYSc1qJvd4K4YK
	AEYes8HjzauDF08bzsqUpemKX3jKDPi3rghnLB45F2ooT0ZK+CV8P6w1AEBKjNIaEHe9kEsQ53eoa
	10Hv2wAqFvMMr0pNRmiQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmlEg-00046a-7o; Thu, 24 Jan 2019 20:04:26 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmlBQ-0001KJ-O8
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 20:01:42 +0000
Received: by mail-pg1-x543.google.com with SMTP id w7so3112362pgp.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 12:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=592MwDOO4fFABylW/PjMmeCRDtBAYuoeRyepsTAixok=;
 b=QXQNyql81nyRq1SmbUoWO/HBZiNHXLOzPHkANeXW2GFAI8/tdVm2NRLnTD8Lfs7RLq
 udqkn69CFuwJCUMS0SsPCQS0RNWyziAPdAqCCQc7yvoTKEHfWNX0SQQk6kkcf9wjyk1i
 rd3bDGgKNEWxVmbD0Tjpzub92DBKf0GW7UggY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=592MwDOO4fFABylW/PjMmeCRDtBAYuoeRyepsTAixok=;
 b=qFNTtWtXWYJSjZv1Y24AG/G1w/1btY7BkmvaMSPBj2L57qCQH1T3NGk1RiDEFFroDu
 HgMIb6gpUgJRiFjRzcstcQyY4ipZWK6J3kdifDCtZXaGcEIDt+Vsa/60EGLYu5lcEUrZ
 89HGyDVWel8C3M3krAPJIS5WT+LMxuWkCn8yGc63gpIji5w1rxWs+itMcLQqPTKwtrKF
 G2fUMz32+Bj0nqyAkg50jvorQ7vw1yApnlonrPMRGGq604dCxfMfvC5p237txumTpZto
 vrUv+05oHPQ3/GrdDOYyL045mPScZSNdyv/1JzYB7J+ocjvoQ4zUb+sAAZbEjjRH+p9h
 JCFA==
X-Gm-Message-State: AJcUukeTT3cH0vWEd+oK7vOY4e1KpCXSxfcq3SZbjrgnFDQuudGt+5lc
 3uTU/xnLLjBieVOyUfccqRxXOQ==
X-Google-Smtp-Source: ALg8bN4ewEqnxTS5hUBF+hBw+bJWKLEbY97FJNMjC240jfvYcQrErYUotvyA6oF5fBqX+7fbWTFNxA==
X-Received: by 2002:a62:5793:: with SMTP id i19mr7956202pfj.49.1548360063998; 
 Thu, 24 Jan 2019 12:01:03 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
 by smtp.gmail.com with ESMTPSA id x11sm61637003pfe.72.2019.01.24.12.00.58
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 12:01:03 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [DO NOT MERGE] [PATCH v6 19/22] arm64: dts: allwinner: bananapi-m64:
 Bananapi S070WV20-CT16 DSI panel
Date: Fri, 25 Jan 2019 01:28:57 +0530
Message-Id: <20190124195900.22620-20-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190124195900.22620-1-jagan@amarulasolutions.com>
References: <20190124195900.22620-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_120105_330678_50651828 
X-CRM114-Status: GOOD (  13.59  )
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
 dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
 Jagan Teki <jagan@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 linux-amarula@amarulasolutions.com, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch add support for Bananapi S070WV20-CT16 DSI panel to
BPI-M64 board.

DSI panel connected via board DSI port with,
- DLDO1 as VDD supply
- PD6 gpio for reset pin
- PD5 gpio for backlight enable pin
- PD7 gpio for backlight vdd supply

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index c99f66271287..14ecc57c72cf 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -45,6 +45,7 @@
 #include "sun50i-a64.dtsi"
 
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pwm/pwm.h>
 
 / {
 	model = "BananaPi-M64";
@@ -56,6 +57,15 @@
 		serial1 = &uart1;
 	};
 
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
+		brightness-levels = <1 2 4 8 16 32 64 128 512>;
+		default-brightness-level = <2>;
+		enable-gpios = <&pio 3 5 GPIO_ACTIVE_HIGH>; /* LCD-BL-EN: PD5 */
+		power-supply = <&reg_vdd_backlight>;
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -126,6 +136,15 @@
 		};
 	};
 
+	reg_vdd_backlight: vdd-backlight {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-backlight";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&pio 3 7 GPIO_ACTIVE_HIGH>; /* LCD-PWR-EN: PD7 */
+		enable-active-high;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
@@ -169,6 +188,24 @@
 	status = "okay";
 };
 
+&dphy {
+	status = "okay";
+};
+
+&dsi {
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "bananapi,s070wv20-ct16-icn6211";
+		reg = <0>;
+		reset-gpios = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* LCD-RST: PD6 */
+		vdd-supply = <&reg_dldo1>;
+		backlight = <&backlight>;
+	};
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -261,6 +298,12 @@
 	status = "okay";
 };
 
+&r_pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_pwm_pin>;
+	status = "okay";
+};
+
 &r_rsb {
 	status = "okay";
 
-- 
2.18.0.321.gffc6fa0e3


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
