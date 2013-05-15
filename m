From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 15 May 2013 17:09:44 +0200
Subject: [PATCH] ARM: SAMSUNG: devs: Add names to fimd0 IRQ resources
Message-ID: <1368630584-30147-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 1977e6d8 (drm/exynos: change the method for getting the
interrupt) the Exynos DRM FIMD driver requires IRQ resources to be
named. This patch fixes probe failure in non-DT cases by adding
appropriate resource names to fimd0 platform device.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/devs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-samsung/devs.c b/arch/arm/plat-samsung/devs.c
index 30c2fe2..0f9c3f4 100644
--- a/arch/arm/plat-samsung/devs.c
+++ b/arch/arm/plat-samsung/devs.c
@@ -311,9 +311,9 @@ struct platform_device s5p_device_jpeg = {
 #ifdef CONFIG_S5P_DEV_FIMD0
 static struct resource s5p_fimd0_resource[] = {
 	[0] = DEFINE_RES_MEM(S5P_PA_FIMD0, SZ_32K),
-	[1] = DEFINE_RES_IRQ(IRQ_FIMD0_VSYNC),
-	[2] = DEFINE_RES_IRQ(IRQ_FIMD0_FIFO),
-	[3] = DEFINE_RES_IRQ(IRQ_FIMD0_SYSTEM),
+	[1] = DEFINE_RES_IRQ_NAMED(IRQ_FIMD0_VSYNC, "vsync"),
+	[2] = DEFINE_RES_IRQ_NAMED(IRQ_FIMD0_FIFO, "fifo"),
+	[3] = DEFINE_RES_IRQ_NAMED(IRQ_FIMD0_SYSTEM, "lcd_sys"),
 };
 
 struct platform_device s5p_device_fimd0 = {
-- 
1.8.2.1
