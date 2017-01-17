From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 17 Jan 2017 15:07:12 -0800
Subject: [PATCH] ARM: smp: Remove CPU: shutdown notice
Message-ID: <20170117230714.6799-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This message is not particularly informative, and is not paired with an
identical message when a CPU is brought online. Finally, it slows the
CPU hotplug path down, thus allowing less CPU hotplug operations per
second. Just remove it.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/kernel/smp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index 7dd14e8395e6..b3e02751ab64 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -251,7 +251,6 @@ void __cpu_die(unsigned int cpu)
 		pr_err("CPU%u: cpu didn't die\n", cpu);
 		return;
 	}
-	pr_notice("CPU%u: shutdown\n", cpu);
 
 	/*
 	 * platform_cpu_kill() is generally expected to do the powering off
-- 
2.9.3
