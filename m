Return-Path: <SRS0=JyYb=QI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D6C282D8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:48:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF43218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LMFrIqG7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ASdE33FX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF43218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qEAAw+cxhLYa59jVoPVquz6LOaMhqI6UeNbBHNdK6Ic=; b=LMFrIqG7l+W6D/
	dKfOwgT3ISPksh0NZr4sSAgazRE+XOgdP8a1FN+ppLcW+rXVNMUtZiRFEQ7gIDs7xYFGs8m3XaiL/
	ipDeODdWT3l/FaQV9FhHkepX0mQRIELCuZ3PJJGxEaeDnvpXf6JRk07m0q0n3rAZYC+IHt7xZumD/
	SXqj3pqiKVaGdY2CpcRHXPDb18aPe9h1wJewtj2ZuLGmO63J2vwXawEP8Z8zSyLRCM6x7m9h7i06B
	dVhF3fo9LNuBciVEDQlsKZoKHtMr77HN1gdXXWeFL+IfTGkj06cnIkLk5Cczdlmmr6DwIpw81hWEM
	RedMg38n4nixsh3AQ8yA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpb38-0008W6-KE; Fri, 01 Feb 2019 15:48:14 +0000
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpayO-0002aj-Um
 for linux-arm-kernel@lists.infradead.org; Fri, 01 Feb 2019 15:43:50 +0000
Received: by mail-lj1-x242.google.com with SMTP id k19-v6so6139063lji.11
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 01 Feb 2019 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=592MwDOO4fFABylW/PjMmeCRDtBAYuoeRyepsTAixok=;
 b=ASdE33FXsWRKqy6F/hssWaVQ1QsAlThJ9aDI+xU6R1ZgX6YRCQwZwAoypxQHJTmZqK
 RsQRP6J3mrv0tTTV9nXZvIzqH5S73gsxHwPYiiU1ZvFc0e44zemPOFE7iTCKv1npb8iN
 tnAZUHu4uxERMbpbRHW0DBLweu8E70XTq3vdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=592MwDOO4fFABylW/PjMmeCRDtBAYuoeRyepsTAixok=;
 b=QV6a3PhYZd+eARYVwKj9QPcru2MlXw7m7Y3FLo9GH0KcdiZVGqP+8hTrE0JVx/rIzn
 FrvxaRprPZVL9KYFUf5IEYCf4cXhO/vEZHkvkusRl4u83SImPqryJ2mfAR0ME4WZM+2h
 ADWCwebThbFPbGzZC+gaYoG2OD01Z1VJiRFmClpEKTNjaG1/cmkysSncdmq/WpcGUuZp
 CfA6vEWaUBX8QwmS8BcJDeqser0K5Novt1G2CZFKfsVAnkvw7U7+XHHm+yucGS4t7MIz
 ahyh6YbS2F4ubygYCCPOPKq7vXzbKsT0pXbtPJOHtmsj1nh1kFYRsAwK7CmG/neRPlQE
 6Rpw==
X-Gm-Message-State: AJcUuke6dASBIh+5TnFCB7diPG3IXXRpkF1oRZ2q3aF449gxkOkhxz8/
 5UoMvtUin+ALJReJM1QyO6+00g==
X-Google-Smtp-Source: ALg8bN4KGhCoNfa4yZRap6U1uakxpgRkOpnyPdXsyqJlvKzHPgkQvluGZF9rUFlkX+Xgzq01UctNgw==
X-Received: by 2002:a2e:910d:: with SMTP id
 m13-v6mr31326426ljg.187.1549035799118; 
 Fri, 01 Feb 2019 07:43:19 -0800 (PST)
Received: from localhost.localdomain ([217.76.202.68])
 by smtp.gmail.com with ESMTPSA id i13-v6sm1305712ljg.82.2019.02.01.07.43.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 01 Feb 2019 07:43:18 -0800 (PST)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [DO NOT MERGE][PATCH v7 20/23] arm64: dts: allwinner: bananapi-m64:
 Bananapi S070WV20-CT16 DSI panel
Date: Fri,  1 Feb 2019 21:12:29 +0530
Message-Id: <20190201154232.10505-21-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190201154232.10505-1-jagan@amarulasolutions.com>
References: <20190201154232.10505-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190201_074321_486584_64F7F3FB 
X-CRM114-Status: GOOD (  13.97  )
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
