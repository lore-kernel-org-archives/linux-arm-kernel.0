From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Jun 2013 17:22:01 +0900
Subject: [PATCH 03/11] ARM: shmobile: kzm9d: resigser smsc911x platform device
 with id -1
In-Reply-To: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
References: <1370593329-27559-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1370593329-27559-4-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the kzm9d only has one smsc911x device it
may be registered as a platform device with id -1.

This allows the kzm9d board to access the smsc911x device
when CONFIG_REGULATOR (and CONFIG_REGULATOR_FIXED_VOLTAGE)
are set. The motivation for which is twofold: using regulators
seems to be generally a good thing; it will move the kzm9d defconfig
one step closer to being able to be consolidated with other
shmobile defconfigs.

An alternate but so far untested approach would be to
update the definition of dummy_supplies in board-kzm9d.c
to use "smsc911x.0" instead of "smsc911x".

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-kzm9d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9d.c b/arch/arm/mach-shmobile/board-kzm9d.c
index c016ccd..4368000 100644
--- a/arch/arm/mach-shmobile/board-kzm9d.c
+++ b/arch/arm/mach-shmobile/board-kzm9d.c
@@ -56,7 +56,7 @@ static struct smsc911x_platform_config smsc911x_platdata = {
 
 static struct platform_device smsc91x_device = {
 	.name	= "smsc911x",
-	.id	= 0,
+	.id	= -1,
 	.dev	= {
 		  .platform_data = &smsc911x_platdata,
 		},
-- 
1.8.2.1
