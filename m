From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 24 Aug 2015 10:19:59 +0300
Subject: [PATCH 03/11] ARM: DTS: dra7-evm: Rename mmc2_3v3 supply to evm_3v3_sw
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1440400807-32274-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the name for the supply as it is in the schematics since the same
supply is used for other peripherals than MMC2, like audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index a6c82e5b64fe..de02cf5853a9 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -28,9 +28,9 @@
 		gpio = <&pcf_gpio_21 5 GPIO_ACTIVE_HIGH>;
 	};
 
-	mmc2_3v3: fixedregulator-mmc2 {
+	evm_3v3_sw: fixedregulator-evm_3v3_sw {
 		compatible = "regulator-fixed";
-		regulator-name = "mmc2_3v3";
+		regulator-name = "evm_3v3_sw";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
@@ -484,7 +484,7 @@
 
 &mmc2 {
 	status = "okay";
-	vmmc-supply = <&mmc2_3v3>;
+	vmmc-supply = <&evm_3v3_sw>;
 	bus-width = <8>;
 };
 
-- 
2.5.0
