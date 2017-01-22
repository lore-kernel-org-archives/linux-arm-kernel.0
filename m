From: mhei@heimpold.de (Michael Heimpold)
Date: Sun, 22 Jan 2017 23:22:37 +0100
Subject: [PATCH v2 2/9] ARM: dts: imx28: rename mmc2_sck_cfg to prepare for an
 alternative muxing setup
In-Reply-To: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
References: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
Message-ID: <1485123764-14754-3-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Heimpold <michael.heimpold@i2se.com>

Signed-off-by: Michael Heimpold <michael.heimpold@i2se.com>
---
 arch/arm/boot/dts/imx28-m28cu3.dts | 2 +-
 arch/arm/boot/dts/imx28.dtsi       | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index 2df63be..bb53294 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -57,7 +57,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&mmc2_4bit_pins_a
 					     &mmc2_cd_cfg
-					     &mmc2_sck_cfg>;
+					     &mmc2_sck_cfg_a>;
 				bus-width = <4>;
 				vmmc-supply = <&reg_vddio_sd1>;
 				status = "okay";
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index bc5cf41..857ca37 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -604,7 +604,8 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
-				mmc2_sck_cfg: mmc2-sck-cfg {
+				mmc2_sck_cfg_a: mmc2-sck-cfg at 0 {
+					reg = <0>;
 					fsl,pinmux-ids = <
 						MX28_PAD_SSP0_DATA7__SSP2_SCK
 					>;
-- 
2.7.4
