From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Tue, 24 Jun 2014 17:13:50 +0530
Subject: [PATCH 3/8] ARM: mvebu: Staticize armada_370_xp_cpu_pm_init
In-Reply-To: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
References: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <1403610235-22654-3-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

'armada_370_xp_cpu_pm_init' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/pmsu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 27d98e7e7ab8..9c819d65b337 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -258,7 +258,7 @@ static struct notifier_block armada_370_xp_cpu_pm_notifier = {
 	.notifier_call = armada_370_xp_cpu_pm_notify,
 };
 
-int __init armada_370_xp_cpu_pm_init(void)
+static int __init armada_370_xp_cpu_pm_init(void)
 {
 	struct device_node *np;
 
-- 
1.7.9.5
