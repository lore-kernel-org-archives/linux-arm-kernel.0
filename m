From: amit.daniel@samsung.com (Amit Daniel Kachhap)
Date: Sat, 29 Nov 2014 19:45:06 +0530
Subject: [PATCH v5 4/6] driver: soc: exynos-pmu: Add a new structure to allow
 u32 conf data
In-Reply-To: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
References: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
Message-ID: <1417270508-11174-5-git-send-email-amit.daniel@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b04fa9f "ARM: EXYNOS: use u8 for val[] in struct exynos_pmu_conf"
modifies the structure to allow only u8 type configuration data. To
support SoC's which need u32 type data a new structure is added.

Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
index c3307eb..e1a4884 100644
--- a/drivers/soc/samsung/exynos-pmu.c
+++ b/drivers/soc/samsung/exynos-pmu.c
@@ -26,9 +26,14 @@ struct exynos_pmu_conf {
 	u8 val[NUM_SYS_POWERDOWN];
 };
 
+struct exynos_pmu_conf_extra {
+	u32 offset;
+	u32 val[NUM_SYS_POWERDOWN];
+};
+
 struct exynos_pmu_data {
 	const struct exynos_pmu_conf *pmu_config;
-	const struct exynos_pmu_conf *pmu_config_extra;
+	const struct exynos_pmu_conf_extra *pmu_config_extra;
 
 	void (*pmu_init)(void);
 	void (*powerdown_conf)(enum sys_powerdown);
@@ -324,7 +329,7 @@ static const struct exynos_pmu_conf exynos4x12_pmu_config[] = {
 	{ PMU_TABLE_END,},
 };
 
-static const struct exynos_pmu_conf exynos4412_pmu_config[] = {
+static const struct exynos_pmu_conf_extra exynos4412_pmu_config[] = {
 	{ S5P_ARM_CORE2_LOWPWR,			{ 0x0, 0x0, 0x2 } },
 	{ S5P_DIS_IRQ_CORE2,			{ 0x0, 0x0, 0x0 } },
 	{ S5P_DIS_IRQ_CENTRAL2,			{ 0x0, 0x0, 0x0 } },
-- 
1.7.9.5
