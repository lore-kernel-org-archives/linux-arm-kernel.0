From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Sat, 24 Nov 2012 05:24:09 +0900
Subject: [PATCH v2] ARM: Kirkwood: Add support LED of OpenBlocks A6
Message-ID: <1353702249-4589-1-git-send-email-iwamatsu@nigauri.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OpenBlocks A6 has three leds via GPIO. This supports them.
And this fix typo about led, because hardware manual has typo.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 v2: Use gpio-leds, not gpio_leds.

 arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   19 +++++++++++++++++++
 arch/arm/mach-kirkwood/board-openblocks_a6.c |    4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 37dc3a7..e303169 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -75,4 +75,23 @@
 			};
 		};
 	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-red {
+			label = "obsa6:red:stat";
+			gpios = <&gpio1 9 1>;
+		};
+
+		led-green {
+			label = "obsa6:green:stat";
+			gpios = <&gpio1 10 1>;
+		};
+
+		led-yellow {
+			label = "obsa6:yellow:stat";
+			gpios = <&gpio1 11 1>;
+		};
+        };
 };
diff --git a/arch/arm/mach-kirkwood/board-openblocks_a6.c b/arch/arm/mach-kirkwood/board-openblocks_a6.c
index e71f984..815fc64 100644
--- a/arch/arm/mach-kirkwood/board-openblocks_a6.c
+++ b/arch/arm/mach-kirkwood/board-openblocks_a6.c
@@ -55,8 +55,8 @@ static unsigned int openblocks_a6_mpp_config[] __initdata = {
 	MPP38_GPIO, /* INIT */
 	MPP39_GPIO, /* USB OC */
 	MPP41_GPIO, /* LED: Red */
-	MPP42_GPIO, /* LED: Yellow */
-	MPP43_GPIO, /* LED: Green */
+	MPP42_GPIO, /* LED: Green */
+	MPP43_GPIO, /* LED: Yellow */
 	0,
 };
 
-- 
1.7.10.4
