From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Apr 2012 08:33:45 +0200
Subject: [PATCH for v3.4-rc3] ARM: Samsung: add missing MMC_CAP2_BROKEN_VOLTAGE
 capability
Message-ID: <1334558025-26635-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 6e8201f57c935 "mmc: core: add the capability for broken voltage"
introduced a new quirk to indicate that MMC core should ignore voltage
change errors reported by the regulators core. This is required to get
SDHCI working on UniversalC210, NURI and GONI boards again after commit
ceb6143b2df81c ("mmc: sdhci: fix vmmc handling").

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c           |    1 +
 arch/arm/mach-exynos/mach-universal_c210.c |    1 +
 arch/arm/mach-s5pv210/mach-goni.c          |    2 ++
 3 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index 91e5986..021dc68 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -112,6 +112,7 @@ static struct s3c_sdhci_platdata nuri_hsmmc0_data __initdata = {
 	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_ERASE),
+	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 };
 
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index ef706e9..add55b4 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -747,6 +747,7 @@ static struct s3c_sdhci_platdata universal_hsmmc0_data __initdata = {
 	.max_width		= 8,
 	.host_caps		= (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA |
 				MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED),
+	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 };
 
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index a8933de..3239566 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -25,6 +25,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/mmc/host.h>
 #include <linux/interrupt.h>
 
 #include <asm/hardware/vic.h>
@@ -765,6 +766,7 @@ static void __init goni_pmic_init(void)
 /* MoviNAND */
 static struct s3c_sdhci_platdata goni_hsmmc0_data __initdata = {
 	.max_width		= 4,
+	.host_caps2		= MMC_CAP2_BROKEN_VOLTAGE,
 	.cd_type		= S3C_SDHCI_CD_PERMANENT,
 };
 
-- 
1.7.1.569.g6f426
