From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 17 Nov 2016 03:30:51 +0200
Subject: [PATCH] ARM: dt: imx31: fix AVIC base address
Message-ID: <20161117013051.29381-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

On i.MX31 AVIC interrupt controller base address is at 0x68000000.

The problem was shadowed by the AVIC driver, which takes the correct
base address from a SoC specific header file.

Fixes: d2a37b3d91f4 ("ARM i.MX31: Add devicetree support")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
---
 arch/arm/boot/dts/imx31.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx31.dtsi b/arch/arm/boot/dts/imx31.dtsi
index c534c1f..179335b 100644
--- a/arch/arm/boot/dts/imx31.dtsi
+++ b/arch/arm/boot/dts/imx31.dtsi
@@ -31,11 +31,11 @@
 		};
 	};
 
-	avic: avic-interrupt-controller at 60000000 {
+	avic: interrupt-controller at 68000000 {
 		compatible = "fsl,imx31-avic", "fsl,avic";
 		interrupt-controller;
 		#interrupt-cells = <1>;
-		reg = <0x60000000 0x100000>;
+		reg = <0x68000000 0x100000>;
 	};
 
 	soc {
-- 
2.10.2
