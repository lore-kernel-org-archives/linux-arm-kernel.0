From: carlo@caione.org (Carlo Caione)
Date: Mon,  5 Jun 2017 22:03:50 +0200
Subject: [PATCH] ARM64: dts: meson-gx: Fix sensors reporting from SCP
Message-ID: <20170605200350.1113-1-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Switch to use the new compatible for the SCPI sensors so that the
sensor readings are reported using the correct scale.

Signed-off-by: Carlo Caione <carlo@endlessm.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 436b875..3128fa5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -200,7 +200,7 @@
 		};
 
 		scpi_sensors: sensors {
-			compatible = "arm,scpi-sensors";
+			compatible = "amlogic,meson-gxbb-scpi-sensors";
 			#thermal-sensor-cells = <1>;
 		};
 	};
-- 
2.9.3
