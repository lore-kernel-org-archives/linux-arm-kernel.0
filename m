From: c.hemp@phytec.de (Christian Hemp)
Date: Fri, 14 Nov 2014 14:32:23 +0100
Subject: [PATCH 2/5] ARM:dts:imx6:phyFLEX: Enable gpmi in module file
In-Reply-To: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
References: <1415971946-48975-1-git-send-email-c.hemp@phytec.de>
Message-ID: <1415971946-48975-3-git-send-email-c.hemp@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The nand is on the module (PFL-A-02) and not on the baseboard (PBA-B-01).

Signed-off-by: Christian Hemp <c.hemp@phytec.de>
---
 arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi | 4 ----
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
index 6b2c892..111b1f5 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pbab01.dtsi
@@ -105,10 +105,6 @@
 	status = "okay";
 };
 
-&gpmi {
-	status = "okay";
-};
-
 &hdmi {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 585b823..af30653 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -91,7 +91,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_gpmi_nand>;
 	nand-on-flash-bbt;
-	status = "disabled";
+	status = "okay";
 };
 
 &i2c1 {
-- 
1.9.1
