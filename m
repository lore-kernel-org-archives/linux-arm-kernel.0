From: pbrobinson@gmail.com (Peter Robinson)
Date: Sun, 11 Nov 2018 18:10:48 +0000
Subject: [PATCH 2/2] arm64: defconfig: enable BPF related configs
In-Reply-To: <20181111181048.10933-1-pbrobinson@gmail.com>
References: <20181111181048.10933-1-pbrobinson@gmail.com>
Message-ID: <20181111181048.10933-2-pbrobinson@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BPF components are getting more widely used by various components
so we should enable them in the ARMv7 multi config to ensure they
get wider testing and don't regress.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c9a57d11330b..8748f6cf9fcd 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -19,6 +19,7 @@ CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_PIDS=y
 CONFIG_CGROUP_HUGETLB=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_BPF=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
@@ -157,7 +158,10 @@ CONFIG_VLAN_8021Q_MVRP=y
 CONFIG_QRTR=m
 CONFIG_QRTR_SMD=m
 CONFIG_QRTR_TUN=m
+CONFIG_BPF_SYSCALL=y
 CONFIG_BPF_JIT=y
+CONFIG_BPF_JIT_ALWAYS_ON=y
+CONFIG_BPF_STREAM_PARSER=y
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_HS is not set
-- 
2.19.1
