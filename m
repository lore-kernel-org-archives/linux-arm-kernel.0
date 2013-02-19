From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Feb 2013 11:56:08 +0900
Subject: [PATCH 3/5] ARM: shmobile: r8a7779: Do not initialise i2c as an early
 device
In-Reply-To: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
References: <1361242570-8867-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1361242570-8867-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is sufficient to initialise i2c as a late device.

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index b1f7a45..7f8daf1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -333,7 +333,7 @@ static struct platform_device *r8a7779_devices_dt[] __initdata = {
 	&tmu01_device,
 };
 
-static struct platform_device *r8a7779_early_devices[] __initdata = {
+static struct platform_device *r8a7779_late_devices[] __initdata = {
 	&i2c0_device,
 	&i2c1_device,
 	&i2c2_device,
@@ -352,8 +352,8 @@ void __init r8a7779_add_standard_devices(void)
 
 	platform_add_devices(r8a7779_devices_dt,
 			    ARRAY_SIZE(r8a7779_devices_dt));
-	platform_add_devices(r8a7779_early_devices,
-			    ARRAY_SIZE(r8a7779_early_devices));
+	platform_add_devices(r8a7779_late_devices,
+			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
@@ -370,8 +370,6 @@ void __init r8a7779_add_early_devices(void)
 {
 	early_platform_add_devices(r8a7779_devices_dt,
 				   ARRAY_SIZE(r8a7779_devices_dt));
-	early_platform_add_devices(r8a7779_early_devices,
-				   ARRAY_SIZE(r8a7779_early_devices));
 
 	/* Early serial console setup is not included here due to
 	 * memory map collisions. The SCIF serial ports in r8a7779
-- 
1.7.10.4
