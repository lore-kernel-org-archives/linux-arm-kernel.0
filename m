From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  2 Dec 2016 14:11:44 +0000
Subject: [PATCH 1/3] ARM: dts: STiH410-b2260: Identify the UART RTS line
Message-ID: <20161202141146.31281-1-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Configure the UART RTS line as a GPIO for manipulation within the UART driver.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih410-b2260.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 7fb507f..f46603f 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -63,6 +63,7 @@
 		uart0: serial at 9830000 {
 			label = "LS-UART0";
 			status = "okay";
+			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
 		};
 
 		/* Low speed expansion connector */
-- 
2.10.2
