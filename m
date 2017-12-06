From: stefan@agner.ch (Stefan Agner)
Date: Wed,  6 Dec 2017 16:30:02 +0100
Subject: [PATCH 6/9] ARM: dts: imx7-colibri: specify usdhc1 supplies
In-Reply-To: <20171206153005.6144-1-stefan@agner.ch>
References: <20171206153005.6144-1-stefan@agner.ch>
Message-ID: <20171206153005.6144-6-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The usdhc1 controller instance is used to provide the default
SD/MMC capabilities of the Colibri standard. The IO pins are
supplied to the SoC on the module whereas the SD-card is powered
by the Carrier Board supply.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 1 +
 arch/arm/boot/dts/imx7-colibri.dtsi         | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
index 5ecb3a858c5a..87c23b769a08 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -158,5 +158,6 @@
 &usdhc1 {
 	keep-power-in-suspend;
 	wakeup-source;
+	vmmc-supply = <&reg_3v3>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 6498c1136ef1..d623ef0f6e3e 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -299,6 +299,7 @@
 	no-1-8-v;
 	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
 	disable-wp;
+	vqmmc-supply = <&reg_LDO2>;
 };
 
 &iomuxc {
-- 
2.15.1
