From: pbrobinson@gmail.com (Peter Robinson)
Date: Sun, 11 Nov 2018 18:10:47 +0000
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: enable BPF related configs
Message-ID: <20181111181048.10933-1-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BPF components are getting more widely used by various components
so we should enable them in the ARMv7 multi config to ensure they
get wider testing and don't regress.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 1c7616815a86..8067c882fa2e 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -3,7 +3,10 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_CGROUPS=y
+CONFIG_CGROUP_BPF=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF_SYSCALL=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
@@ -156,6 +159,8 @@ CONFIG_IPV6_MIP6=m
 CONFIG_IPV6_TUNNEL=m
 CONFIG_IPV6_MULTIPLE_TABLES=y
 CONFIG_NET_DSA=m
+CONFIG_BPF_JIT=y
+CONFIG_BPF_STREAM_PARSER=y
 CONFIG_CAN=y
 CONFIG_CAN_AT91=m
 CONFIG_CAN_FLEXCAN=m
-- 
2.19.1
