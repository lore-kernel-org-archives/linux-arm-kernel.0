From: icenowy@aosc.io (Icenowy Zheng)
Date: Fri, 22 Jun 2018 20:45:39 +0800
Subject: [PATCH v2 6/7] arm64: allwinner: a64: add device tree node for HDMI
 simplefb
In-Reply-To: <20180622124540.56203-1-icenowy@aosc.io>
References: <20180622124540.56203-1-icenowy@aosc.io>
Message-ID: <20180622124540.56203-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the U-Boot bootloader now is also capable of initialize the HDMI on
A64 boards, add a simplefb device tree node for accessing the HDMI
framebuffer initialized by the bootloader.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v2:
- Dropped LCD SimpleFB as it's already added. LCD SimpleFB needs some
  fix but the fix is present when adding DE2 CCU.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 318c4ba8ae9f..840753432ea5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -68,6 +68,15 @@
 				 <&display_clocks CLK_MIXER0>;
 			status = "disabled";
 		};
+
+		simplefb_hdmi: framebuffer-hdmi {
+			compatible = "allwinner,simple-framebuffer",
+				     "simple-framebuffer";
+			allwinner,pipeline = "mixer1-lcd1-hdmi";
+			clocks = <&display_clocks CLK_MIXER1>,
+				 <&ccu CLK_TCON1>, <&ccu CLK_HDMI>;
+			status = "disabled";
+		};
 	};
 
 	cpus {
-- 
2.17.1
