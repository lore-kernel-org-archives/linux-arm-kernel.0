From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Mon,  5 Feb 2018 21:47:59 +0100
Subject: [PATCH] ARM: dts: imx6ul: rename mux mode name REF_CLK_32K to
 OSC32K_32K_OUT
Message-ID: <20180205204759.28526-1-joerg.krause@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a rebased version of patch [0].

The 32 kHz reference clock on the i.MX6UL(L) can be output by
setting the external signal XTALOSC_REF_CLK_32K in one of the
following ways [1]:

|----------------------------------------------------------|
| Signal              | Pad             | Mode | Direction |
|----------------------------------------------------------|
| XTALOSC_REF_CLK_32K | ENET1_RX_EN     | ALT2 | O         |
|                     | GPIO1_IO03      | ALT3 |           |
|                     | JTAG_TCK        | ALT6 |           |
|----------------------------------------------------------|

Before patch [2] the mux mode for the external reference clock was
missing. The patch named the mux mode as used in the NXP Linux
4.9.11_1.0.0 release, but the Reference Manual uses the name
OSC32K_32K_OUT, e.g. in [3].

As Philipp and Shawn suggest the name from the RM should be used
instead.

[0] https://patchwork.kernel.org/patch/10172187/
[1] IMX6ULRM, Rev. 1, 04/2016, Table 58-1, p. 3649
[2] https://patchwork.kernel.org/patch/10156121/
[3] IMX6ULRM, Rev. 1, 04/2016, 30.5.47 SW_MUX_CTL_PAD_ENET1_RX_EN SW MUX
    Control Register (IOMUXC_SW_MUX_CTL_PAD_ENET1_RX_EN), p. 1357

Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
---
 arch/arm/boot/dts/imx6ul-pinfunc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-pinfunc.h b/arch/arm/boot/dts/imx6ul-pinfunc.h
index 9538b0ed5c11..7b9a4dc38456 100644
--- a/arch/arm/boot/dts/imx6ul-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ul-pinfunc.h
@@ -63,7 +63,7 @@
 #define MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA		0x0054 0x02e0 0x05f4 2 0
 #define MX6UL_PAD_JTAG_TCK__PWM7_OUT			0x0054 0x02e0 0x0000 4 0
 #define MX6UL_PAD_JTAG_TCK__GPIO1_IO14			0x0054 0x02e0 0x0000 5 0
-#define MX6UL_PAD_JTAG_TCK__REF_CLK_32K			0x0054 0x02e0 0x0000 6 0
+#define MX6UL_PAD_JTAG_TCK__OSC32K_32K_OUT			0x0054 0x02e0 0x0000 6 0
 #define MX6UL_PAD_JTAG_TCK__SIM2_POWER_FAIL		0x0054 0x02e0 0x0000 8 0
 #define MX6UL_PAD_JTAG_TRST_B__SJC_TRSTB		0x0058 0x02e4 0x0000 0 0
 #define MX6UL_PAD_JTAG_TRST_B__GPT2_COMPARE3		0x0058 0x02e4 0x0000 1 0
@@ -103,7 +103,7 @@
 #define MX6UL_PAD_GPIO1_IO03__I2C1_SDA			0x0068 0x02f4 0x05a8 0 1
 #define MX6UL_PAD_GPIO1_IO03__GPT1_COMPARE3		0x0068 0x02f4 0x0000 1 0
 #define MX6UL_PAD_GPIO1_IO03__USB_OTG2_OC		0x0068 0x02f4 0x0660 2 0
-#define MX6UL_PAD_GPIO1_IO03__REF_CLK_32K		0x0068 0x02f4 0x0000 3 0
+#define MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT		0x0068 0x02f4 0x0000 3 0
 #define MX6UL_PAD_GPIO1_IO03__USDHC1_CD_B		0x0068 0x02f4 0x0668 4 0
 #define MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0x0068 0x02f4 0x0000 5 0
 #define MX6UL_PAD_GPIO1_IO03__CCM_DI0_EXT_CLK		0x0068 0x02f4 0x0000 6 0
@@ -320,7 +320,7 @@
 #define MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN		0x00cc 0x0358 0x0000 0 0
 #define MX6UL_PAD_ENET1_RX_EN__UART5_DCE_RTS		0x00cc 0x0358 0x0640 1 3
 #define MX6UL_PAD_ENET1_RX_EN__UART5_DTE_CTS		0x00cc 0x0358 0x0000 1 0
-#define MX6UL_PAD_ENET1_RX_EN__REF_CLK_32K		0x00cc 0x0358 0x0000 2 0
+#define MX6UL_PAD_ENET1_RX_EN__OSC32K_32K_OUT		0x00cc 0x0358 0x0000 2 0
 #define MX6UL_PAD_ENET1_RX_EN__CSI_DATA18		0x00cc 0x0358 0x050c 3 0
 #define MX6UL_PAD_ENET1_RX_EN__FLEXCAN2_TX		0x00cc 0x0358 0x0000 4 0
 #define MX6UL_PAD_ENET1_RX_EN__GPIO2_IO02		0x00cc 0x0358 0x0000 5 0
-- 
2.16.1
