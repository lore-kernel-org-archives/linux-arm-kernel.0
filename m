From: b32955@freescale.com (Huang Shijie)
Date: Mon, 26 May 2014 13:20:33 +0800
Subject: [PATCH 2/2] ARM: clk-imx6sx: register the qspi's clock with re-parent
 capability
In-Reply-To: <1401081633-12190-1-git-send-email-b32955@freescale.com>
References: <1401081633-12190-1-git-send-email-b32955@freescale.com>
Message-ID: <1401081633-12190-2-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clocks for Quadspi controller may be different when different NOR
flashes are connected to the board.

So the IMX6SX_CLK_QSPI1_SEL/IMX6SX_CLK_QSPI2_SEL should have the re-parent
capability.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 arch/arm/mach-imx/clk-imx6sx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6sx.c b/arch/arm/mach-imx/clk-imx6sx.c
index 72f8902..2e6e24b 100644
--- a/arch/arm/mach-imx/clk-imx6sx.c
+++ b/arch/arm/mach-imx/clk-imx6sx.c
@@ -241,13 +241,13 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clks[IMX6SX_CLK_SSI3_SEL]           = imx_clk_mux("ssi3_sel",         base + 0x1c,  14,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
 	clks[IMX6SX_CLK_SSI2_SEL]           = imx_clk_mux("ssi2_sel",         base + 0x1c,  12,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
 	clks[IMX6SX_CLK_SSI1_SEL]           = imx_clk_mux("ssi1_sel",         base + 0x1c,  10,     2,      ssi_sels,          ARRAY_SIZE(ssi_sels));
-	clks[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_mux_flags("qspi1_sel", base + 0x1c,  7, 3, qspi1_sels, ARRAY_SIZE(qspi1_sels), CLK_SET_RATE_PARENT);
+	clks[IMX6SX_CLK_QSPI1_SEL]          = imx_clk_mux_flags_reparent("qspi1_sel", base + 0x1c,  7, 3, qspi1_sels, ARRAY_SIZE(qspi1_sels), CLK_SET_RATE_PARENT);
 	clks[IMX6SX_CLK_PERCLK_SEL]         = imx_clk_mux("perclk_sel",       base + 0x1c,  6,      1,      perclk_sels,       ARRAY_SIZE(perclk_sels));
 	clks[IMX6SX_CLK_VID_SEL]            = imx_clk_mux("vid_sel",          base + 0x20,  21,     3,      vid_sels,          ARRAY_SIZE(vid_sels));
 	clks[IMX6SX_CLK_ESAI_SEL]           = imx_clk_mux("esai_sel",         base + 0x20,  19,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	clks[IMX6SX_CLK_CAN_SEL]            = imx_clk_mux("can_sel",          base + 0x20,  8,      2,      can_sels,          ARRAY_SIZE(can_sels));
 	clks[IMX6SX_CLK_UART_SEL]           = imx_clk_mux("uart_sel",         base + 0x24,  6,      1,      uart_sels,         ARRAY_SIZE(uart_sels));
-	clks[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_mux_flags("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT);
+	clks[IMX6SX_CLK_QSPI2_SEL]          = imx_clk_mux_flags_reparent("qspi2_sel", base + 0x2c, 15, 3, qspi2_sels, ARRAY_SIZE(qspi2_sels), CLK_SET_RATE_PARENT);
 	clks[IMX6SX_CLK_SPDIF_SEL]          = imx_clk_mux("spdif_sel",        base + 0x30,  20,     2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	clks[IMX6SX_CLK_AUDIO_SEL]          = imx_clk_mux("audio_sel",        base + 0x30,  7,      2,      audio_sels,        ARRAY_SIZE(audio_sels));
 	clks[IMX6SX_CLK_ENET_PRE_SEL]       = imx_clk_mux("enet_pre_sel",     base + 0x34,  15,     3,      enet_pre_sels,     ARRAY_SIZE(enet_pre_sels));
-- 
1.7.8
