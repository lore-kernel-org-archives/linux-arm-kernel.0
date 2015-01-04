From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 4 Jan 2015 17:02:30 +0800
Subject: [PATCH v2 5/8] ARM: at91: dts: sama5d3: change name of
 pinctrl_isi_{power, reset}
In-Reply-To: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1420362153-500-6-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For sama5d3xmb board, the pins: pinctrl_isi_{power,reset} is used to
power-down or reset camera sensor.
So we should let camera sensor instead of ISI to configure the pins.

This patch will change pinctrl name from pinctrl_isi_{power,reset} to
pinctrl_sensor_{power,reset}. And remove these two pinctrl from ISI's
DT node. We will add these two pinctrl to sensor's DT node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
v1 -> v2:
  1. only do things that mentioned in commit message.

 arch/arm/boot/dts/sama5d3xmb.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index 6af1cba..db47f8b 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -61,7 +61,7 @@
 
 			isi: isi at f0034000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_isi_data_0_7 &pinctrl_isi_pck_as_mck &pinctrl_isi_power &pinctrl_isi_reset>;
+				pinctrl-0 = <&pinctrl_isi_data_0_7 &pinctrl_isi_pck_as_mck>;
 			};
 
 			mmc1: mmc at f8000000 {
@@ -122,12 +122,12 @@
 							<AT91_PIOD 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD31 periph B ISI_MCK */
 					};
 
-					pinctrl_isi_reset: isi_reset-0 {
+					pinctrl_sensor_reset: sensor_reset-0 {
 						atmel,pins =
 							<AT91_PIOE 24 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;   /* PE24 gpio */
 					};
 
-					pinctrl_isi_power: isi_power-0 {
+					pinctrl_sensor_power: sensor_power-0 {
 						atmel,pins =
 							<AT91_PIOE 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>; /* PE29 gpio */
 					};
-- 
1.9.1
