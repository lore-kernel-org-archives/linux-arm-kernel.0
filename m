From: axel.lin@gmail.com (Axel Lin)
Date: Thu, 10 Nov 2011 09:56:18 +0800
Subject: [PATCH] mfd: add #ifdef CONFIG_DEBUG_FS guard for
 ab8500_debug_resources
Message-ID: <1320890178.13074.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix below build warning if CONFIG_DEBUG_FS is disabled.

  CC      drivers/mfd/ab8500-core.o
drivers/mfd/ab8500-core.c:623: warning: 'ab8500_debug_resources' defined but not used

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/mfd/ab8500-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 1e91738..d3d572b 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -620,6 +620,7 @@ static struct resource __devinitdata ab8500_fg_resources[] = {
 
 static struct resource __devinitdata ab8500_chargalg_resources[] = {};
 
+#ifdef CONFIG_DEBUG_FS
 static struct resource __devinitdata ab8500_debug_resources[] = {
 	{
 		.name	= "IRQ_FIRST",
@@ -634,6 +635,7 @@ static struct resource __devinitdata ab8500_debug_resources[] = {
 		.flags	= IORESOURCE_IRQ,
 	},
 };
+#endif
 
 static struct resource __devinitdata ab8500_usb_resources[] = {
 	{
-- 
1.7.5.4
