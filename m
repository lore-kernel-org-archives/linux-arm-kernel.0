From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 17 Nov 2014 11:55:07 -0800
Subject: [PATCH] ARM: multi_v7_defconfig: Enable cgroups
Message-ID: <1416254107-29326-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows booting the kernel with systemd-based root file systems.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
Hi,

I don't know whether I'm the only one, but I use a initramfs with
systemd as init, which requires cgroup support in the kernel to fully
boot.

	Thanks,
	S?ren
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 3487046d8a78..2dd723e63c35 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -3,6 +3,7 @@ CONFIG_FHANDLE=y
 CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
-- 
2.1.3.1.ge241007
