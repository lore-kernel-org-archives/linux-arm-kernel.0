From: peda@axentia.se (Peter Rosin)
Date: Wed, 21 Mar 2018 16:35:51 +0100
Subject: [PATCH 2/3] ARM: dts: at91rm9200: pullup rx on uart0
In-Reply-To: <20180321153552.29213-1-peda@axentia.se>
References: <20180321153552.29213-1-peda@axentia.se>
Message-ID: <20180321153552.29213-3-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with all other serial pins, add this pullup. It also
prevents the signal from floating and so consuming a useless extra amount
of power in crowbarred state if nothing is connected to RX.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 3f3149c156a8..2ad69a7fbc00 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -493,8 +493,8 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOA 17 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA17 periph A */
-							 AT91_PIOA 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA18 periph A */
+							<AT91_PIOA 17 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_uart0_cts: uart0_cts-0 {
-- 
2.11.0
