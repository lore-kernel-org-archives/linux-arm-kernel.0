From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 06 Apr 2012 09:43:24 +0200
Subject: [PATCH 2/4] ARM: Exynos4: fix regulator name for NURI board
In-Reply-To: <1333698206-12348-1-git-send-email-m.szyprowski@samsung.com>
References: <1333698206-12348-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1333698206-12348-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regulator names should not contain slash to avoid issues with debugfs.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index b3966f0..88a3b5c3 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -572,7 +572,7 @@ static struct regulator_init_data __initdata max8997_ldo7_data = {
 
 static struct regulator_init_data __initdata max8997_ldo8_data = {
 	.constraints	= {
-		.name		= "VUSB/VDAC_3.3V_C210",
+		.name		= "VUSB+VDAC_3.3V_C210",
 		.min_uV		= 3300000,
 		.max_uV		= 3300000,
 		.valid_ops_mask	= REGULATOR_CHANGE_STATUS,
-- 
1.7.1.569.g6f426
