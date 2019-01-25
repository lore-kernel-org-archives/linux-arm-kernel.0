Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C91C282C3
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:25:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1B132085A
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="c46YLbzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1B132085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YuB7o1pH61LyPDydpFYH7yGRV5uYrhtPx7rZ1yoxWhw=; b=c46YLbzBWKO8o7
	iEOTHqNOivGng0MZb8vQhFT1omeFSVjbADYZMvuRhfgjqS3fXPhaIGFznlGWQ+/gAgPRv5lf3weIv
	4Cw5NhaWWT+iaunhWNrKduuaYWC0X53cuTxHXuF7XgiVkCfMTMRF+hvHYHlkkkKy3aBsLBr3akosm
	JTe7OCYsxybxeKVJiWR19usLXd463nuKhM+Q5AbBqCxwmlQKJ7ZN7yd7WZo4a3lDgb/1hBkD+ifxb
	iWG7wzk7jZvZVwBSVad5ormkeAlBK3kx+uRLD/GP1ZRqZYtMPvlP+MHw0iRrZVMwL7uqWvR2fLvzO
	qFmc5x2Vhi7CLY+Yvvzw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gms7k-00015j-2Q; Fri, 25 Jan 2019 03:25:44 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gms5U-0006gq-Nn
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 03:23:30 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 66C325FE11; Fri, 25 Jan 2019 11:23:15 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH 08/11] ARM: dts: sun8i-a33: Move display pipeline nodes to
 a23/a33 common dtsi
Date: Fri, 25 Jan 2019 11:23:11 +0800
Message-Id: <20190125032314.20915-9-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125032314.20915-1-wens@csie.org>
References: <20190125032314.20915-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_192325_651367_A7A11731 
X-CRM114-Status: GOOD (  15.60  )
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
 dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The display pipeline has the same structure, resources and connections
on both the A23 and A33. The differences include:

  - compatible strings
  - extra clock, reset control, and IO region for SAT in the backend
    only found on the A33
  - missing ch1 clock for the TCON

However, while the A23 has the TCON ch1 clock defined in the CCU, and
the channel 1 registers are available, it does not have any means to
use channel 1 due to a lack of downstream encoders, and the enable bit
for channel 1 is hard-wired to 0 (off).

As the MIPI DSI output device is not officially documented, and there
are no A23 reference devices to test it, it is not covered by this
patch.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 147 ++++++++++++++++++++
 arch/arm/boot/dts/sun8i-a33.dtsi     | 194 ++++++---------------------
 2 files changed, 185 insertions(+), 156 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 97ec8b8cec09..43fe215e83ea 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -68,6 +68,12 @@
 		};
 	};
 
+	de: display-engine {
+		/* compatible gets set in SoC specific dtsi file */
+		allwinner,pipelines = <&fe0>;
+		status = "disabled";
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -168,6 +174,42 @@
 			#size-cells = <0>;
 		};
 
+		tcon0: lcd-controller@1c0c000 {
+			/* compatible gets set in SoC specific dtsi file */
+			reg = <0x01c0c000 0x1000>;
+			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_LCD>,
+				 <&ccu CLK_LCD_CH0>;
+			clock-names = "ahb",
+				      "tcon-ch0";
+			clock-output-names = "tcon-pixel-clock";
+			resets = <&ccu RST_BUS_LCD>;
+			reset-names = "lcd";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				tcon0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					tcon0_in_drc0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&drc0_out_tcon0>;
+					};
+				};
+
+				tcon0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+				};
+			};
+		};
+
 		mmc0: mmc@1c0f000 {
 			compatible = "allwinner,sun7i-a20-mmc";
 			reg = <0x01c0f000 0x1000>;
@@ -570,6 +612,111 @@
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
 
+		fe0: display-frontend@1e00000 {
+			/* compatible gets set in SoC specific dtsi file */
+			reg = <0x01e00000 0x20000>;
+			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DE_FE>, <&ccu CLK_DE_FE>,
+				 <&ccu CLK_DRAM_DE_FE>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_BUS_DE_FE>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				fe0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					fe0_out_be0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&be0_in_fe0>;
+					};
+				};
+			};
+		};
+
+		be0: display-backend@1e60000 {
+			/* compatible gets set in SoC specific dtsi file */
+			reg = <0x01e60000 0x10000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DE_BE>, <&ccu CLK_DE_BE>,
+				 <&ccu CLK_DRAM_DE_BE>;
+			clock-names = "ahb", "mod",
+				      "ram";
+			resets = <&ccu RST_BUS_DE_BE>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				be0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					be0_in_fe0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&fe0_out_be0>;
+					};
+				};
+
+				be0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					be0_out_drc0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&drc0_in_be0>;
+					};
+				};
+			};
+		};
+
+		drc0: drc@1e70000 {
+			/* compatible gets set in SoC specific dtsi file */
+			reg = <0x01e70000 0x10000>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_DRC>, <&ccu CLK_DRC>,
+				 <&ccu CLK_DRAM_DRC>;
+			clock-names = "ahb", "mod", "ram";
+			resets = <&ccu RST_BUS_DRC>;
+
+			assigned-clocks = <&ccu CLK_DRC>;
+			assigned-clock-rates = <300000000>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				drc0_in: port@0 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0>;
+
+					drc0_in_be0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&be0_out_drc0>;
+					};
+				};
+
+				drc0_out: port@1 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <1>;
+
+					drc0_out_tcon0: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&tcon0_in_drc0>;
+					};
+				};
+			};
+		};
+
 		rtc: rtc@1f00000 {
 			compatible = "allwinner,sun8i-a23-rtc";
 			reg = <0x01f00000 0x400>;
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 626152c30f50..1111a6498102 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -159,12 +159,6 @@
 		};
 	};
 
