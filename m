From: davidb@codeaurora.org (David Brown)
Date: Wed,  2 Nov 2011 11:36:30 -0700
Subject: [RFC PATCH 33/34] ARM: msm: fix names of UART clocks
In-Reply-To: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
References: <1320258991-22325-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1320258991-22325-34-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Earlier code for MSM uarts had three separate drivers, one for the old
"legacy" hardware, one for the new DMA-based hardware, and a third
that used the DMA-based hardware in a legacy-compatible mode.

The current msm_serial driver handles both the older hardware and the
DMA-based hardware in non-DMA mode from the same driver.  Rename the
clocks for this device to support this usage.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/clock-8x60.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/clock-8x60.c b/arch/arm/mach-msm/clock-8x60.c
index 21c2472..f398bd7 100644
--- a/arch/arm/mach-msm/clock-8x60.c
+++ b/arch/arm/mach-msm/clock-8x60.c
@@ -3378,7 +3378,7 @@ static struct clk_lookup msm_clocks_8x60[] = {
 	CLK_LOOKUP("gsbi_uart_clk",	gsbi9_uart_clk.c, "msm_serial_hsl.1"),
 	CLK_LOOKUP("gsbi_uart_clk",	gsbi10_uart_clk.c,	NULL),
 	CLK_LOOKUP("gsbi_uart_clk",	gsbi11_uart_clk.c,	NULL),
-	CLK_LOOKUP("gsbi_uart_clk",	gsbi12_uart_clk.c, "msm_serial_hsl.0"),
+	CLK_LOOKUP("gsbi_uart_clk",	gsbi12_uart_clk.c, "msm_serial.0"),
 	CLK_LOOKUP("spi_clk",		gsbi1_qup_clk.c, "spi_qsd.0"),
 	CLK_LOOKUP("gsbi_qup_clk",	gsbi2_qup_clk.c,		NULL),
 	CLK_LOOKUP("gsbi_qup_clk",	gsbi3_qup_clk.c, "qup_i2c.0"),
@@ -3425,7 +3425,7 @@ static struct clk_lookup msm_clocks_8x60[] = {
 	CLK_LOOKUP("spi_pclk",		gsbi10_p_clk.c, "spi_qsd.1"),
 	CLK_LOOKUP("gsbi_pclk",		gsbi11_p_clk.c,		NULL),
 	CLK_LOOKUP("gsbi_pclk",		gsbi12_p_clk.c, "msm_dsps.0"),
-	CLK_LOOKUP("gsbi_pclk",		gsbi12_p_clk.c, "msm_serial_hsl.0"),
+	CLK_LOOKUP("gsbi_pclk",		gsbi12_p_clk.c, "msm_serial.0"),
 	CLK_LOOKUP("gsbi_pclk",		gsbi12_p_clk.c, "qup_i2c.5"),
 	CLK_LOOKUP("ppss_pclk",		ppss_p_clk.c,		NULL),
 	CLK_LOOKUP("tsif_pclk",		tsif_p_clk.c,		NULL),
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
