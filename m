From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 24 Aug 2016 00:18:21 +0800
Subject: [PATCH] ARM: dts: imx6ul: set GINT to enable IOMUXC irq
Message-ID: <1471969101-12455-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add "fsl,imx6q-iomuxc-gpr" for IOMUXC-GPR to enable
IOMUXC irq which is required for ERR007265 software
workaround.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/imx6ul.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 33b95d7..acc9486 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -644,7 +644,8 @@
 			};
 
 			gpr: iomuxc-gpr at 020e4000 {
-				compatible = "fsl,imx6ul-iomuxc-gpr", "syscon";
+				compatible = "fsl,imx6ul-iomuxc-gpr",
+					     "fsl,imx6q-iomuxc-gpr", "syscon";
 				reg = <0x020e4000 0x4000>;
 			};
 
-- 
1.9.1
