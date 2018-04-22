From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 22 Apr 2018 16:21:51 +0200
Subject: [PATCH] ARM: dts: imx6qdl-cubox-i: Move card-detect GPIO to 1.5 SOM
 devices only
Message-ID: <20180422142151.17910-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Solid-Run CuBox-i lower board used in the first generation of
CuBox-i devices feature a hinged micro SD card slot, that does not have
card-detect capability. Since the card-detect GPIO was specified in the
common cubox-i dtsi, it is moved to each device using the 1.5 SOM and is
thus removed from the imx6q-cubox-i dts.

Enabling the card-detect GPIO on the first generation CuBox-i devices
results in waiting for a card-detect event (that never occurs) and thus
not detecting the mmc card.

Since the CD pin is still dedicated to the purpose on the SOM board even
on the first generation CuBox-i devices, the pin control properties are
kept untouched regardless of the slot capability.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts | 4 ++++
 arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts      | 4 ++++
 arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts  | 4 ++++
 arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts       | 4 ++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi            | 1 -
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
index 2b2fc360b865..90a15f3b4fc0 100644
--- a/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
+++ b/arch/arm/boot/dts/imx6dl-cubox-i-emmc-som-v15.dts
@@ -50,3 +50,7 @@
 	model = "SolidRun Cubox-i Solo/DualLite (1.5som+emmc)";
 	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts b/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
index e09c565d1d1f..9bdec07fefe3 100644
--- a/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
+++ b/arch/arm/boot/dts/imx6dl-cubox-i-som-v15.dts
@@ -49,3 +49,7 @@
 	model = "SolidRun Cubox-i Solo/DualLite (1.5som)";
 	compatible = "solidrun,cubox-i/dl", "fsl,imx6dl";
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts b/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
index 3e59ebbb3608..679a5431cbdb 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i-emmc-som-v15.dts
@@ -58,3 +58,7 @@
 	fsl,transmit-atten-16ths = <9>;
 	fsl,no-spread-spectrum;
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts b/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
index dab70d1230a2..b9b8733f13c3 100644
--- a/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
+++ b/arch/arm/boot/dts/imx6q-cubox-i-som-v15.dts
@@ -57,3 +57,7 @@
 	fsl,transmit-atten-16ths = <9>;
 	fsl,no-spread-spectrum;
 };
+
+&usdhc2 {
+	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
+};
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index d1cfdc264126..170b3d27f875 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -254,7 +254,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2>;
 	vmmc-supply = <&vcc_3v3>;
-	cd-gpios = <&gpio1 4 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
-- 
2.17.0
