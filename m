From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Sep 2018 17:10:44 -0300
Subject: [PATCH 3/6] ARM: dts: imx51-zii-scu2-mezz: Disable VPU
In-Reply-To: <1536696647-8228-1-git-send-email-festevam@gmail.com>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
Message-ID: <1536696647-8228-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx51-zii-scu2-mezz does not have any video encoding/decoding needs,
so disable the VPU.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
index 26cf085..fc4a32c 100644
--- a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
@@ -342,6 +342,10 @@
 	vcc-supply = <&vusb2_reg>;
 };
 
+&vpu {
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
-- 
2.7.4
