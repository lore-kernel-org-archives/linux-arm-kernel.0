From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 10 May 2014 12:18:14 +0400
Subject: [PATCH 2/2] pinctrl: i.MX27: Remove nonexistent pad definitions
In-Reply-To: <1399709894-7652-1-git-send-email-shc_work@mail.ru>
References: <1399709894-7652-1-git-send-email-shc_work@mail.ru>
Message-ID: <1399709894-7652-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pads for PB0-PB3, PC0-PC4, PE26-PE31 and PF24-PF31 does not exist on
the i.MX27 SOC. There is no reason to define them, the presence of
such definitions in the DTS files is a bug.
This patch removes such nonexistent pad definitions.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-pinfunc.h | 46 ---------------------------------------
 drivers/pinctrl/pinctrl-imx27.c   | 46 ---------------------------------------
 2 files changed, 92 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-pinfunc.h b/arch/arm/boot/dts/imx27-pinfunc.h
index f5387b4..597bb5f 100644
--- a/arch/arm/boot/dts/imx27-pinfunc.h
+++ b/arch/arm/boot/dts/imx27-pinfunc.h
@@ -101,14 +101,6 @@
 #define MX27_PAD_CONTRAST__GPIO1_30                        0x1e 0x032
 #define MX27_PAD_OE_ACD__OE_ACD                            0x1f 0x004
 #define MX27_PAD_OE_ACD__GPIO1_31                          0x1f 0x032
-#define MX27_PAD_UNUSED0__UNUSED0                          0x20 0x004
-#define MX27_PAD_UNUSED0__GPIO2_0                          0x20 0x032
-#define MX27_PAD_UNUSED1__UNUSED1                          0x21 0x004
-#define MX27_PAD_UNUSED1__GPIO2_1                          0x21 0x032
-#define MX27_PAD_UNUSED2__UNUSED2                          0x22 0x004
-#define MX27_PAD_UNUSED2__GPIO2_2                          0x22 0x032
-#define MX27_PAD_UNUSED3__UNUSED3                          0x23 0x004
-#define MX27_PAD_UNUSED3__GPIO2_3                          0x23 0x032
 #define MX27_PAD_SD2_D0__SD2_D0                            0x24 0x004
 #define MX27_PAD_SD2_D0__MSHC_DATA0                        0x24 0x005
 #define MX27_PAD_SD2_D0__GPIO2_4                           0x24 0x032
@@ -183,16 +175,6 @@
 #define MX27_PAD_USBH1_RXDP__USBH1_RXDP                    0x3f 0x004
 #define MX27_PAD_USBH1_RXDP__UART4_RXD                     0x3f 0x001
 #define MX27_PAD_USBH1_RXDP__GPIO2_31                      0x3f 0x032
-#define MX27_PAD_UNUSED4__UNUSED4                          0x40 0x004
-#define MX27_PAD_UNUSED4__GPIO3_0                          0x40 0x032
-#define MX27_PAD_UNUSED5__UNUSED5                          0x41 0x004
-#define MX27_PAD_UNUSED5__GPIO3_1                          0x41 0x032
-#define MX27_PAD_UNUSED6__UNUSED6                          0x42 0x004
-#define MX27_PAD_UNUSED6__GPIO3_2                          0x42 0x032
-#define MX27_PAD_UNUSED7__UNUSED7                          0x43 0x004
-#define MX27_PAD_UNUSED7__GPIO3_3                          0x43 0x032
-#define MX27_PAD_UNUSED8__UNUSED8                          0x44 0x004
-#define MX27_PAD_UNUSED8__GPIO3_4                          0x44 0x032
 #define MX27_PAD_I2C2_SDA__I2C2_SDA                        0x45 0x004
 #define MX27_PAD_I2C2_SDA__GPIO3_5                         0x45 0x032
 #define MX27_PAD_I2C2_SCL__I2C2_SCL                        0x46 0x004
@@ -422,18 +404,6 @@
 #define MX27_PAD_USBOTG_CLK__GPIO5_24                      0x98 0x032
 #define MX27_PAD_USBOTG_DATA7__USBOTG_DATA7                0x99 0x004
 #define MX27_PAD_USBOTG_DATA7__GPIO5_25                    0x99 0x032
