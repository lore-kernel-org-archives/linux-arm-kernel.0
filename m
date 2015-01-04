From: josh.wu@atmel.com (Josh Wu)
Date: Sun, 4 Jan 2015 17:02:31 +0800
Subject: [PATCH v2 6/8] ARM: at91: dts: sama5d3: change name of pinctrl of
 ISI_MCK
In-Reply-To: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
References: <1420362153-500-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1420362153-500-7-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For sama5d3xmb board, the pins: pinctrl_isi_pck_as_mck is pck1, and
used to provide MCK for camera sensor.

We change its name to: pinctrl_pck1_as_isi_mck.

As we want camera sensor instead of ISI to configure the pck1 (ISI_MCK) pin.
So we remove this pinctrl from ISI DT node. It will be added in sensor's
DT node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---
new added in v2.

 arch/arm/boot/dts/sama5d3xmb.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index db47f8b..d9464fc 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -61,7 +61,7 @@
 
 			isi: isi at f0034000 {
 				pinctrl-names = "default";
-				pinctrl-0 = <&pinctrl_isi_data_0_7 &pinctrl_isi_pck_as_mck>;
+				pinctrl-0 = <&pinctrl_isi_data_0_7>;
 			};
 
 			mmc1: mmc at f8000000 {
@@ -117,7 +117,7 @@
 							<AT91_PIOD 30 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD30 periph B */
 					};
 
-					pinctrl_isi_pck_as_mck: isi_pck_as_mck-0 {
+					pinctrl_pck1_as_isi_mck: pck1_as_isi_mck-0 {
 						atmel,pins =
 							<AT91_PIOD 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PD31 periph B ISI_MCK */
 					};
-- 
1.9.1
