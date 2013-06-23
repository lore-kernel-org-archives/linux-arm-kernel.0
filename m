From: eagle.alexander923@gmail.com (Alexander Shiyan)
Date: Sun, 23 Jun 2013 10:54:46 +0400
Subject: [PATCH 2/6] ARM: dts: imx27: Add AUDMUX devicetree node
In-Reply-To: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
References: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
Message-ID: <1371970490-10874-2-git-send-email-eagle.alexander923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shiyan <shc_work@mail.ru>

This patch adds the missing (Digital Audio MUX) AUDMUX devicetree
node for i.MX27 CPUs.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 04f9154..5009d93 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -260,6 +260,13 @@
 				#interrupt-cells = <2>;
 			};
 
+			audmux: audmux at 10016000 {
+				compatible = "fsl,imx27-audmux", "fsl,imx21-audmux";
+				reg = <0x10016000 0x1000>;
+				clocks = <&clks 0>;
+				clock-names = "audmux";
+			};
+
 			cspi3: cspi at 10017000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
1.8.1.5
