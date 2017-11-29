From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 29 Nov 2017 16:54:42 -0200
Subject: [PATCH v2 09/11] ARM: dts: vfxxx: Move nodes which have no reg
 property out of bus
In-Reply-To: <1511981684-13433-1-git-send-email-festevam@gmail.com>
References: <1511981684-13433-1-git-send-email-festevam@gmail.com>
Message-ID: <1511981684-13433-9-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Move iio-hwmon node from soc node to root node.

iio-hwmon node does not have any register properties and thus
shouldn't be placed on the bus.

This fixes the following build warnings with W=1:

arch/arm/boot/dts/vf500-colibri-eval-v3.dtb: Warning (simple_bus_reg): Node /soc/iio-hwmon missing or empty reg/ranges property

Based on a patch from Simon Horman for the renesas r8a7795 dtsi.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v1:
- None

 arch/arm/boot/dts/vfxxx.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 5d654b5..c3f09b7 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -84,6 +84,11 @@
 		mask = <0x1000>;
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc0 16>, <&adc1 16>;
+	};
+
 	soc {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -762,10 +767,5 @@
 				status = "disabled";
 			};
 		};
-
-		iio-hwmon {
-			compatible = "iio-hwmon";
-			io-channels = <&adc0 16>, <&adc1 16>;
-		};
 	};
 };
-- 
2.7.4
