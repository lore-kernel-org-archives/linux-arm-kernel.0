From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 13 Jun 2014 09:40:35 -0700
Subject: [PATCH] arm: Fix build warning
Message-ID: <1402677635-28406-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If compiled with W=1, the following warning is seen in arm builds.

arch/arm/kernel/topology.c:278:25: warning:
	type qualifiers ignored on function return type

This is caused by a function returning 'const int', which doesn't
make sense to gcc. Drop 'const' to fix the problem.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 3997c41..cc52061 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -275,7 +275,7 @@ void store_cpu_topology(unsigned int cpuid)
 		cpu_topology[cpuid].socket_id, mpidr);
 }
 
-static inline const int cpu_corepower_flags(void)
+static inline int cpu_corepower_flags(void)
 {
 	return SD_SHARE_PKG_RESOURCES  | SD_SHARE_POWERDOMAIN;
 }
-- 
1.9.1
