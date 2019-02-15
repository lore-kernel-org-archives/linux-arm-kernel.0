Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18592C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:22:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90C021B1C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 05:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Rxxt5+Jx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZx+M/Xf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90C021B1C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zSdQj8LsvvzBhI2qYTuLXXvd18PoPsQc4DHImCTQDzA=; b=Rxxt5+Jxa0XtfK
	VUUzTCvL47B6DZkU4vf7u2RMcbb3yg3w0u9CQ9IbeRry7T6f5q0Xus9I7mWL3+UhDY/KAKtyjJUPr
	FXzrlu8/+97hvOP0FTcrXhU+AXJkFHjPG/YksHOFoqQJ1XSur2EszGv+KVnDmTMkAhasZk3iJVIrR
	5NgSrKE+sFmvEPX0YysoMuZ+DJRjfe7X9UiLtc/jyHC4dS0PJWlNcGwMRaQEaXTuWxfI1fMZXWNlJ
	5NvCPbJybkwzedHcHbHBSUYBfaQzBgOvHMxhj2v0CMvvINNBC3h5MP2pjq1xQxRl5VmMQGkdmQF/N
	luBlcDmmeSNtxHa23tkA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guVxL-0000mk-Em; Fri, 15 Feb 2019 05:22:35 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guVli-0003gU-6G
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 05:10:38 +0000
Received: by mail-pf1-x443.google.com with SMTP id v21so1255861pfm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 21:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=t0ArzoJQn0oHXDNAHgLtx/X1H+X8HY2qzxjqcsB9+Oc=;
 b=HZx+M/XfP82BRjqpcJPU2qJdp2nmvOrH6bQcUwqJxgXLXAWBklVfpVW5aSjXvnBUYr
 W9sGtgMCWRT8J6wAjXYk743N6fcde+93pkZh7GlKyaSIDqQ1FlbKC50Q26HaGSQ2XkRC
 /nJDNZFVt76MZZctvjgeDenbI3NuhZtedb2Epea5l0Fa1n6vAns61yPNj6exsGrTo6cK
 rWZy26H0rF4KS659h/moVr/cGpNIqNEn3ivExNOaLHoeR/uuW3uBl1+3CsoEUZwZKVJn
 fWN0cBTBsqJ4vQYtJq3gUk5kX5jyw3GpcA7a1zAzBK3rcFpWx3KjguTQlOYgYoVlnHUC
 pHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=t0ArzoJQn0oHXDNAHgLtx/X1H+X8HY2qzxjqcsB9+Oc=;
 b=I5OSZkrazLYcUlNfNf27ApZmmTSlkaw9zIqXC5Mq+nOlNDlpVlZRPs1D6unRDzGn1d
 Mk8e5qWKoZedUk9TB0pFl7uxF/KG8kkYvydm6vEreN6yhqQQxldf2GU6zPHVume4zE/D
 QuDum11vL3Wtjr98Um339xy4hWZ2q/jrJ/F0NNs3moK69TYuNIfgZthd3EWn5QsQvDFu
 5leldbZIkp1CtyTonVzgMRQlx3uZOoxLbvibxap++uW6tDYZxvMgWiBjiAxFMJFzvIa4
 wqlOlYjrbm47+LvvWnJOtV0jB+J2Tw9hHiNthpUhER1jbdr5kzsZHEold3Lb9W/bocNu
 a4Og==
X-Gm-Message-State: AHQUAuZQf5YSA3GAFncoZk3nJCIvNAuLs8YwwDBZ5PiNqYH/GMcQ3Aq4
 WU90c4pwbDIfDkMxskSTXno=
X-Google-Smtp-Source: AHgI3IZrmdPthtTnu8fR7wKBTEbuCapy3IvXmNTKnoUdJV1tqd0BFYs1DHZVzzS5eZabXWheFcHZ9w==
X-Received: by 2002:a63:4913:: with SMTP id w19mr3584773pga.394.1550207433708; 
 Thu, 14 Feb 2019 21:10:33 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id m9sm4900442pgr.7.2019.02.14.21.10.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 21:10:33 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Archit Taneja <architt@codeaurora.org>,
 Andrzej Hajda <a.hajda@samsung.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Icenowy Zheng <icenowy@aosc.io>, Sean Paul <seanpaul@chromium.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com
Subject: [PATCH v3 11/11] arm64: allwinner: a64: enable LCD-related hardware
 for Pinebook
Date: Thu, 14 Feb 2019 21:09:57 -0800
Message-Id: <20190215050957.20755-12-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215050957.20755-1-anarsoul@gmail.com>
References: <20190215050957.20755-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_211034_448607_949E60E8 
X-CRM114-Status: GOOD (  13.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.io>

Pinebook has an ANX6345 bridge connected to the RGB666 LCD output and
eDP panel input. The bridge is controlled via I2C that's connected to
R_I2C bus.

There're pinebooks with 3 different panels in the wild, all 3 with
different timings. Add all the compatibles to panel node and hope that
we can get correct timings from EDID. If reading EDID fails it's up to
firmware to fixup compatible string.

Enable all this hardware in device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index d22736a62481..0d9280bafc12 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -63,6 +63,19 @@
 		};
 	};
 
+	edp_panel: edp-panel {
+		compatible = "boe,hb140wx1-501", "innolux,n116bge",
+			     "neweast,wjfh116008a", "simple-panel";
+		backlight = <&backlight>;
+		power-supply = <&reg_dc1sw>;
+
+		port {
+			panel_in_edp: endpoint {
+				remote-endpoint = <&anx6345_out_panel>;
+			};
+		};
+	};
+
 	reg_vcc3v3: vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
@@ -102,6 +115,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	phys = <&usbphy 0>;
 	phy-names = "usb";
@@ -112,6 +129,10 @@
 	status = "okay";
 };
 
+&mixer0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -163,6 +184,46 @@
 	status = "okay";
 };
 
+&r_i2c {
+	pinctrl-names = "default";
+	pinctrl-0 = <&r_i2c_pins_a>;
+	status = "okay";
+
+	anx6345: anx6345@38 {
+		compatible = "analogix,anx6345";
+		reg = <0x38>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+		dvdd25-supply = <&reg_dldo2>;
+		dvdd12-supply = <&reg_fldo1>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			anx6345_in: port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <0>;
+				anx6345_in_tcon0: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&tcon0_out_anx6345>;
+				};
+			};
+
+			anx6345_out: port@1 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <1>;
+
+				anx6345_out_panel: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&panel_in_edp>;
+				};
+			};
+		};
+	};
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -334,6 +395,21 @@
 			"MIC2", "Internal Microphone Right";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
+	no-strict-clock-check;
+
+	status = "okay";
+};
+
+&tcon0_out {
+	tcon0_out_anx6345: endpoint@0 {
+		reg = <0>;
+		remote-endpoint = <&anx6345_in_tcon0>;
+	};
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pb_pins>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
