From: dilinger@queued.net (Andres Salomon)
Date: Fri, 4 Mar 2011 08:06:53 -0800
Subject: [PATCH] ARM: mx51_efika: update platform data for new mfd changes
Message-ID: <20110304080653.3f2c3f19@debxo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Note that this relies on stuff currently in mfd's next tree, but this
is also a newer driver.  I'm not sure which tree it should go through,
as it's a problem that shows up in next.



From: Andres Salomon <dilinger@queued.net>

MFD changes in c738892f cause the mc13xxx_platform_data struct
to change.  This changes one more (new) user of it, fixing a build
error.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 arch/arm/mach-mx5/mx51_efika.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_efika.c
index 74991c9..6451fb4 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -572,8 +572,10 @@ static struct mc13xxx_regulator_init_data mx51_efika_regulators[] = {
 
 static struct mc13xxx_platform_data mx51_efika_mc13892_data = {
 	.flags = MC13XXX_USE_RTC | MC13XXX_USE_REGULATOR,
-	.num_regulators = ARRAY_SIZE(mx51_efika_regulators),
-	.regulators = mx51_efika_regulators,
+	.regulators = {
+		.num_regulators = ARRAY_SIZE(mx51_efika_regulators),
+		.regulators = mx51_efika_regulators,
+	},
 };
 
 static struct spi_board_info mx51_efika_spi_board_info[] __initdata = {
-- 
1.7.2.3