-	de: display-engine {
-		compatible = "allwinner,sun8i-a33-display-engine";
-		allwinner,pipelines = <&fe0>;
-		status = "disabled";
-	};
-
 	iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&ths>;
@@ -209,47 +203,6 @@
 	};
 
 	soc {
-		tcon0: lcd-controller@1c0c000 {
-			compatible = "allwinner,sun8i-a33-tcon";
-			reg = <0x01c0c000 0x1000>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_LCD>,
-				 <&ccu CLK_LCD_CH0>;
-			clock-names = "ahb",
-				      "tcon-ch0";
-			clock-output-names = "tcon-pixel-clock";
-			resets = <&ccu RST_BUS_LCD>;
-			reset-names = "lcd";
-			status = "disabled";
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				tcon0_in: port@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					tcon0_in_drc0: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&drc0_out_tcon0>;
-					};
-				};
-
-				tcon0_out: port@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					tcon0_out_dsi: endpoint@1 {
-						reg = <1>;
-						remote-endpoint = <&dsi_in_tcon0>;
-					};
-				};
-			};
-		};
-
 		video-codec@1c0e000 {
 			compatible = "allwinner,sun8i-a33-video-engine";
 			reg = <0x01c0e000 0x1000>;
@@ -339,115 +292,6 @@
 			status = "disabled";
 			#phy-cells = <0>;
 		};
-
-		fe0: display-frontend@1e00000 {
-			compatible = "allwinner,sun8i-a33-display-frontend";
-			reg = <0x01e00000 0x20000>;
-			interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_DE_FE>, <&ccu CLK_DE_FE>,
-				 <&ccu CLK_DRAM_DE_FE>;
-			clock-names = "ahb", "mod",
-				      "ram";
-			resets = <&ccu RST_BUS_DE_FE>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				fe0_out: port@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					fe0_out_be0: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&be0_in_fe0>;
-					};
-				};
-			};
-		};
-
-		be0: display-backend@1e60000 {
-			compatible = "allwinner,sun8i-a33-display-backend";
-			reg = <0x01e60000 0x10000>, <0x01e80000 0x1000>;
-			reg-names = "be", "sat";
-			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_DE_BE>, <&ccu CLK_DE_BE>,
-				 <&ccu CLK_DRAM_DE_BE>, <&ccu CLK_BUS_SAT>;
-			clock-names = "ahb", "mod",
-				      "ram", "sat";
-			resets = <&ccu RST_BUS_DE_BE>, <&ccu RST_BUS_SAT>;
-			reset-names = "be", "sat";
-			assigned-clocks = <&ccu CLK_DE_BE>;
-			assigned-clock-rates = <300000000>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				be0_in: port@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					be0_in_fe0: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&fe0_out_be0>;
-					};
-				};
-
-				be0_out: port@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					be0_out_drc0: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&drc0_in_be0>;
-					};
-				};
-			};
-		};
-
-		drc0: drc@1e70000 {
-			compatible = "allwinner,sun8i-a33-drc";
-			reg = <0x01e70000 0x10000>;
-			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_DRC>, <&ccu CLK_DRC>,
-				 <&ccu CLK_DRAM_DRC>;
-			clock-names = "ahb", "mod", "ram";
-			resets = <&ccu RST_BUS_DRC>;
-
-			assigned-clocks = <&ccu CLK_DRC>;
-			assigned-clock-rates = <300000000>;
-
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				drc0_in: port@0 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <0>;
-
-					drc0_in_be0: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&be0_out_drc0>;
-					};
-				};
-
-				drc0_out: port@1 {
-					#address-cells = <1>;
-					#size-cells = <0>;
-					reg = <1>;
-
-					drc0_out_tcon0: endpoint@0 {
-						reg = <0>;
-						remote-endpoint = <&tcon0_in_drc0>;
-					};
-				};
-			};
-		};
 	};
 
 	thermal-zones {
@@ -524,10 +368,37 @@
 	};
 };
 
+&be0 {
+	compatible = "allwinner,sun8i-a33-display-backend";
+	/* A33 has an extra "SAT" module packed inside the display backend */
+	reg = <0x01e60000 0x10000>, <0x01e80000 0x1000>;
+	reg-names = "be", "sat";
+	clocks = <&ccu CLK_BUS_DE_BE>, <&ccu CLK_DE_BE>,
+		 <&ccu CLK_DRAM_DE_BE>, <&ccu CLK_BUS_SAT>;
+	clock-names = "ahb", "mod",
+		      "ram", "sat";
+	resets = <&ccu RST_BUS_DE_BE>, <&ccu RST_BUS_SAT>;
+	reset-names = "be", "sat";
+	assigned-clocks = <&ccu CLK_DE_BE>;
+	assigned-clock-rates = <300000000>;
+};
+
 &ccu {
 	compatible = "allwinner,sun8i-a33-ccu";
 };
 
+&de {
+	compatible = "allwinner,sun8i-a33-display-engine";
+};
+
+&drc0 {
+	compatible = "allwinner,sun8i-a33-drc";
+};
+
+&fe0 {
+	compatible = "allwinner,sun8i-a33-display-frontend";
+};
+
 &mali {
 	operating-points-v2 = <&mali_opp_table>;
 };
@@ -544,6 +415,17 @@
 
 };
 
+&tcon0 {
+	compatible = "allwinner,sun8i-a33-tcon";
+};
+
+&tcon0_out {
+	tcon0_out_dsi: endpoint@1 {
+		reg = <1>;
+		remote-endpoint = <&dsi_in_tcon0>;
+	};
+};
+
 &usb_otg {
 	compatible = "allwinner,sun8i-a33-musb";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
