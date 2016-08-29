From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 29 Aug 2016 22:25:43 +0800
Subject: [PATCH V2] ARM: dts: imx6ul iomuxc syscon is compatible to imx6q
Message-ID: <1472480743-8405-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx6ul iomuxc syscon is compatible to imx6q,
so let's add compatible string 'fsl,imx6q-iomuxc-gpr'
for imx6ul iomuxc syscon node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
changes since V1:
	improve commit message.
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
