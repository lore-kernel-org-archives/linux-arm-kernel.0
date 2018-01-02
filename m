From: stefan@agner.ch (Stefan Agner)
Date: Tue,  2 Jan 2018 17:42:22 +0100
Subject: [PATCH 6/7] ARM: dts: imx6ull: add IOMUXC SNVS instance
In-Reply-To: <20180102164223.15230-1-stefan@agner.ch>
References: <20180102164223.15230-1-stefan@agner.ch>
Message-ID: <20180102164223.15230-6-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX 6ULL features another IOMUX Controller called IOMUXC
SNVS which allows to control BOOT_MODE and TAMPER pins. Add the
controller to the i.MX 6ULL specific imx6ull.dtsi device tree.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx6ull.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index a58c01dc15c3..bc2cd4fb8b12 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -42,3 +42,20 @@
 #include "imx6ul.dtsi"
 #include "imx6ull-pinfunc.h"
 #include "imx6ull-pinfunc-snvs.h"
+
+/ {
+	soc {
+		aips3: aips-bus at 2200000 {
+			compatible = "fsl,aips-bus", "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x02200000 0x100000>;
+			ranges;
+
+			iomuxc_snvs: iomuxc-snvs at 2290000 {
+				compatible = "fsl,imx6ull-iomuxc-snvs";
+				reg = <0x02290000 0x4000>;
+			};
+		};
+	};
+};
-- 
2.15.1
