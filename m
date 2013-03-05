From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 23:16:47 +0100
Subject: [PATCH 7/9] [media] s5p-fimc: fix s5pv210 build
In-Reply-To: <1362521809-22989-1-git-send-email-arnd@arndb.de>
References: <1362521809-22989-1-git-send-email-arnd@arndb.de>
Message-ID: <1362521809-22989-8-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

56bc911 "[media] s5p-fimc: Redefine platform data structure for fimc-is"
changed the bus_type member of struct fimc_source_info treewide, but
got one instance wrong in mach-s5pv210, which was evidently not
even build tested.

This adds the missing change to get s5pv210_defconfig to build again.
Applies on the Mauro's media tree.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
---
 arch/arm/mach-s5pv210/mach-goni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 3a38f7b..e373de4 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -845,7 +845,7 @@ static struct fimc_source_info goni_camera_sensors[] = {
 		.mux_id		= 0,
 		.flags		= V4L2_MBUS_PCLK_SAMPLE_FALLING |
 				  V4L2_MBUS_VSYNC_ACTIVE_LOW,
-		.bus_type	= FIMC_BUS_TYPE_ITU_601,
+		.fimc_bus_type	= FIMC_BUS_TYPE_ITU_601,
 		.board_info	= &noon010pc30_board_info,
 		.i2c_bus_num	= 0,
 		.clk_frequency	= 16000000UL,
-- 
1.8.1.2
