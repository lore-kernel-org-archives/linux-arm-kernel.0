From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 29 Oct 2012 22:49:38 +0530
Subject: [PATCH V2 2/4] ARM: tegra: Add OF_DEV_AUXDATA for SLINK driver in
 board dt
In-Reply-To: <1351531180-1652-1-git-send-email-ldewangan@nvidia.com>
References: <1351531180-1652-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1351531180-1652-3-git-send-email-ldewangan@nvidia.com>
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

 arch/arm/mach-tegra/board-dt-tegra20.c   |    8 ++++++++
 arch/arm/mach-tegra/board-dt-tegra30.c   |   12 ++++++++++++
 arch/arm/mach-tegra/include/mach/iomap.h |   22 ++++++++++++++--------
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-tegra/board-dt-tegra20.c b/arch/arm/mach-tegra/board-dt-tegra20.c
index 2053f74..3fdcb45 100644
--- a/arch/arm/mach-tegra/board-dt-tegra20.c
+++ b/arch/arm/mach-tegra/board-dt-tegra20.c
@@ -90,6 +90,10 @@ struct of_dev_auxdata tegra20_auxdata_lookup[] __initdata = {
 		       &tegra_ehci3_pdata),
 	OF_DEV_AUXDATA("nvidia,tegra20-apbdma", TEGRA_APB_DMA_BASE, "tegra-apbdma", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra20-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK1_BASE, "spi_tegra.0", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK2_BASE, "spi_tegra.1", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK3_BASE, "spi_tegra.2", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra20-slink", TEGRA_SLINK4_BASE, "spi_tegra.3", NULL),
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
index 9e6f79a..ec7c35d 100644
--- a/arch/arm/mach-tegra/board-dt-tegra30.c
+++ b/arch/arm/mach-tegra/board-dt-tegra30.c
@@ -52,6 +52,12 @@ struct of_dev_auxdata tegra30_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("nvidia,tegra30-ahub", 0x70080000, "tegra30-ahub", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-apbdma", 0x6000a000, "tegra-apbdma", NULL),
 	OF_DEV_AUXDATA("nvidia,tegra30-pwm", TEGRA_PWFM_BASE, "tegra-pwm", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", TEGRA_SLINK1_BASE, "spi_tegra.0", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", TEGRA_SLINK2_BASE, "spi_tegra.1", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", TEGRA_SLINK3_BASE, "spi_tegra.2", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", TEGRA_SLINK4_BASE, "spi_tegra.3", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", TEGRA_SLINK5_BASE, "spi_tegra.4", NULL),
+	OF_DEV_AUXDATA("nvidia,tegra30-slink", TEGRA_SLINK6_BASE, "spi_tegra.5", NULL),
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
 
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index fee3a94..0f46765 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -206,17 +206,23 @@
 #define TEGRA_DVC_BASE			0x7000D000
 #define TEGRA_DVC_SIZE			SZ_512
 
-#define TEGRA_SPI1_BASE			0x7000D400
-#define TEGRA_SPI1_SIZE			SZ_512
+#define TEGRA_SLINK1_BASE		0x7000D400
+#define TEGRA_SLINK1_SIZE		SZ_512
 
-#define TEGRA_SPI2_BASE			0x7000D600
-#define TEGRA_SPI2_SIZE			SZ_512
+#define TEGRA_SLINK2_BASE		0x7000D600
+#define TEGRA_SLINK2_SIZE		SZ_512
 
-#define TEGRA_SPI3_BASE			0x7000D800
-#define TEGRA_SPI3_SIZE			SZ_512
+#define TEGRA_SLINK3_BASE		0x7000D800
+#define TEGRA_SLINK3_SIZE		SZ_512
 
-#define TEGRA_SPI4_BASE			0x7000DA00
-#define TEGRA_SPI4_SIZE			SZ_512
+#define TEGRA_SLINK4_BASE		0x7000DA00
+#define TEGRA_SLINK4_SIZE		SZ_512
+
+#define TEGRA_SLINK5_BASE		0x7000DC00
+#define TEGRA_SLINK5_SIZE		SZ_512
+
+#define TEGRA_SLINK6_BASE		0x7000DE00
+#define TEGRA_SLINK6_SIZE		SZ_512
 
 #define TEGRA_RTC_BASE			0x7000E000
 #define TEGRA_RTC_SIZE			SZ_256
-- 
1.7.1.1
