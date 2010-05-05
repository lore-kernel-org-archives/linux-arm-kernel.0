From: tony@atomide.com (Tony Lindgren)
Date: Wed, 05 May 2010 12:32:39 -0700
Subject: [PATCH 02/18] omap1: amsdelta: defconfig updates
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Message-ID: <20100505193239.21568.9650.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

The patch provides the following ams_delta_defconfig updates:
- explicitly select preemptable RCU,
- replace outdated CONFIG_LBD and CONFIG_LSF options with CONFIG_LBDAF,
- activate support for LCD contrast setting (new in 2.6.34),
- turn off verbose bug reporting for smaller kernel.

Created and tested against linux-2.6.34-rc3.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/ams_delta_defconfig |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
index ecf45fb..6d8a0c8 100644
--- a/arch/arm/configs/ams_delta_defconfig
+++ b/arch/arm/configs/ams_delta_defconfig
@@ -47,6 +47,7 @@ CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_TASKSTATS is not set
 # CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
+CONFIG_TREE_PREEMPT_RCU=y
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
@@ -95,9 +96,8 @@ CONFIG_KMOD=y
 # Block layer
 #
 CONFIG_BLOCK=y
-# CONFIG_LBD is not set
+# CONFIG_LBDAF is not set
 # CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
 
 #
 # IO Schedulers
@@ -836,7 +836,8 @@ CONFIG_DAB=y
 #
 # Graphics support
 #
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_BACKLIGHT_LCD_SUPPORT=y
+CONFIG_LCD_CLASS_DEVICE=y
 
 #
 # Display device support
@@ -1284,7 +1285,7 @@ CONFIG_DEBUG_PREEMPT=y
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
-CONFIG_DEBUG_BUGVERBOSE=y
+# CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_DEBUG_INFO is not set
 # CONFIG_DEBUG_VM is not set
 # CONFIG_DEBUG_LIST is not set
