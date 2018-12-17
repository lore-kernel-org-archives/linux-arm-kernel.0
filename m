Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FA5C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:11:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4210220656
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqEHvkHx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="TZe5Bqvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4210220656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=FMZDABAH5lvKQFXSXBh5KOJkh+zkjK6K8ptdALcf8DY=; b=iqE
	HvkHxo3u4ejs7lrCkGHaM37dy3OtYYxiC8xdXXLPMjpKRYZTSAANriEiJun139vEfHFqOA8EmmwPj
	c++ERm0j4lgHjp3h1gatfiOCH3C4yU//hJKFK7zy3BVTjKMX85YTxozvaI3+0rBCskk1Ldxmh6Yj/
	6Zq8fgt7NcqRq0GiB1CkuaFw0UE+pkBz++n5TGfeZJLfFPEK+pzRxZJcseUIDtgbb5ckoRj2J9oeq
	pz9bCx08Aa4oHihv8wFNwBkNhC7wxegF6+ODYaUJw7b7bEEjYjmRJqkqVbaNaI7R7+vjspDmIo8Vq
	8ban+Z20ICTSoUhcc4LShB/WJaH3tVw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYsfx-00033s-5S; Mon, 17 Dec 2018 13:11:13 +0000
Received: from kirsty.vergenet.net ([202.4.237.240])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYsfs-00032Z-Uj
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 13:11:11 +0000
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
 by kirsty.vergenet.net (Postfix) with ESMTPA id 5CE4625B781;
 Tue, 18 Dec 2018 00:10:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
 t=1545052257; bh=CkAwgZzhoKjI24SeDO+/g8i+/i0r/6C6mg/JUSuhfw0=;
 h=From:To:Cc:Subject:Date:From;
 b=TZe5Bqvj8XWSksPoYQbDqRMs/kH4TDx0Uy1I11nXNhEGzWQDQg4ro/4f+emBsPC/j
 M6gNYCH4XiVuIjw9fEKMdb15dlMBCc9FsJxhjRRFM3WyQG3G7sDDaDX+8kVdxLq2wI
 uM/I5uVfdRE8q50HLNBZ0OaDudpmSxOW8NiK5vsA=
Received: by reginn.horms.nl (Postfix, from userid 7100)
 id 5609194048A; Mon, 17 Dec 2018 14:10:55 +0100 (CET)
From: Simon Horman <horms+renesas@verge.net.au>
To: linux-renesas-soc@vger.kernel.org
Subject: [PATCH/RFC] arm64: dts: renesas: sort subnodes of root node in board
 files
Date: Mon, 17 Dec 2018 14:10:52 +0100
Message-Id: <20181217131052.18790-1-horms+renesas@verge.net.au>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181217_051109_318733_93862D02 
X-CRM114-Status: GOOD (  12.11  )
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
 Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Sort subnodes of root node in board files alphabetically by node
names. This aims to provide a simple rule for consistent
node placement to reduce maintenance burden.

This should not have any run-time effect.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77970-eagle.dts   |  30 ++--
 arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts   |  70 +++++-----
 arch/arm64/boot/dts/renesas/r8a77980-condor.dts  |  66 ++++-----
 arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts   |  12 +-
 arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts   | 166 +++++++++++------------
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts   |  10 +-
 arch/arm64/boot/dts/renesas/salvator-common.dtsi |  84 ++++++------
 arch/arm64/boot/dts/renesas/ulcb.dtsi            |  42 +++---
 8 files changed, 240 insertions(+), 240 deletions(-)

 Based on renesas-devel-20181213-v4.20-rc6

diff --git a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
index b6d53321576b..bd5791699a31 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-eagle.dts
@@ -23,12 +23,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0x0 0x48000000 0x0 0x38000000>;
-	};
-
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -40,15 +34,6 @@
 		};
 	};
 
