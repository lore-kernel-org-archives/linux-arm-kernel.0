From: peda@axentia.se (Peter Rosin)
Date: Wed, 21 Mar 2018 16:35:52 +0100
Subject: [PATCH 3/3] ARM: dts: at91sam9260: pullup rx on usart0
In-Reply-To: <20180321153552.29213-1-peda@axentia.se>
References: <20180321153552.29213-1-peda@axentia.se>
Message-ID: <20180321153552.29213-4-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with all other serial pins, add this pullup. It also
prevents the signal from floating and so consuming a useless extra amount
of power in crowbarred state if nothing is connected to RX.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91sam9260.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 3ae7e6c55fe4..9118e29b6d6a 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -434,8 +434,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB4 periph A */
-							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB5 periph A */
+							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
-- 
2.11.0
