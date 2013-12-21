From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Dec 2013 11:11:39 +0400
Subject: [PATCH 3/6] ARM: dts: imx27-phytec-phycore-som: Add spi-cs-high
 property to PMIC
In-Reply-To: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
References: <1387609902-13361-1-git-send-email-shc_work@mail.ru>
Message-ID: <1387609902-13361-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since SPI core does not use GPIO bindings for CS GPIOs,
we should add an active high level declaration.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
index 94ba726..c934999 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi
@@ -61,8 +61,9 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		compatible = "fsl,mc13783";
-		spi-max-frequency = <20000000>;
 		reg = <0>;
+		spi-cs-high;
+		spi-max-frequency = <20000000>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
 		fsl,mc13xxx-uses-adc;
-- 
1.8.3.2
