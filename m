From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 26 May 2011 14:26:43 +0800
Subject: [PATCH] ARM: mxs_defconfig: Remove locking debug config options
In-Reply-To: <20110525141624.GE2408@S2100-06.ap.freescale.net>
References: <20110525141624.GE2408@S2100-06.ap.freescale.net>
Message-ID: <1306391203-29338-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The amba-pl011 driver assumes that clk_enable/disable are atomic, but
currently it's not the case on mxs.  There are lock debug warnings
seen when serial console does power management.

The patch removes locking debug config options to get rid of the
warnings.  They can be turned on later when new clock framework sorts
the locking thing out.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/configs/mxs_defconfig |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index db2cb7d..f9a54a6 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -116,8 +116,6 @@ CONFIG_DEBUG_KERNEL=y
 CONFIG_LOCKUP_DETECTOR=y
 CONFIG_DETECT_HUNG_TASK=y
 CONFIG_TIMER_STATS=y
-CONFIG_PROVE_LOCKING=y
-CONFIG_DEBUG_SPINLOCK_SLEEP=y
 CONFIG_DEBUG_INFO=y
 CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_BLK_DEV_IO_TRACE=y
-- 
1.7.4.1
