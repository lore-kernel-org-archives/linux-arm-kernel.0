From: robh@kernel.org (Rob Herring)
Date: Wed, 28 Jan 2015 11:56:31 -0600
Subject: [PATCH 2/3] clocksource: versatile: adapt for Versatile AB and PB
 boards
In-Reply-To: <1422467792-2065-1-git-send-email-robh@kernel.org>
References: <1422467792-2065-1-git-send-email-robh@kernel.org>
Message-ID: <1422467792-2065-3-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The same 24MHz counter is also present on Versatile AB and PB boards, so
add the compatible string for them.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/versatile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/versatile.c b/drivers/clocksource/versatile.c
index 2798e74..0a26d3d 100644
--- a/drivers/clocksource/versatile.c
+++ b/drivers/clocksource/versatile.c
@@ -36,5 +36,7 @@ static void __init versatile_sched_clock_init(struct device_node *node)
 
 	sched_clock_register(versatile_sys_24mhz_read, 32, 24000000);
 }
-CLOCKSOURCE_OF_DECLARE(versatile, "arm,vexpress-sysreg",
+CLOCKSOURCE_OF_DECLARE(vexpress, "arm,vexpress-sysreg",
+		       versatile_sched_clock_init);
+CLOCKSOURCE_OF_DECLARE(versatile, "arm,versatile-sysreg",
 		       versatile_sched_clock_init);
-- 
2.1.0
