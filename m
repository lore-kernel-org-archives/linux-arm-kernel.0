From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Sep 2018 17:10:45 -0300
Subject: [PATCH 4/6] ARM: dts: imx51-zii-scu2-mezz: Disable the internal
 watchdog
In-Reply-To: <1536696647-8228-1-git-send-email-festevam@gmail.com>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
Message-ID: <1536696647-8228-4-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx51-zii-scu2-mezz has an external watchdog in the environment
microcontroller, so disable the internal one.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx51-zii-scu2-mezz.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
index fc4a32c..243d1c8 100644
--- a/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
+++ b/arch/arm/boot/dts/imx51-zii-scu2-mezz.dts
@@ -346,6 +346,10 @@
 	status = "disabled";
 };
 
+&wdog1 {
+	status = "disabled";
+};
+
 &iomuxc {
 	pinctrl_ecspi1: ecspi1grp {
 		fsl,pins = <
-- 
2.7.4
