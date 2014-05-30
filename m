From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri, 30 May 2014 16:07:37 +0530
Subject: [PATCH Resend 4/8] ARM: mvebu: Staticize mvebu_cpu_reset_init
In-Reply-To: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
References: <1401446261-22423-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1401446261-22423-4-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'mvebu_cpu_reset_init' is local to this file.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
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
