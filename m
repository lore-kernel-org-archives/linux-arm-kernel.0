From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 18:49:33 +0100
Subject: [PATCH] ARM: bcm2835: remove unused __packet
Message-ID: <1465321773-21519-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver defines a variable called __packet but then never
uses it, and does not export it for others to use either. Fix
the warning about undeclared variable by removing it.

drivers/soc/bcm/raspberrypi-power.c:48:3: warning: symbol '__packet' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Eric Anholt <eric@anholt.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexander Aring <alex.aring@gmail.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: linux-kernel at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/soc/bcm/raspberrypi-power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
index fe96a8b..f7ed118 100644
--- a/drivers/soc/bcm/raspberrypi-power.c
+++ b/drivers/soc/bcm/raspberrypi-power.c
@@ -45,7 +45,7 @@ struct rpi_power_domains {
 struct rpi_power_domain_packet {
 	u32 domain;
 	u32 on;
-} __packet;
+};
 
 /*
  * Asks the firmware to enable or disable power on a specific power
-- 
2.8.1
