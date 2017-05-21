From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 21 May 2017 13:10:34 -0300
Subject: [PATCH] ARM: dts: imx6: Fix BCM43xx node name
Message-ID: <1495383034-2201-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

"bcrmf" is a typo and "wifi" is the preferred form to describe
such node, so change it accordingly.

Reported-by: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Based on the following dt documentation commit:
https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=442e1f7eb8e6858408a7ad58bb10813c19877ae5

 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts | 2 +-
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
index 802da45..ac1989e 100644
--- a/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
+++ b/arch/arm/boot/dts/imx6sx-nitrogen6sx.dts
@@ -374,7 +374,7 @@
 	cap-sdio-irq;
 	status = "okay";
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio7>;
diff --git a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
index 51095df..aec5ccc 100644
--- a/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-opos6ul.dtsi
@@ -120,7 +120,7 @@
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	brcmf: bcrmf at 1 {
+	brcmf: wifi at 1 {
 		compatible = "brcm,bcm4329-fmac";
 		reg = <1>;
 		interrupt-parent = <&gpio2>;
-- 
2.7.4
