From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Mon, 25 Jun 2012 13:25:08 +0530
Subject: [PATCH] ARM: tegra: Remove second instance of uart clk
Message-ID: <1340610908-2729-1-git-send-email-pgaikwad@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In Tegra30 clock file two clk objects were created for same UART clock.
Remove the duplicates and add clock aliases instead.

Update the Tegra20 clock file to make the names consistent.

Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
---
 arch/arm/mach-tegra/tegra2_clocks.c  |   20 ++++++++++----------
 arch/arm/mach-tegra/tegra30_clocks.c |   20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra2_clocks.c b/arch/arm/mach-tegra/tegra2_clocks.c
index b59315c..034d952 100644
--- a/arch/arm/mach-tegra/tegra2_clocks.c
+++ b/arch/arm/mach-tegra/tegra2_clocks.c
@@ -2189,11 +2189,11 @@ static struct clk tegra_list_clks[] = {
 	PERIPH_CLK("i2c2_i2c",	"tegra-i2c.1",		"i2c",	0,	0,	72000000,  mux_pllp_out3,			0),
 	PERIPH_CLK("i2c3_i2c",	"tegra-i2c.2",		"i2c",	0,	0,	72000000,  mux_pllp_out3,			0),
 	PERIPH_CLK("dvc_i2c",	"tegra-i2c.3",		"i2c",	0,	0,	72000000,  mux_pllp_out3,			0),
-	PERIPH_CLK("uarta",	"uart.0",		NULL,	6,	0x178,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
-	PERIPH_CLK("uartb",	"uart.1",		NULL,	7,	0x17c,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
-	PERIPH_CLK("uartc",	"uart.2",		NULL,	55,	0x1a0,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
-	PERIPH_CLK("uartd",	"uart.3",		NULL,	65,	0x1c0,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
-	PERIPH_CLK("uarte",	"uart.4",		NULL,	66,	0x1c4,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
+	PERIPH_CLK("uarta",	"tegra-uart.0",		NULL,	6,	0x178,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
+	PERIPH_CLK("uartb",	"tegra-uart.1",		NULL,	7,	0x17c,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
+	PERIPH_CLK("uartc",	"tegra-uart.2",		NULL,	55,	0x1a0,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
+	PERIPH_CLK("uartd",	"tegra-uart.3",		NULL,	65,	0x1c0,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
+	PERIPH_CLK("uarte",	"tegra-uart.4",		NULL,	66,	0x1c4,	600000000, mux_pllp_pllc_pllm_clkm,	MUX),
 	PERIPH_CLK("3d",	"3d",			NULL,	24,	0x158,	300000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71 | PERIPH_MANUAL_RESET), /* scales with voltage and process_id */
 	PERIPH_CLK("2d",	"2d",			NULL,	21,	0x15c,	300000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71), /* scales with voltage and process_id */
 	PERIPH_CLK("vi",	"tegra_camera",		"vi",	20,	0x148,	150000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71), /* scales with voltage and process_id */
@@ -2245,11 +2245,11 @@ static struct clk tegra_list_clks[] = {
  * table under two names.
  */
 static struct clk_duplicate tegra_clk_duplicates[] = {
-	CLK_DUPLICATE("uarta",	"tegra_uart.0",	NULL),
-	CLK_DUPLICATE("uartb",	"tegra_uart.1",	NULL),
-	CLK_DUPLICATE("uartc",	"tegra_uart.2",	NULL),
-	CLK_DUPLICATE("uartd",	"tegra_uart.3",	NULL),
-	CLK_DUPLICATE("uarte",	"tegra_uart.4",	NULL),
+	CLK_DUPLICATE("uarta",  "serial8250.0", NULL),
+	CLK_DUPLICATE("uartb",  "serial8250.1", NULL),
+	CLK_DUPLICATE("uartc",  "serial8250.2", NULL),
+	CLK_DUPLICATE("uartd",  "serial8250.3", NULL),
+	CLK_DUPLICATE("uarte",  "serial8250.4", NULL),
 	CLK_DUPLICATE("usbd", "utmip-pad", NULL),
 	CLK_DUPLICATE("usbd", "tegra-ehci.0", NULL),
 	CLK_DUPLICATE("usbd", "tegra-otg", NULL),
diff --git a/arch/arm/mach-tegra/tegra30_clocks.c b/arch/arm/mach-tegra/tegra30_clocks.c
index e33fe4b..e1a7489 100644
--- a/arch/arm/mach-tegra/tegra30_clocks.c
+++ b/arch/arm/mach-tegra/tegra30_clocks.c
@@ -2924,16 +2924,11 @@ struct clk tegra_list_clks[] = {
 	PERIPH_CLK("i2c3",	"tegra-i2c.2",		NULL,	67,	0x1b8,	26000000,  mux_pllp_clkm,		MUX | DIV_U16 | PERIPH_ON_APB),
 	PERIPH_CLK("i2c4",	"tegra-i2c.3",		NULL,	103,	0x3c4,	26000000,  mux_pllp_clkm,		MUX | DIV_U16 | PERIPH_ON_APB),
 	PERIPH_CLK("i2c5",	"tegra-i2c.4",		NULL,	47,	0x128,	26000000,  mux_pllp_clkm,		MUX | DIV_U16 | PERIPH_ON_APB),
-	PERIPH_CLK("uarta",	"tegra_uart.0",		NULL,	6,	0x178,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uartb",	"tegra_uart.1",		NULL,	7,	0x17c,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uartc",	"tegra_uart.2",		NULL,	55,	0x1a0,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uartd",	"tegra_uart.3",		NULL,	65,	0x1c0,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uarte",	"tegra_uart.4",		NULL,	66,	0x1c4,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uarta_dbg",	"serial8250.0",		"uarta", 6,	0x178,	800000000, mux_pllp_clkm,		MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uartb_dbg",	"serial8250.0",		"uartb", 7,	0x17c,	800000000, mux_pllp_clkm,		MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uartc_dbg",	"serial8250.0",		"uartc", 55,	0x1a0,	800000000, mux_pllp_clkm,		MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uartd_dbg",	"serial8250.0",		"uartd", 65,	0x1c0,	800000000, mux_pllp_clkm,		MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
-	PERIPH_CLK("uarte_dbg",	"serial8250.0",		"uarte", 66,	0x1c4,	800000000, mux_pllp_clkm,		MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
+	PERIPH_CLK("uarta",	"tegra-uart.0",		NULL,	6,	0x178,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
+	PERIPH_CLK("uartb",	"tegra-uart.1",		NULL,	7,	0x17c,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
+	PERIPH_CLK("uartc",	"tegra-uart.2",		NULL,	55,	0x1a0,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
+	PERIPH_CLK("uartd",	"tegra-uart.3",		NULL,	65,	0x1c0,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
+	PERIPH_CLK("uarte",	"tegra-uart.4",		NULL,	66,	0x1c4,	800000000, mux_pllp_pllc_pllm_clkm,	MUX | DIV_U71 | DIV_U71_UART | PERIPH_ON_APB),
 	PERIPH_CLK_EX("vi",	"tegra_camera",		"vi",	20,	0x148,	425000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71 | DIV_U71_INT,	&tegra_vi_clk_ops),
 	PERIPH_CLK("3d",	"3d",			NULL,	24,	0x158,	520000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71 | DIV_U71_INT | DIV_U71_IDLE | PERIPH_MANUAL_RESET),
 	PERIPH_CLK("3d2",       "3d2",			NULL,	98,	0x3b0,	520000000, mux_pllm_pllc_pllp_plla,	MUX | DIV_U71 | DIV_U71_INT | DIV_U71_IDLE | PERIPH_MANUAL_RESET),
@@ -2983,6 +2978,11 @@ struct clk tegra_list_clks[] = {
  * table under two names.
  */
 struct clk_duplicate tegra_clk_duplicates[] = {
+	CLK_DUPLICATE("uarta",  "serial8250.0", NULL),
+	CLK_DUPLICATE("uartb",  "serial8250.1", NULL),
+	CLK_DUPLICATE("uartc",  "serial8250.2", NULL),
+	CLK_DUPLICATE("uartd",  "serial8250.3", NULL),
+	CLK_DUPLICATE("uarte",  "serial8250.4", NULL),
 	CLK_DUPLICATE("usbd", "utmip-pad", NULL),
 	CLK_DUPLICATE("usbd", "tegra-ehci.0", NULL),
 	CLK_DUPLICATE("usbd", "tegra-otg", NULL),
-- 
1.7.4.1
