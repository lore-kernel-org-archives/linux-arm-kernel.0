From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 16 Feb 2017 13:48:46 +0100
Subject: [PATCH 08/21] ARM: dts: sun8i-h3: add dwmac-sun8i rgmii pins
In-Reply-To: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
References: <20170216124859.14346-1-clabbe.montjoie@gmail.com>
Message-ID: <20170216124859.14346-9-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add pinctrl node for dwmac-sun8i on H3.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 61d56d2..59ed40e 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -349,6 +349,17 @@
 				function = "i2c2";
 			};
 
+			emac_rgmii_pins: emac0 at 0 {
+				allwinner,pins = "PD0", "PD1", "PD2", "PD3",
+						"PD4", "PD5", "PD7",
+						"PD8", "PD9", "PD10",
+						"PD12", "PD13", "PD15",
+						"PD16", "PD17";
+				allwinner,function = "emac";
+				allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				pins = "PF0", "PF1", "PF2", "PF3",
 				       "PF4", "PF5";
-- 
2.10.2
