From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 18 Jan 2017 14:53:26 -0800
Subject: [PATCH] ARM: Reduce "CPU: shutdown" message to debug level
In-Reply-To: <20170117230714.6799-1-f.fainelli@gmail.com>
References: <20170117230714.6799-1-f.fainelli@gmail.com>
Message-ID: <20170118225328.2597-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to c68b0274fb3c ("ARM: reduce "Booted secondary processor"
message to debug level"), demote the "CPU: shutdown" pr_notice() into a
pr_debug().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 7dd14e8395e6..46377c40d056 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -251,7 +251,7 @@ void __cpu_die(unsigned int cpu)
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
-	pr_notice("CPU%u: shutdown\n", cpu);
+	pr_debug("CPU%u: shutdown\n", cpu);
 
 	/*
 	 * platform_cpu_kill() is generally expected to do the powering off
-- 
2.9.3
