From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 21 Aug 2013 11:28:25 +0400
Subject: [PATCH 3/3] ARM: dts: i.MX51: Add W1 devicetree node
In-Reply-To: <1377070105-15902-1-git-send-email-shc_work@mail.ru>
References: <1377070105-15902-1-git-send-email-shc_work@mail.ru>
Message-ID: <1377070105-15902-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing W1 (onewire) devicetree node for i.MX51 CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 09ecf29..2805132 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -379,6 +379,14 @@
 				clocks = <&clks 107>;
 			};
 
+			owire: owire at 83fa4000 {
+				compatible = "fsl,imx51-owire", "fsl,imx21-owire";
+				reg = <0x83fa4000 0x4000>;
+				interrupts = <88>;
+				clocks = <&clks 159>;
+				status = "disabled";
+			};
+
 			ecspi2: ecspi at 83fac000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.8.1.5
