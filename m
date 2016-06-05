From: hdegoede@redhat.com (Hans de Goede)
Date: Sun,  5 Jun 2016 14:22:48 +0200
Subject: [PATCH 2/2] ARM: dts: sun7i: HDMI and the tv-encoder use tcon ch1 not
 ch0
In-Reply-To: <1465129368-22335-1-git-send-email-hdegoede@redhat.com>
References: <1465129368-22335-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1465129368-22335-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the simplefb nodes for hdmi / tv-encoder out to point to
tcon0_ch1 instead of tcon0_ch0 as tcon clock.

While at it fix the clocks lines being longer then 80 chars.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 82e28c3..b9268d9 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -67,8 +67,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-hdmi";
-			clocks = <&ahb_gates 36>, <&ahb_gates 43>, <&ahb_gates 44>,
-				 <&de_be0_clk>, <&tcon0_ch0_clk>, <&dram_gates 26>;
+			clocks = <&ahb_gates 36>, <&ahb_gates 43>,
+				 <&ahb_gates 44>, <&de_be0_clk>,
+				 <&tcon0_ch1_clk>, <&dram_gates 26>;
 			status = "disabled";
 		};
 
@@ -86,8 +87,9 @@
 			compatible = "allwinner,simple-framebuffer",
 				     "simple-framebuffer";
 			allwinner,pipeline = "de_be0-lcd0-tve0";
-			clocks = <&ahb_gates 34>, <&ahb_gates 36>, <&ahb_gates 44>,
-				 <&de_be0_clk>, <&tcon0_ch0_clk>,
+			clocks = <&ahb_gates 34>, <&ahb_gates 36>,
+				 <&ahb_gates 44>,
+				 <&de_be0_clk>, <&tcon0_ch1_clk>,
 				 <&dram_gates 5>, <&dram_gates 26>;
 			status = "disabled";
 		};
-- 
2.7.4
