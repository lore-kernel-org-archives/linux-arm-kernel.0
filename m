From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 6 Sep 2016 12:53:11 -0300
Subject: [PATCH 5/9] ARM: dts: imx25: Fix memory node build warnings with W=1
In-Reply-To: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
References: <1473177196-29371-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1473177196-29371-5-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following build warnings with W=1:

Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

While at it, also pass the 'device_type' property as recommended by the
ePAPR specification.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi | 3 ++-
 arch/arm/boot/dts/imx25-karo-tx25.dts        | 3 ++-
 arch/arm/boot/dts/imx25-pdk.dts              | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
index d6f2764..e4d7da2 100644
--- a/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
+++ b/arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi
@@ -17,7 +17,8 @@
 	model = "Eukrea CPUIMX25";
 	compatible = "eukrea,cpuimx25", "fsl,imx25";
 
-	memory {
+	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x4000000>; /* 64M */
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index 9b31faa..d8ec158 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -36,7 +36,8 @@
 		};
 	};
 
-	memory {
+	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index 7029210..8ce72fa 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -18,7 +18,8 @@
 	model = "Freescale i.MX25 Product Development Kit";
 	compatible = "fsl,imx25-pdk", "fsl,imx25";
 
-	memory {
+	memory at 80000000 {
+		device_type = "memory";
 		reg = <0x80000000 0x4000000>;
 	};
 
-- 
1.9.1