-	d3p3: regulator-fixed {
-		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
 	lvds-decoder {
 		compatible = "thine,thc63lvd1024";
 
@@ -73,6 +58,21 @@
 			};
 		};
 	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+
+	d3p3: regulator-fixed {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &avb {
diff --git a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
index 0dbcb4cccc18..cc41eb323158 100644
--- a/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
@@ -21,6 +21,41 @@
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&adv7511_out>;
+			};
+		};
+	};
+
+	lvds-decoder {
+		compatible = "thine,thc63lvd1024";
+		vcc-supply = <&vcc_d3_3v>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				thc63lvd1024_in: endpoint {
+					remote-endpoint = <&lvds0_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				thc63lvd1024_out: endpoint {
+					remote-endpoint = <&adv7511_in>;
+				};
+			};
+		};
+	};
+
 	memory@48000000 {
 		device_type = "memory";
 		/* first 128MB is reserved for secure area. */
@@ -59,41 +94,6 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
-
-	lvds-decoder {
-		compatible = "thine,thc63lvd1024";
-		vcc-supply = <&vcc_d3_3v>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				thc63lvd1024_in: endpoint {
-					remote-endpoint = <&lvds0_out>;
-				};
-			};
-
-			port@2 {
-				reg = <2>;
-				thc63lvd1024_out: endpoint {
-					remote-endpoint = <&adv7511_in>;
-				};
-			};
-		};
-	};
-
-	hdmi-out {
-		compatible = "hdmi-connector";
-		type = "a";
-
-		port {
-			hdmi_con: endpoint {
-				remote-endpoint = <&adv7511_out>;
-			};
-		};
-	};
 };
 
 &avb {
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
index 5a7012be0d6a..345ac8616c40 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-condor.dts
@@ -22,39 +22,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0 0x48000000 0 0x78000000>;
-	};
-
-	d3_3v: regulator-0 {
-		compatible = "regulator-fixed";
-		regulator-name = "D3.3V";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	vddq_vin01: regulator-1 {
-		compatible = "regulator-fixed";
-		regulator-name = "VDDQ_VIN01";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
-	d1_8v: regulator-2 {
-		compatible = "regulator-fixed";
-		regulator-name = "D1.8V";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-boot-on;
-		regulator-always-on;
-	};
-
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -90,6 +57,39 @@
 		};
 	};
 
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0 0x48000000 0 0x78000000>;
+	};
+
+	d3_3v: regulator-0 {
+		compatible = "regulator-fixed";
+		regulator-name = "D3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	vddq_vin01: regulator-1 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDQ_VIN01";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	d1_8v: regulator-2 {
+		compatible = "regulator-fixed";
+		regulator-name = "D1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	x1_clk: x1-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
index dd14a41b32cd..adbfd8f07d06 100644
--- a/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77980-v3hsk.dts
@@ -22,12 +22,6 @@
 		stdout-path = "serial0:115200n8";
 	};
 
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0 0x48000000 0 0x78000000>;
-	};
-
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -63,6 +57,12 @@
 		};
 	};
 
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0 0x48000000 0 0x78000000>;
+	};
+
 	osc1_clk: osc1-clock {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
index 62bdddcbbae7..7bd0a1a71bc4 100644
--- a/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77990-ebisu.dts
@@ -18,17 +18,6 @@
 		ethernet0 = &avb;
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@48000000 {
-		device_type = "memory";
-		/* first 128MB is reserved for secure area. */
-		reg = <0x0 0x48000000 0x0 0x38000000>;
-	};
-
 	audio_clkout: audio-clkout {
 		/*
 		 * This is same as <&rcar_sound 0>
@@ -39,6 +28,11 @@
 		clock-frequency = <11289600>;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
 	cvbs-in {
 		compatible = "composite-video-connector";
 		label = "CVBS IN";
@@ -97,36 +91,10 @@
 		};
 	};
 
-	vga {
-		compatible = "vga-connector";
-
-		port {
-			vga_in: endpoint {
-				remote-endpoint = <&adv7123_out>;
-			};
-		};
-	};
-
-	vga-encoder {
-		compatible = "adi,adv7123";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 {
-				reg = <0>;
-				adv7123_in: endpoint {
-					remote-endpoint = <&du_out_rgb>;
-				};
-			};
-			port@1 {
-				reg = <1>;
-				adv7123_out: endpoint {
-					remote-endpoint = <&vga_in>;
-				};
-			};
-		};
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
 	reg_1p8v: regulator0 {
@@ -158,46 +126,25 @@
 		enable-active-high;
 	};
 
-	rsnd_ak4613: sound {
-		compatible = "simple-scu-audio-card";
-
-		simple-audio-card,name = "rsnd-ak4613";
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcpu>;
-		simple-audio-card,frame-master = <&sndcpu>;
-
-		simple-audio-card,prefix = "ak4613";
-		simple-audio-card,routing = "ak4613 Playback", "DAI0 Playback",
-		"DAI0 Capture", "ak4613 Capture";
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&ak4613>;
-		};
-	};
+	vcc_sdhi0: regulator-vcc-sdhi0 {
+		compatible = "regulator-fixed";
 
-	x12_clk: x12 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24576000>;
-	};
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 
-	x13_clk: x13 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <74250000>;
+		gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
 	};
 
-	vcc_sdhi0: regulator-vcc-sdhi0 {
+	vcc_sdhi1: regulator-vcc-sdhi1 {
 		compatible = "regulator-fixed";
 
-		regulator-name = "SDHI0 Vcc";
+		regulator-name = "SDHI1 Vcc";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 
-		gpio = <&gpio5 17 GPIO_ACTIVE_HIGH>;
+		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
 
@@ -214,17 +161,6 @@
 			  1800000 0>;
 	};
 
-	vcc_sdhi1: regulator-vcc-sdhi1 {
-		compatible = "regulator-fixed";
-
-		regulator-name = "SDHI1 Vcc";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpio = <&gpio0 4 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
 	vccq_sdhi1: regulator-vccq-sdhi1 {
 		compatible = "regulator-gpio";
 
@@ -237,6 +173,70 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	rsnd_ak4613: sound {
+		compatible = "simple-scu-audio-card";
+
+		simple-audio-card,name = "rsnd-ak4613";
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcpu>;
+		simple-audio-card,frame-master = <&sndcpu>;
+
+		simple-audio-card,prefix = "ak4613";
+		simple-audio-card,routing = "ak4613 Playback", "DAI0 Playback",
+		"DAI0 Capture", "ak4613 Capture";
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4613>;
+		};
+	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
+
+	vga-encoder {
+		compatible = "adi,adv7123";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7123_in: endpoint {
+					remote-endpoint = <&du_out_rgb>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_in>;
+				};
+			};
+		};
+	};
+
+	x12_clk: x12 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+
+	x13_clk: x13 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
 };
 
 &audio_clk_a {
diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 89df9bc844c0..406d9407a969 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -19,11 +19,6 @@
 		ethernet0 = &avb;
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel";
-		stdout-path = "serial0:115200n8";
-	};
-
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 50000>;
@@ -35,6 +30,11 @@
 		enable-gpios = <&gpio4 0 GPIO_ACTIVE_HIGH>;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = "serial0:115200n8";
+	};
+
 	composite-in {
 		compatible = "composite-video-connector";
 
diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index a225c2457274..97aca41edc9a 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -37,11 +37,6 @@
 		ethernet0 = &avb;
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = "serial0:115200n8";
-	};
-
 	audio_clkout: audio-clkout {
 		/*
 		 * This is same as <&rcar_sound 0>
@@ -63,6 +58,11 @@
 		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = "serial0:115200n8";
+	};
+
 	cvbs-in {
 		compatible = "composite-video-connector";
 		label = "CVBS IN";
@@ -86,6 +86,28 @@
 		};
 	};
 
+	hdmi0-out {
+		compatible = "hdmi-connector";
+		label = "HDMI0 OUT";
+		type = "a";
+
+		port {
+			hdmi0_con: endpoint {
+			};
+		};
+	};
+
+	hdmi1-out {
+		compatible = "hdmi-connector";
+		label = "HDMI1 OUT";
+		type = "a";
+
+		port {
+			hdmi1_con: endpoint {
+			};
+		};
+	};
+
 	reg_1p8v: regulator0 {
 		compatible = "regulator-fixed";
 		regulator-name = "fixed-1.8V";
@@ -113,14 +135,6 @@
 		regulator-always-on;
 	};
 
-	sound_card: sound {
-		compatible = "audio-graph-card";
-
-		label = "rcar-sound";
-
-		dais = <&rsnd_port0>;
-	};
-
 	vbus0_usb2: regulator-vbus0-usb2 {
 		compatible = "regulator-fixed";
 
@@ -143,19 +157,6 @@
 		enable-active-high;
 	};
 
-	vccq_sdhi0: regulator-vccq-sdhi0 {
-		compatible = "regulator-gpio";
-
-		regulator-name = "SDHI0 VccQ";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3300000>;
-
-		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-		gpios-states = <1>;
-		states = <3300000 1
-			  1800000 0>;
-	};
-
 	vcc_sdhi3: regulator-vcc-sdhi3 {
 		compatible = "regulator-fixed";
 
@@ -180,26 +181,25 @@
 			  1800000 0>;
 	};
 
-	hdmi0-out {
-		compatible = "hdmi-connector";
-		label = "HDMI0 OUT";
-		type = "a";
+	vccq_sdhi0: regulator-vccq-sdhi0 {
+		compatible = "regulator-gpio";
 
-		port {
-			hdmi0_con: endpoint {
-			};
-		};
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
 	};
 
-	hdmi1-out {
-		compatible = "hdmi-connector";
-		label = "HDMI1 OUT";
-		type = "a";
+	sound_card: sound {
+		compatible = "audio-graph-card";
 
-		port {
-			hdmi1_con: endpoint {
-			};
-		};
+		label = "rcar-sound";
+
+		dais = <&rsnd_port0>;
 	};
 
 	vga {
diff --git a/arch/arm64/boot/dts/renesas/ulcb.dtsi b/arch/arm64/boot/dts/renesas/ulcb.dtsi
index f519d0cf643c..e48cc5903394 100644
--- a/arch/arm64/boot/dts/renesas/ulcb.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb.dtsi
@@ -17,11 +17,6 @@
 		ethernet0 = &avb;
 	};
 
-	chosen {
-		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = "serial0:115200n8";
-	};
-
 	audio_clkout: audio-clkout {
 		/*
 		 * This is same as <&rcar_sound 0>
@@ -32,6 +27,11 @@
 		clock-frequency = <12288000>;
 	};
 
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = "serial0:115200n8";
+	};
+
 	hdmi0-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -83,22 +83,6 @@
 		regulator-always-on;
 	};
 
-	rsnd_ak4613: sound {
-		compatible = "simple-audio-card";
-
-		simple-audio-card,format = "left_j";
-		simple-audio-card,bitclock-master = <&sndcpu>;
-		simple-audio-card,frame-master = <&sndcpu>;
-
-		sndcpu: simple-audio-card,cpu {
-			sound-dai = <&rcar_sound>;
-		};
-
-		sndcodec: simple-audio-card,codec {
-			sound-dai = <&ak4613>;
-		};
-	};
-
 	vcc_sdhi0: regulator-vcc-sdhi0 {
 		compatible = "regulator-fixed";
 
@@ -123,6 +107,22 @@
 			  1800000 0>;
 	};
 
+	rsnd_ak4613: sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcpu>;
+		simple-audio-card,frame-master = <&sndcpu>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4613>;
+		};
+	};
+
 	x12_clk: x12 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-- 
2.11.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