-#define MX27_PAD_UNUSED9__UNUSED9                          0x9a 0x004
-#define MX27_PAD_UNUSED9__GPIO5_26                         0x9a 0x032
-#define MX27_PAD_UNUSED10__UNUSED10                        0x9b 0x004
-#define MX27_PAD_UNUSED10__GPIO5_27                        0x9b 0x032
-#define MX27_PAD_UNUSED11__UNUSED11                        0x9c 0x004
-#define MX27_PAD_UNUSED11__GPIO5_28                        0x9c 0x032
-#define MX27_PAD_UNUSED12__UNUSED12                        0x9d 0x004
-#define MX27_PAD_UNUSED12__GPIO5_29                        0x9d 0x032
-#define MX27_PAD_UNUSED13__UNUSED13                        0x9e 0x004
-#define MX27_PAD_UNUSED13__GPIO5_30                        0x9e 0x032
-#define MX27_PAD_UNUSED14__UNUSED14                        0x9f 0x004
-#define MX27_PAD_UNUSED14__GPIO5_31                        0x9f 0x032
 #define MX27_PAD_NFRB__NFRB                                0xa0 0x000
 #define MX27_PAD_NFRB__ETMTRACEPKT3                        0xa0 0x005
 #define MX27_PAD_NFRB__GPIO6_0                             0xa0 0x032
@@ -506,21 +476,5 @@
 #define MX27_PAD_ATA_DATA15__ETMTRACEPKT4                  0xb7 0x005
 #define MX27_PAD_ATA_DATA15__FEC_TX_EN                     0xb7 0x006
 #define MX27_PAD_ATA_DATA15__GPIO6_23                      0xb7 0x032
-#define MX27_PAD_UNUSED15__UNUSED15                        0xb8 0x004
-#define MX27_PAD_UNUSED15__GPIO6_24                        0xb8 0x032
-#define MX27_PAD_UNUSED16__UNUSED16                        0xb9 0x004
-#define MX27_PAD_UNUSED16__GPIO6_25                        0xb9 0x032
-#define MX27_PAD_UNUSED17__UNUSED17                        0xba 0x004
-#define MX27_PAD_UNUSED17__GPIO6_26                        0xba 0x032
-#define MX27_PAD_UNUSED18__UNUSED18                        0xbb 0x004
-#define MX27_PAD_UNUSED18__GPIO6_27                        0xbb 0x032
-#define MX27_PAD_UNUSED19__UNUSED19                        0xbc 0x004
-#define MX27_PAD_UNUSED19__GPIO6_28                        0xbc 0x032
-#define MX27_PAD_UNUSED20__UNUSED20                        0xbd 0x004
-#define MX27_PAD_UNUSED20__GPIO6_29                        0xbd 0x032
-#define MX27_PAD_UNUSED21__UNUSED21                        0xbe 0x004
-#define MX27_PAD_UNUSED21__GPIO6_30                        0xbe 0x032
-#define MX27_PAD_UNUSED22__UNUSED22                        0xbf 0x004
-#define MX27_PAD_UNUSED22__GPIO6_31                        0xbf 0x032
 
 #endif /* __DTS_IMX27_PINFUNC_H */
