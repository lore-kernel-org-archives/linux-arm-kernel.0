From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 25 Jul 2014 15:23:49 +0100
Subject: [PATCH 1/5] ARM: imx: Remove references to platform_bus in mxc code
Message-ID: <1406298233-27876-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bus devices created to be parents for other peripherals
were using platform_bus as a parent, not being platform
devices themselves. Remove the references, making them
virtual devices instead.

Cc: Shawn Guo <shawn.guo@freescale.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Pawel Moll <pawel.moll@arm.com>
---

This patch is a part of effort to remove references to platform_bus
and make it static.

Shawn, Sascha - could you, please, have a look if such change
is acceptable for you?

 arch/arm/mach-imx/devices/devices.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/devices/devices.c b/arch/arm/mach-imx/devices/devices.c
index 1b4366a..8eab544 100644
--- a/arch/arm/mach-imx/devices/devices.c
+++ b/arch/arm/mach-imx/devices/devices.c
@@ -24,12 +24,10 @@
 
 struct device mxc_aips_bus = {
 	.init_name	= "mxc_aips",
-	.parent		= &platform_bus,
 };
 
 struct device mxc_ahb_bus = {
 	.init_name	= "mxc_ahb",
-	.parent		= &platform_bus,
 };
 
 int __init mxc_device_init(void)
-- 
1.9.1
