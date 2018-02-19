From: svenbrauch@googlemail.com (Sven Brauch)
Date: Mon, 19 Feb 2018 16:11:10 +0100
Subject: [PATCH] fix imx7d UART1_RX_DATA__ENET1_MDIO daisy chain register
 setting
Message-ID: <CAE_ay6n-LV_RZGGQ=iYL8Y5AmBA7d6=XaLkfjTzNukt+dPTkPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to the pin multiplexing, some pads need to be multiplexed
internally to the right input. This setting was not performed for one
of the pins, resulting in ethernet not working when using that pin
multiplexing setting.

See i.MX7D Reference Manual table 8.2.7.344 for why this is the correct
setting.

Signed-off-by: Sven Brauch <svb@discovergy.com>

Postscriptum: I'm actually quite surprised by how this issue can happen.
Is this file not automatically generated? I really wouldn't have expected
anything to be wrong here and it took me quite some time to spot this ...

I'm not subscribed to the list, please CC me in replies.

---
 arch/arm/boot/dts/imx7d-pinfunc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h
b/arch/arm/boot/dts/imx7d-pinfunc.h
index f2493bc63da4..1204c28bc811 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -580,7 +580,7 @@
 #define MX7D_PAD_UART1_RX_DATA__ECSPI1_SS1
0x0128 0x0398 0x0000 0x3 0x0
 #define MX7D_PAD_UART1_RX_DATA__ENET2_1588_EVENT0_IN
0x0128 0x0398 0x0000 0x4 0x0
 #define MX7D_PAD_UART1_RX_DATA__GPIO4_IO0
0x0128 0x0398 0x0000 0x5 0x0
-#define MX7D_PAD_UART1_RX_DATA__ENET1_MDIO
0x0128 0x0398 0x0000 0x6 0x0
+#define MX7D_PAD_UART1_RX_DATA__ENET1_MDIO
0x0128 0x0398 0x0568 0x6 0x1
 #define MX7D_PAD_UART1_TX_DATA__UART1_DCE_TX
0x012C 0x039C 0x0000 0x0 0x0
 #define MX7D_PAD_UART1_TX_DATA__UART1_DTE_RX
0x012C 0x039C 0x06F4 0x0 0x1
 #define MX7D_PAD_UART1_TX_DATA__I2C1_SDA
0x012C 0x039C 0x05D8 0x1 0x0
-- 
2.16.2
