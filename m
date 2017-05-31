From: juri.lelli@arm.com (Juri Lelli)
Date: Wed, 31 May 2017 17:59:27 +0100
Subject: [PATCH v5 3/7] arm: remove wrong CONFIG_PROC_SYSCTL ifdef
In-Reply-To: <20170531165931.6945-1-juri.lelli@arm.com>
References: <20170531165931.6945-1-juri.lelli@arm.com>
Message-ID: <20170531165931.6945-4-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysfs cpu_capacity entry for each CPU has nothing to do with
PROC_FS, nor it's in /proc/sys path.

Remove such ifdef.

Cc: Russell King <linux@arm.linux.org.uk>
Reported-and-suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 7e5930aaef5d ('ARM: 8622/3: add sysfs cpu_capacity attribute')
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/kernel/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 1b8ec3054642..40dd35aa46d0 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -57,7 +57,6 @@ static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
-#ifdef CONFIG_PROC_SYSCTL
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -114,7 +113,6 @@ static int register_cpu_capacity_sysctl(void)
 	return 0;
 }
 subsys_initcall(register_cpu_capacity_sysctl);
-#endif
 
 #ifdef CONFIG_OF
 struct cpu_efficiency {
-- 
2.11.0
