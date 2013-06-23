From: eagle.alexander923@gmail.com (Alexander Shiyan)
Date: Sun, 23 Jun 2013 10:54:50 +0400
Subject: [PATCH 6/6] ARM: dts: imx27: Add kpp devicetree node
In-Reply-To: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
References: <1371970490-10874-1-git-send-email-eagle.alexander923@gmail.com>
Message-ID: <1371970490-10874-6-git-send-email-eagle.alexander923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexander Shiyan <shc_work@mail.ru>

This patch adds the missing (Keypad Port) KPP devicetree node
for i.MX27 CPUs.

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 arch/arm/boot/dts/imx27.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 85890d8..c20bbb7 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -110,6 +110,14 @@
 				clock-names = "ipg", "per";
 			};
 
+			kpp: kpp at 10008000 {
+				compatible = "fsl,imx27-kpp", "fsl,imx21-kpp";
+				reg = <0x10008000 0x1000>;
+				interrupts = <21>;
+				clocks = <&clks 37>;
+				status = "disabled";
+			};
+
 			uart1: serial at 1000a000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
-- 
1.8.1.5
