From: nm@ti.com (Nishanth Menon)
Date: Tue,  4 Jan 2011 14:07:12 -0600
Subject: [PATCH 3/5] omap3: igep3: make igep3_flash_init static
In-Reply-To: <1294171634-13943-1-git-send-email-nm@ti.com>
References: <1294171634-13943-1-git-send-email-nm@ti.com>
Message-ID: <1294171634-13943-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

igep3_flash_init is not used beyond the scope of the file, make it
static instead.

Fixes sparse warning:
arch/arm/mach-omap2/board-igep0030.c:106:13: warning: symbol 'igep3_flash_init' was not declared. Should it be static?

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-igep0030.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0030.c b/arch/arm/mach-omap2/board-igep0030.c
index bcccd68..c88e8f7 100644
--- a/arch/arm/mach-omap2/board-igep0030.c
+++ b/arch/arm/mach-omap2/board-igep0030.c
@@ -103,7 +103,7 @@ static struct platform_device igep3_onenand_device = {
 	},
 };
 
-void __init igep3_flash_init(void)
+static void __init igep3_flash_init(void)
 {
 	u8 cs = 0;
 	u8 onenandcs = GPMC_CS_NUM + 1;
@@ -137,7 +137,7 @@ void __init igep3_flash_init(void)
 }
 
 #else
-void __init igep3_flash_init(void) {}
+static void __init igep3_flash_init(void) {}
 #endif
 
 static struct regulator_consumer_supply igep3_vmmc1_supply = {
-- 
1.6.3.3
