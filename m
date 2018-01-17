From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Thu, 18 Jan 2018 00:23:47 +0100
Subject: [PATCH RESEND] ARM: dts: imx6ul: add missing OSC32K_32K_OUT mux mode
Message-ID: <20180117232347.24513-1-joerg.krause@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RESEND because of missing Ccs. Original patch is [0].

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

[0] https://patchwork.ozlabs.org/patch/816108/
[1] IMX6ULRM, Rev. 1, 04/2016, Table 58-1

Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
---
 arch/arm/boot/dts/imx6ul-pinfunc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-pinfunc.h b/arch/arm/boot/dts/imx6ul-pinfunc.h
index 0034eeb84542..e12654018c23 100644
--- a/arch/arm/boot/dts/imx6ul-pinfunc.h
+++ b/arch/arm/boot/dts/imx6ul-pinfunc.h
@@ -63,6 +63,7 @@
 #define MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA		0x0054 0x02e0 0x05f4 2 0
 #define MX6UL_PAD_JTAG_TCK__PWM7_OUT			0x0054 0x02e0 0x0000 4 0
 #define MX6UL_PAD_JTAG_TCK__GPIO1_IO14			0x0054 0x02e0 0x0000 5 0
+#define MX6UL_PAD_JTAG_TCK__OSC32K_32K_OUT		0x0054 0x02e0 0x0000 6 0
 #define MX6UL_PAD_JTAG_TCK__SIM2_POWER_FAIL		0x0054 0x02e0 0x0000 8 0
 #define MX6UL_PAD_JTAG_TRST_B__SJC_TRSTB		0x0058 0x02e4 0x0000 0 0
 #define MX6UL_PAD_JTAG_TRST_B__GPT2_COMPARE3		0x0058 0x02e4 0x0000 1 0
@@ -101,6 +102,7 @@
 #define MX6UL_PAD_GPIO1_IO03__I2C1_SDA			0x0068 0x02f4 0x05a8 0 1
 #define MX6UL_PAD_GPIO1_IO03__GPT1_COMPARE3		0x0068 0x02f4 0x0000 1 0
 #define MX6UL_PAD_GPIO1_IO03__USB_OTG2_OC		0x0068 0x02f4 0x0660 2 0
+#define MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT		0x0068 0x02f4 0x0000 3 0
 #define MX6UL_PAD_GPIO1_IO03__USDHC1_CD_B		0x0068 0x02f4 0x0668 4 0
 #define MX6UL_PAD_GPIO1_IO03__GPIO1_IO03		0x0068 0x02f4 0x0000 5 0
 #define MX6UL_PAD_GPIO1_IO03__CCM_DI0_eXT_CLK		0x0068 0x02f4 0x0000 6 0
@@ -316,6 +318,7 @@
 #define MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN		0x00cc 0x0358 0x0000 0 0
 #define MX6UL_PAD_ENET1_RX_EN__UART5_DCE_RTS		0x00cc 0x0358 0x0640 1 3
 #define MX6UL_PAD_ENET1_RX_EN__UART5_DTE_CTS		0x00cc 0x0358 0x0000 1 0
+#define MX6UL_PAD_ENET1_RX_EN__OSC32K_32K_OUT		0x00cc 0x0358 0x0000 2 0
 #define MX6UL_PAD_ENET1_RX_EN__CSI_DATA18		0x00cc 0x0358 0x0000 3 0
 #define MX6UL_PAD_ENET1_RX_EN__FLEXCAN2_TX		0x00cc 0x0358 0x0000 4 0
 #define MX6UL_PAD_ENET1_RX_EN__GPIO2_IO02		0x00cc 0x0358 0x0000 5 0
-- 
2.15.1