diff --git a/drivers/pinctrl/pinctrl-imx27.c b/drivers/pinctrl/pinctrl-imx27.c
index 27ae7ce..f8dfefb 100644
--- a/drivers/pinctrl/pinctrl-imx27.c
+++ b/drivers/pinctrl/pinctrl-imx27.c
@@ -63,10 +63,6 @@ enum imx27_pads {
 	MX27_PAD_CONTRAST = PAD_ID(PA, 30),
 	MX27_PAD_OE_ACD = PAD_ID(PA, 31),
 
-	MX27_PAD_UNUSED0 = PAD_ID(PB, 0),
-	MX27_PAD_UNUSED1 = PAD_ID(PB, 1),
-	MX27_PAD_UNUSED2 = PAD_ID(PB, 2),
-	MX27_PAD_UNUSED3 = PAD_ID(PB, 3),
 	MX27_PAD_SD2_D0 = PAD_ID(PB, 4),
 	MX27_PAD_SD2_D1 = PAD_ID(PB, 5),
 	MX27_PAD_SD2_D2 = PAD_ID(PB, 6),
@@ -96,11 +92,6 @@ enum imx27_pads {
 	MX27_PAD_USBH1_RXDM = PAD_ID(PB, 30),
 	MX27_PAD_USBH1_RXDP = PAD_ID(PB, 31),
 
-	MX27_PAD_UNUSED4 = PAD_ID(PC, 0),
-	MX27_PAD_UNUSED5 = PAD_ID(PC, 1),
-	MX27_PAD_UNUSED6 = PAD_ID(PC, 2),
-	MX27_PAD_UNUSED7 = PAD_ID(PC, 3),
-	MX27_PAD_UNUSED8 = PAD_ID(PC, 4),
 	MX27_PAD_I2C2_SDA = PAD_ID(PC, 5),
 	MX27_PAD_I2C2_SCL = PAD_ID(PC, 6),
 	MX27_PAD_USBOTG_DATA5 = PAD_ID(PC, 7),
@@ -188,12 +179,6 @@ enum imx27_pads {
 	MX27_PAD_SD1_CLK = PAD_ID(PE, 23),
 	MX27_PAD_USBOTG_CLK = PAD_ID(PE, 24),
 	MX27_PAD_USBOTG_DATA7 = PAD_ID(PE, 25),
-	MX27_PAD_UNUSED9 = PAD_ID(PE, 26),
-	MX27_PAD_UNUSED10 = PAD_ID(PE, 27),
-	MX27_PAD_UNUSED11 = PAD_ID(PE, 28),
-	MX27_PAD_UNUSED12 = PAD_ID(PE, 29),
-	MX27_PAD_UNUSED13 = PAD_ID(PE, 30),
-	MX27_PAD_UNUSED14 = PAD_ID(PE, 31),
 
 	MX27_PAD_NFRB = PAD_ID(PF, 0),
 	MX27_PAD_NFCLE = PAD_ID(PF, 1),
@@ -219,14 +204,6 @@ enum imx27_pads {
 	MX27_PAD_CS4_B = PAD_ID(PF, 21),
 	MX27_PAD_CS5_B = PAD_ID(PF, 22),
 	MX27_PAD_ATA_DATA15 = PAD_ID(PF, 23),
-	MX27_PAD_UNUSED15 = PAD_ID(PF, 24),
-	MX27_PAD_UNUSED16 = PAD_ID(PF, 25),
-	MX27_PAD_UNUSED17 = PAD_ID(PF, 26),
-	MX27_PAD_UNUSED18 = PAD_ID(PF, 27),
-	MX27_PAD_UNUSED19 = PAD_ID(PF, 28),
-	MX27_PAD_UNUSED20 = PAD_ID(PF, 29),
-	MX27_PAD_UNUSED21 = PAD_ID(PF, 30),
-	MX27_PAD_UNUSED22 = PAD_ID(PF, 31),
 };
 
 /* Pad names for the pinmux subsystem */
@@ -264,10 +241,6 @@ static const struct pinctrl_pin_desc imx27_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX27_PAD_CONTRAST),
 	IMX_PINCTRL_PIN(MX27_PAD_OE_ACD),
 
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED0),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED1),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED2),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED3),
 	IMX_PINCTRL_PIN(MX27_PAD_SD2_D0),
 	IMX_PINCTRL_PIN(MX27_PAD_SD2_D1),
 	IMX_PINCTRL_PIN(MX27_PAD_SD2_D2),
@@ -297,11 +270,6 @@ static const struct pinctrl_pin_desc imx27_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX27_PAD_USBH1_RXDM),
 	IMX_PINCTRL_PIN(MX27_PAD_USBH1_RXDP),
 
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED4),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED5),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED6),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED7),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED8),
 	IMX_PINCTRL_PIN(MX27_PAD_I2C2_SDA),
 	IMX_PINCTRL_PIN(MX27_PAD_I2C2_SCL),
 	IMX_PINCTRL_PIN(MX27_PAD_USBOTG_DATA5),
@@ -389,12 +357,6 @@ static const struct pinctrl_pin_desc imx27_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX27_PAD_SD1_CLK),
 	IMX_PINCTRL_PIN(MX27_PAD_USBOTG_CLK),
 	IMX_PINCTRL_PIN(MX27_PAD_USBOTG_DATA7),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED9),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED10),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED11),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED12),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED13),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED14),
 
 	IMX_PINCTRL_PIN(MX27_PAD_NFRB),
 	IMX_PINCTRL_PIN(MX27_PAD_NFCLE),
@@ -420,14 +382,6 @@ static const struct pinctrl_pin_desc imx27_pinctrl_pads[] = {
 	IMX_PINCTRL_PIN(MX27_PAD_CS4_B),
 	IMX_PINCTRL_PIN(MX27_PAD_CS5_B),
 	IMX_PINCTRL_PIN(MX27_PAD_ATA_DATA15),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED15),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED16),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED17),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED18),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED19),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED20),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED21),
-	IMX_PINCTRL_PIN(MX27_PAD_UNUSED22),
 };
 
 static struct imx1_pinctrl_soc_info imx27_pinctrl_info = {
-- 
1.8.3.2
