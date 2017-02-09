From: juri.lelli@arm.com (Juri Lelli)
Date: Thu,  9 Feb 2017 09:25:21 +0000
Subject: [PATCH v2 5/9] arm64: remove wrong CONFIG_PROC_SYSCTL ifdef
In-Reply-To: <20170209092525.6654-1-juri.lelli@arm.com>
References: <20170209092525.6654-1-juri.lelli@arm.com>
Message-ID: <20170209092525.6654-6-juri.lelli@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysfs cpu_capacity entry for each CPU has nothing to do with
PROC_FS, nor it's in /proc/sys path.

Remove such ifdef.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reported-and-suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: be8f185d8af4 ('arm64: add sysfs cpu_capacity attribute')
Signed-off-by: Juri Lelli <juri.lelli@arm.com>
---
 arch/arm64/kernel/topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 655e65f38f31..565dd69888cc 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -41,7 +41,6 @@ static void set_capacity_scale(unsigned int cpu, unsigned long capacity)
 	per_cpu(cpu_scale, cpu) = capacity;
 }
 
-#ifdef CONFIG_PROC_SYSCTL
 static ssize_t cpu_capacity_show(struct device *dev,
 				 struct device_attribute *attr,
 				 char *buf)
@@ -98,7 +97,6 @@ static int register_cpu_capacity_sysctl(void)
 	return 0;
 }
 subsys_initcall(register_cpu_capacity_sysctl);
-#endif
 
 static u32 capacity_scale;
 static u32 *raw_capacity;
-- 
2.10.0
