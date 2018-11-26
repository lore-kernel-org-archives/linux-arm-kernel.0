From: otavio@ossystems.com.br (Otavio Salvador)
Date: Mon, 26 Nov 2018 17:59:05 -0200
Subject: [PATCH v2 2/2] ARM: multi_v7_defconfig: Improve use with systemd
In-Reply-To: <20181126195905.5427-1-otavio@ossystems.com.br>
References: <20181126195905.5427-1-otavio@ossystems.com.br>
Message-ID: <20181126195905.5427-2-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Berton <fabio.berton@ossystems.com.br>

This enables following options:

 - CONFIG_CGROUP_BPF
 - CONFIG_NAMESPACES
 - CONFIG_USER_NS
 - CONFIG_CHECKPOINT_RESTORE
 - CONFIG_BPF_SYSCALL

Those are based on recommendation from Gentoo wiki[1] which describes
the recommended and required kernel options for systemd use.

 1. https://wiki.gentoo.org/wiki/Systemd#Kernel

Signed-off-by: Fabio Berton <fabio.berton@ossystems.com.br>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

Changes in v2:
- rework commit log

 arch/arm/configs/multi_v7_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a8ec309d182a..34c8a745d951 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -2,7 +2,12 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
+CONFIG_CGROUP_BPF=y
+CONFIG_NAMESPACES=y
+CONFIG_USER_NS=y
+CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BPF_SYSCALL=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
-- 
2.19.2
