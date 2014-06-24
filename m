From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Tue, 24 Jun 2014 17:13:51 +0530
Subject: [PATCH 4/8] ARM: mvebu: Staticize mvebu_cpu_reset_init
In-Reply-To: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
References: <1403610235-22654-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <1403610235-22654-4-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sachin Kamat <sachin.kamat@linaro.org>

'mvebu_cpu_reset_init' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 arch/arm/mach-mvebu/cpu-reset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
index 4a8f9eebebea..60fb53787004 100644
--- a/arch/arm/mach-mvebu/cpu-reset.c
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -67,7 +67,7 @@ static int mvebu_cpu_reset_map(struct device_node *np, int res_idx)
 	return 0;
 }
 
-int __init mvebu_cpu_reset_init(void)
+static int __init mvebu_cpu_reset_init(void)
 {
 	struct device_node *np;
 	int res_idx;
-- 
1.7.9.5
