Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16047C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72B321855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hqaJ6U8t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="VRB9wWzP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72B321855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=E1IFizi0lcKT2dBItaN5vBuKiqVeQrFJXs30r8T75Ks=; b=hqaJ6U8tCK3+ngo749RqLY7N0E
	gnwBBc6CMjE65wsIALxMRHHKNV/Evuu8hQ6klQGqzsL2QuPd4yWdGAPgYfL0BJXltJ6Iw8Wvqy/j9
	7HCL18KqN5wFAgKFXmZ+aQDkaLUlgvkPykh8t8Ljbw9CcvFqWBgVFdjtuDQR6Cf7ke4z4qhGIrydf
	oFSce3+OL/X/Rf1yLQlSxVfIUZcC6ZFMuhJ6dK0MczfiXQnPYLq7UcIrTTtWjOEUuGjXjQTtidr34
	yx2osa68p2uJP4+XECBFmk9EeTKAqLJgELndFsC49YXPCVpOS8Zn1bkUiHqz7VrUxLr+N2mwyoM4G
	9lUd6vUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmgrQ-0004YX-71; Thu, 24 Jan 2019 15:24:08 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmgl8-0001GQ-N4
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 15:18:04 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id A136325BF02;
 Fri, 25 Jan 2019 02:12:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1548342764; bh=v5DClrC0r0sEC0vy6ItBpfidme0s3L8AUKHh3miDLBE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VRB9wWzPT/SuvgnPxqMuwlbOM57MCQF/mZoH/O4fKP5QadluK11Fugq+RhozVinTZ
 GivkTs7embJc+3CLYsbuH6yFlEylPaReELkRvMpj7BBGkd5OX9J0X7TcjucLEFPsdI
 MVO0MCw408J5ZaVbHP65Vr4LwfqMA+67qjWyIQmQ=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 3558B940DF1; Thu, 24 Jan 2019 16:12:41 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH 36/44] arm64: dts: renesas: ulcb-kf: add pcm3168 sound codec
Date: Thu, 24 Jan 2019 16:12:30 +0100
Message-Id: <80c07701d5918928cb27370e4602e57f2a613515.1548233325.git.horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1548233325.git.horms+renesas@verge.net.au>
References: <cover.1548233325.git.horms+renesas@verge.net.au>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_071740_451281_B2864D0A 
X-CRM114-Status: GOOD (  11.22  )
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
Cc: Simon Horman <horms+renesas@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

KingFisher has pcm3168 sound codec. This patch enables it.
Because pcm3168 can't handle symmetric channel on playback/
capture, we need to handle it as different DAI.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 138 +++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 1b316d79df88..7a09576b3112 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -6,11 +6,38 @@
  * Copyright (C) 2017 Cogent Embedded, Inc.
  */
 
