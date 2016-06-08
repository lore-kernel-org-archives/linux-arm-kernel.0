From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed,  8 Jun 2016 19:26:31 +0100
Subject: [PATCH] power: vexpress: make dev_attr_active static
Message-ID: <1465410391-29475-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dev_attr_active is not exported or defined to be used
outside the driver, so make it static to avoid the following
warning:

drivers/power/reset/vexpress-poweroff.c:77:1: warning: symbol 'dev_attr_active' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pm at vger.kernel.org
Cc: linux-pm at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
---
 drivers/power/reset/vexpress-poweroff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/vexpress-poweroff.c b/drivers/power/reset/vexpress-poweroff.c
index 6a9bf70..102f95a 100644
--- a/drivers/power/reset/vexpress-poweroff.c
+++ b/drivers/power/reset/vexpress-poweroff.c
@@ -74,8 +74,8 @@ static ssize_t vexpress_reset_active_store(struct device *dev,
 	return err ? err : count;
 }
 
-DEVICE_ATTR(active, S_IRUGO | S_IWUSR, vexpress_reset_active_show,
-		vexpress_reset_active_store);
+static DEVICE_ATTR(active, S_IRUGO | S_IWUSR, vexpress_reset_active_show,
+		   vexpress_reset_active_store);
 
 
 enum vexpress_reset_func { FUNC_RESET, FUNC_SHUTDOWN, FUNC_REBOOT };
-- 
2.8.1
