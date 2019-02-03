Return-Path: <SRS0=H3s0=QK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7DDC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:58:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7DEA217D6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 18:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bYzv/h3b";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s8ZPUEca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7DEA217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EGpf0UNhhTvxE17GcpkQP7pJDE4NCXxpc4g06sPbxoY=; b=bYzv/h3bd2OBxz
	Nh1HEElJYXgkdli09hWpRfx2Q2cEWvnrZTqXrsPIkWQL3Evszde9B5BnhBwlSG/bGlPrsxBaoLyAH
	1s5U/MzS0H257FoZSrPA9Dr4Lprh5AB7fx0z62toGqh9ysi74NMnlnknGUYuvmxo+WaYE6nJlGLwo
	9vCwoSbOn+vcmWH/Du8oZArHi+xoqdUAsBRbFjDlTWgZbBfTrfg2tM4EKcQSFrsrAeV2pLI4Tr8xI
	fgMfOmgocDE3McPNkHn0dxEAaE7e4h/G6/+9UGua13nfXd/3gpy5wA+U+fXWijqee2A0xk1MRV7HA
	1j7eHMmBlltg7xjOBzrA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gqMyC-0007nC-6s; Sun, 03 Feb 2019 18:58:20 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gqMvj-0005KP-Fs
 for linux-arm-kernel@lists.infradead.org; Sun, 03 Feb 2019 18:56:02 +0000
Received: by mail-pf1-x444.google.com with SMTP id h3so5739972pfg.1
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 03 Feb 2019 10:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kR6J6Jtzwbwm5txsJfmr27+abRHklHlAdhM5mSBvkvM=;
 b=s8ZPUEca/BAlvashTKFiJSlvewxYdXpTROJF9LwiTHujpHSJrUhOygNeWxy+yhn9vl
 i8tTxq/MDKI55JLKdOfft5oT4TJHe8/hMyYhkZFnsVEiGe5VAvTWroM7wQ3JTNQU+NlE
 wU9CTt7YUJb90bkhZTN5wn94EoMqwL5LAxC9oahi0RXKC9IgVzBsZ1x4bvgkCiZo5dG0
 GWPRkKcfh6t2tYB6i9Ce6Tx8mbegKLrKh8kaht0rTToi1OMe+hHOPmHi3npoIH3VI7gl
 FghrEarqESU0lsaPoX267EFV/0m7XOb3jMGR3j60phepumL+3+Ij2F8vfuBAJ5U/N4YD
 EiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kR6J6Jtzwbwm5txsJfmr27+abRHklHlAdhM5mSBvkvM=;
 b=e7Id/I5uzlIGoeNnzK1YkHlaa4LludS2zQu0FkrIae4i1+LsCH/8mRoMPRW4X8h00l
 bBlCRxVw7EmzcQaQHVflDbOEGI1kQU56OvBwwiKXMSqxF/tJwPNfJLysuirLB4QVepcE
 j0/OnpOtM1flgDk8h0qaNcvlhWNNBB+2C4gNT8NsHSD3KVfLOwdkWHexfW9KbFzHKD1q
 a+4Xb/JxqyF7MkHPsbtmyRpWNNVWsQwxXvz4uUkgheXeqf8V26VQZUR4iYo4Uw/Vy86S
 0sFcH3FVHV/vBUUXMKUTZKC/x2W9Nz7NPpd/s26o0b8jY708AZ/QmdTjdAk0qjNlgpC/
 1Llw==
X-Gm-Message-State: AJcUukc2gZ6Hb0hn0WOa08K2hkeMFapSCgIyMna/5US3tpM4Sjqx6zR2
 mcxy1+fiK/RdinHYoENb8+Q=
X-Google-Smtp-Source: ALg8bN5LzsKHNoCXyuQAFQq1H1+UUHwSZMfSUic42loJlQIDA6h7MNb4vJKj1gimOAGRnk77J3/VjA==
X-Received: by 2002:a62:39cb:: with SMTP id u72mr47982735pfj.223.1549220146907; 
 Sun, 03 Feb 2019 10:55:46 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net.
 [216.71.213.236])
 by smtp.gmail.com with ESMTPSA id g28sm19524553pfd.100.2019.02.03.10.55.45
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 03 Feb 2019 10:55:46 -0800 (PST)
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
Subject: [PATCH RESEND v2 11/12] arm64: allwinner: a64: enable LCD-related
 hardware for Pinebook
Date: Sun,  3 Feb 2019 10:55:00 -0800
Message-Id: <20190203185501.8958-12-anarsoul@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190203185501.8958-1-anarsoul@gmail.com>
References: <20190203185501.8958-1-anarsoul@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190203_105548_256693_FA4DC4EB 
X-CRM114-Status: GOOD (  13.00  )
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

Enable all this hardware in device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index d22736a62481..49f5d4b0c7f4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -63,6 +63,18 @@
 		};
 	};
 
+	edp_panel: edp-panel {
+		compatible = "panel-edp", "simple-panel";
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
@@ -102,6 +114,10 @@
 	status = "okay";
 };
 
+&de {
+	status = "okay";
+};
+
 &ehci0 {
 	phys = <&usbphy 0>;
 	phy-names = "usb";
@@ -112,6 +128,10 @@
 	status = "okay";
 };
 
+&mixer0 {
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -163,6 +183,46 @@
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
 
@@ -334,6 +394,20 @@
 			"MIC2", "Internal Microphone Right";
 };
 
+&tcon0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&lcd_rgb666_pins>;
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
