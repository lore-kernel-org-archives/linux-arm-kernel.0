From: peterhuewe@gmx.de (Peter Huewe)
Date: Sun, 17 Jan 2010 21:46:02 +0100
Subject: [PATCH] arch/arm: Fix build failure for msm_defconfig caused by wrong
	include path
Message-ID: <1263761162-9447-1-git-send-email-peterhuewe@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a build failure [1] due to a wrong include path.

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2020066/

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
Patch against Linux-next of So 17. Jan 21:24:00 CET 2010
KernelVersion: next-20100114

Resending this patch as I got some errors from my mail-server, sorry for
the inconvenience
 arch/arm/mach-msm/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/devices.c b/arch/arm/mach-msm/devices.c
index a64578f..737fd09 100644
--- a/arch/arm/mach-msm/devices.c
+++ b/arch/arm/mach-msm/devices.c
@@ -29,7 +29,7 @@
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
 
-#include <asm/mach/mmc.h>
+#include <mach/mmc.h>
 
 static struct resource resources_uart1[] = {
 	{
-- 
1.6.4.4
