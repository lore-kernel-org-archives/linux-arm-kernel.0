From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 11 Aug 2014 09:14:36 -0300
Subject: [PATCH v2 1/6] ARM: mvebu: Add network pin mux configuration for the
 Armada 370 SoC
In-Reply-To: <1407759281-11513-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1407759281-11513-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1407759281-11513-2-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the pin mux configuration for the two network interfaces
and the MDIO interface in the Armada 370 SoC .dtsi file. Only the
configuration for RGMII is added for now.

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/armada-370.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 21b588b..f2c55f3 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -151,6 +151,25 @@
 						       "mpp62", "mpp60", "mpp58";
 					marvell,function = "audio";
 				};
+
+				mdio_pins: mdio-pins {
+					marvell,pins = "mpp17", "mpp18";
+					marvell,function = "ge";
+				};
+
+				ge0_rgmii_pins: ge0-rgmii-pins {
+					marvell,pins = "mpp5", "mpp6", "mpp7", "mpp8",
+						       "mpp9", "mpp10", "mpp11", "mpp12",
+						       "mpp13", "mpp14", "mpp15", "mpp16";
+					marvell,function = "ge0";
+				};
+
+				ge1_rgmii_pins: ge1-rgmii-pins {
+					marvell,pins = "mpp19", "mpp20", "mpp21", "mpp22",
+						       "mpp23", "mpp24", "mpp25", "mpp26",
+						       "mpp27", "mpp28", "mpp29", "mpp30";
+					marvell,function = "ge1";
+				};
 			};
 
 			gpio0: gpio at 18100 {
-- 
2.0.1
