From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 07 Nov 2012 14:01:19 +0100
Subject: [PATCH] ARM: EXYNOS: origen: Add missing USB regulators
Message-ID: <1706359.z5UOYbqyny@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing USB OTG regulators needed for s3c-hsotg driver
to work on Origen board.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-origen.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-exynos/mach-origen.c b/arch/arm/mach-exynos/mach-origen.c
index d8dc6d7..ddf6358 100644
--- a/arch/arm/mach-exynos/mach-origen.c
+++ b/arch/arm/mach-exynos/mach-origen.c
@@ -100,6 +100,8 @@ static struct regulator_consumer_supply __initdata ldo3_consumer[] = {
 	REGULATOR_SUPPLY("vddcore", "s5p-mipi-csis.0"), /* MIPI */
 	REGULATOR_SUPPLY("vdd", "exynos4-hdmi"), /* HDMI */
 	REGULATOR_SUPPLY("vdd_pll", "exynos4-hdmi"), /* HDMI */
+	REGULATOR_SUPPLY("vusb_d", "s3c-hsotg"), /* OTG */
+	REGULATOR_SUPPLY("vusb_a", "s3c-hsotg"), /* OTG */
 };
 static struct regulator_consumer_supply __initdata ldo6_consumer[] = {
 	REGULATOR_SUPPLY("vddio", "s5p-mipi-csis.0"), /* MIPI */
-- 
1.8.0
