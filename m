From: stefan@agner.ch (Stefan Agner)
Date: Tue,  8 Nov 2016 18:44:56 -0800
Subject: [PATCH] ARM: dts: imx7d-pinfunc: fix UART pinmux defines
Message-ID: <20161109024456.1832-1-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UART pinmux defines for the pins which are part of the LPSR
pinmux controller are wrong: Output signals configure the input
sel value and the pinmux defines allow not to distinguish between
DCE/DTE mode. Follow the usual pattern using DTE/DCE as part of
the define to denote the two UART configuration options.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
There is a similar patch downstream named:
"MLK-10662: arm: imx7d-pinfunc: fix uart input sel option value"

Tested using UART5 on a Colibri iMX7.

--
Stefan

 arch/arm/boot/dts/imx7d-pinfunc.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/imx7d-pinfunc.h
index 3f9f0d9..7bc3c00 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -43,26 +43,30 @@
 #define MX7D_PAD_GPIO1_IO04__GPIO1_IO4                            0x0010 0x0040 0x0000 0x0 0x0
 #define MX7D_PAD_GPIO1_IO04__USB_OTG1_OC                          0x0010 0x0040 0x072C 0x1 0x1
 #define MX7D_PAD_GPIO1_IO04__FLEXTIMER1_CH4                       0x0010 0x0040 0x0594 0x2 0x1
-#define MX7D_PAD_GPIO1_IO04__UART5_CTS_B                          0x0010 0x0040 0x0710 0x3 0x4
+#define MX7D_PAD_GPIO1_IO04__UART5_DCE_CTS                        0x0010 0x0040 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO04__UART5_DTE_RTS                        0x0010 0x0040 0x0710 0x3 0x4
 #define MX7D_PAD_GPIO1_IO04__I2C1_SCL                             0x0010 0x0040 0x05D4 0x4 0x2
 #define MX7D_PAD_GPIO1_IO04__OBSERVE3_OUT                         0x0010 0x0040 0x0000 0x6 0x0
 #define MX7D_PAD_GPIO1_IO05__GPIO1_IO5                            0x0014 0x0044 0x0000 0x0 0x0
 #define MX7D_PAD_GPIO1_IO05__USB_OTG1_PWR                         0x0014 0x0044 0x0000 0x1 0x0
 #define MX7D_PAD_GPIO1_IO05__FLEXTIMER1_CH5                       0x0014 0x0044 0x0598 0x2 0x1
-#define MX7D_PAD_GPIO1_IO05__UART5_RTS_B                          0x0014 0x0044 0x0710 0x3 0x5
+#define MX7D_PAD_GPIO1_IO05__UART5_DCE_RTS                        0x0014 0x0044 0x0710 0x3 0x5
+#define MX7D_PAD_GPIO1_IO05__UART5_DTE_CTS                        0x0014 0x0044 0x0000 0x3 0x0
 #define MX7D_PAD_GPIO1_IO05__I2C1_SDA                             0x0014 0x0044 0x05D8 0x4 0x2
 #define MX7D_PAD_GPIO1_IO05__OBSERVE4_OUT                         0x0014 0x0044 0x0000 0x6 0x0
 #define MX7D_PAD_GPIO1_IO06__GPIO1_IO6                            0x0018 0x0048 0x0000 0x0 0x0
 #define MX7D_PAD_GPIO1_IO06__USB_OTG2_OC                          0x0018 0x0048 0x0728 0x1 0x1
 #define MX7D_PAD_GPIO1_IO06__FLEXTIMER1_CH6                       0x0018 0x0048 0x059C 0x2 0x1
-#define MX7D_PAD_GPIO1_IO06__UART5_RX_DATA                        0x0018 0x0048 0x0714 0x3 0x4
+#define MX7D_PAD_GPIO1_IO06__UART5_DCE_RX                         0x0018 0x0048 0x0714 0x3 0x4
+#define MX7D_PAD_GPIO1_IO06__UART5_DTE_TX                         0x0018 0x0048 0x0000 0x3 0x0
 #define MX7D_PAD_GPIO1_IO06__I2C2_SCL                             0x0018 0x0048 0x05DC 0x4 0x2
 #define MX7D_PAD_GPIO1_IO06__CCM_WAIT                             0x0018 0x0048 0x0000 0x5 0x0
 #define MX7D_PAD_GPIO1_IO06__KPP_ROW4                             0x0018 0x0048 0x0624 0x6 0x1
 #define MX7D_PAD_GPIO1_IO07__GPIO1_IO7                            0x001C 0x004C 0x0000 0x0 0x0
 #define MX7D_PAD_GPIO1_IO07__USB_OTG2_PWR                         0x001C 0x004C 0x0000 0x1 0x0
 #define MX7D_PAD_GPIO1_IO07__FLEXTIMER1_CH7                       0x001C 0x004C 0x05A0 0x2 0x1
-#define MX7D_PAD_GPIO1_IO07__UART5_TX_DATA                        0x001C 0x004C 0x0714 0x3 0x5
+#define MX7D_PAD_GPIO1_IO07__UART5_DCE_TX                         0x001C 0x004C 0x0000 0x3 0x0
+#define MX7D_PAD_GPIO1_IO07__UART5_DTE_RX                         0x001C 0x004C 0x0714 0x3 0x5
 #define MX7D_PAD_GPIO1_IO07__I2C2_SDA                             0x001C 0x004C 0x05E0 0x4 0x2
 #define MX7D_PAD_GPIO1_IO07__CCM_STOP                             0x001C 0x004C 0x0000 0x5 0x0
 #define MX7D_PAD_GPIO1_IO07__KPP_COL4                             0x001C 0x004C 0x0604 0x6 0x1
-- 
2.10.2