+/*
+ * SSI-PCM3168A
+ *	aplay   -D plughw:0,2 xxx.wav
+ *	arecord -D plughw:0,3 xxx.wav
+ */
+
 / {
 	aliases {
 		serial1 = &hscif0;
 		serial2 = &scif1;
 	};
+
+	clksndsel: clksndsel {
+		#clock-cells = <0>;
+		compatible = "gpio-mux-clock";
+		clocks = <&cs2000>, <&audio_clk_a>; /* clk8snd, clksnd */
+		select-gpios = <&gpio_exp_75 13 GPIO_ACTIVE_HIGH>;
+	};
+
+	snd_3p3v: regulator-snd_3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "snd-3.3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	snd_vcc5v: regulator-snd_vcc5v {
+		compatible = "regulator-fixed";
+		regulator-name = "snd-vcc5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+	};
 };
 
 &can0 {
@@ -44,6 +71,7 @@
 };
 
 &i2c2 {
+	/* U11 */
 	gpio_exp_74: gpio@74 {
 		compatible = "ti,tca9539";
 		reg = <0x74>;
@@ -53,6 +81,13 @@
 		interrupt-parent = <&gpio6>;
 		interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
 
+		audio_out_off {
+			gpio-hog;
+			gpios = <0 GPIO_ACTIVE_HIGH>; /* P00 */
+			output-high;
+			line-name = "Audio_Out_OFF";
+		};
+
 		hub_pwen {
 			gpio-hog;
 			gpios = <6 GPIO_ACTIVE_HIGH>;
@@ -80,8 +115,16 @@
 			output-high;
 			line-name = "OTG EXTLPn";
 		};
+
+		snd_rst {
+			gpio-hog;
+			gpios = <15 GPIO_ACTIVE_HIGH>; /* P17 */
+			output-high;
+			line-name = "SND_RST";
+		};
 	};
 
+	/* U5 */
 	gpio_exp_75: gpio@75 {
 		compatible = "ti,tca9539";
 		reg = <0x75>;
@@ -98,6 +141,48 @@
 		#size-cells = <0>;
 		reg = <0x71>;
 		reset-gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
+
+		/* Audio_SDA, Audio_SCL */
+		i2c@7 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <7>;
+
+			pcm3168a: audio-codec@44 {
+				#sound-dai-cells = <0>;
+				compatible = "ti,pcm3168a";
+				reg = <0x44>;
+				clocks = <&clksndsel>;
+				clock-names = "scki";
+
+				VDD1-supply	= <&snd_3p3v>;
+				VDD2-supply	= <&snd_3p3v>;
+				VCCAD1-supply	= <&snd_vcc5v>;
+				VCCAD2-supply	= <&snd_vcc5v>;
+				VCCDA1-supply	= <&snd_vcc5v>;
+				VCCDA2-supply	= <&snd_vcc5v>;
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					mclk-fs = <512>;
+					port@0 {
+						reg = <0>;
+						pcm3168a_endpoint_p: endpoint {
+							remote-endpoint = <&rsnd_for_pcm3168a_play>;
+							clocks = <&clksndsel>;
+						};
+					};
+					port@1 {
+						reg = <1>;
+						pcm3168a_endpoint_c: endpoint {
+							remote-endpoint = <&rsnd_for_pcm3168a_capture>;
+							clocks = <&clksndsel>;
+						};
+					};
+				};
+			};
+		};
 	};
 };
 
@@ -173,6 +258,11 @@
 		groups = "usb0";
 		function = "usb0";
 	};
+
+	sound_pcm_pins: sound-pcm {
+		groups = "ssi349_ctrl", "ssi3_data", "ssi4_data";
+		function = "ssi";
+	};
 };
 
 &scif1 {
@@ -193,3 +283,51 @@
 &xhci0 {
 	status = "okay";
 };
+
+&sound_card {
+	dais = <&rsnd_port0	/* ak4613 */
+		&rsnd_port1	/* HDMI0  */
+		&rsnd_port2	/* pcm3168a playback */
+		&rsnd_port3	/* pcm3168a capture  */
+		>;
+};
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins
+		     &sound_clk_pins
+		     &sound_pcm_pins>;
+
+	ports {
+		/* rsnd_port0/1 are on salvator-common */
+		rsnd_port2: port@2 {
+			reg = <2>;
+			rsnd_for_pcm3168a_play: endpoint {
+				remote-endpoint = <&pcm3168a_endpoint_p>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_for_pcm3168a_play>;
+				frame-master = <&rsnd_for_pcm3168a_play>;
+				dai-tdm-slot-num = <8>;
+
+				playback = <&ssi3>;
+			};
+		};
+		rsnd_port3: port@3 {
+			reg = <3>;
+			rsnd_for_pcm3168a_capture: endpoint {
+				remote-endpoint = <&pcm3168a_endpoint_c>;
+
+				dai-format = "i2s";
+				bitclock-master = <&rsnd_for_pcm3168a_capture>;
+				frame-master = <&rsnd_for_pcm3168a_capture>;
+				dai-tdm-slot-num = <6>;
+
+				capture  = <&ssi4>;
+			};
+		};
+	};
+};
+
+&ssi4 {
+	shared-pin;
+};
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
