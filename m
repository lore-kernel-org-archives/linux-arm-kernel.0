From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 31 Oct 2012 14:32:53 +0530
Subject: [PATCH V4 2/4] ARM: tegra: Add OF_DEV_AUXDATA for SLINK driver in
 board dt
In-Reply-To: <1351674176-20603-1-git-send-email-ldewangan@nvidia.com>
References: <1351674176-20603-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1351674176-20603-2-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add OF_DEV_AUXDATA for slink driver for Tegra20 and Tegra30
board dt files.
Set the parent clock of slink controller to PLLP and configure
clock to 100MHz.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Revert the changes in clock table to get the driver name.

Changes from V2:
- Get rid of the iomap.h

Changes from V3:
- None

 arch/arm/mach-tegra/board-dt-tegra20.c |    8 ++++++++
 arch/arm/mach-tegra/board-dt-tegra30.c |   12 ++++++++++++
 2 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 2053f74..5a19589 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -90,6 +90,10 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 		       &tegra_ehci3_pdata),
 	OF_DEV_AUXDATA("nvidia,tegra20-apbdma", TEGRA_APB_DMA_BASE, "tegra-apbdma", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", 0x7000D400, "spi_tegra.0", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", 0x7000D600, "spi_tegra.1", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", 0x7000D800, "spi_tegra.2", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", 0x7000DA00, "spi_tegra.3", NULL),
 	{}
 };
 
@@ -109,6 +113,10 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	{ "sdmmc1",	"pll_p",	48000000,	false},
 	{ "sdmmc3",	"pll_p",	48000000,	false},
 	{ "sdmmc4",	"pll_p",	48000000,	false},
+	{ "sbc1",	"pll_p",	100000000,	false },
+	{ "sbc2",	"pll_p",	100000000,	false },
+	{ "sbc3",	"pll_p",	100000000,	false },
+	{ "sbc4",	"pll_p",	100000000,	false },
 	{ NULL,		NULL,		0,		0},
 };
 
diff --git a/arch/arm/mach-tegra/board-dt-tegra30.c b/arch/arm/mach-tegra/board-dt-tegra30.c
index 9e6f79a..b26cfef 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -52,6 +52,12 @@ struct of_dev_auxdata tegra30_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra30-ahub", 0x70080000, "tegra30-ahub", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-apbdma", 0x6000a000, "tegra-apbdma", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", 0x7000D400, "spi_tegra.0", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", 0x7000D600, "spi_tegra.1", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", 0x7000D800, "spi_tegra.2", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", 0x7000DA00, "spi_tegra.3", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", 0x7000DC00, "spi_tegra.4", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", 0x7000DE00, "spi_tegra.5", NULL),
 	{}
 };
 
@@ -71,6 +77,12 @@ static __initdata struct tegra_clk_init_table tegra_dt_clk_init_table[] = {
 	{ "sdmmc1",	"pll_p",	48000000,	false},
 	{ "sdmmc3",	"pll_p",	48000000,	false},
 	{ "sdmmc4",	"pll_p",	48000000,	false},
+	{ "sbc1",	"pll_p",	100000000,	false},
+	{ "sbc2",	"pll_p",	100000000,	false},
+	{ "sbc3",	"pll_p",	100000000,	false},
+	{ "sbc4",	"pll_p",	100000000,	false},
+	{ "sbc5",	"pll_p",	100000000,	false},
+	{ "sbc6",	"pll_p",	100000000,	false},
 	{ NULL,		NULL,		0,		0},
 };
 
-- 
1.7.1.1
