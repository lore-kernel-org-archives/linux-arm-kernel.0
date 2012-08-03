From: marex@denx.de (Marek Vasut)
Date: Fri,  3 Aug 2012 20:54:48 +0200
Subject: [PATCH V2] MXS: Remove MMAP_MIN_ADDR setting from mxs_defconfig
Message-ID: <1344020088-8156-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CONFIG_DEFAULT_MMAP_MIN_ADDR was set to 65536 in mxs_defconfig,
this caused severe breakage of userland applications since the upper
limit for ARM is 32768. By default CONFIG_DEFAULT_MMAP_MIN_ADDR is
set to 4096 and can also be changed via /proc/sys/vm/mmap_min_addr
if needed.

Quoting Russell King [1]:

"4096 is also fine for ARM too. There's not much point in having
defconfigs change it - that would just be pure noise in the config
files."

the CONFIG_DEFAULT_MMAP_MIN_ADDR can be removed from the defconfig
altogether.

This problem was introduced by:

commit cde7c41feaa06cb6bfc748b2fc3c7d809091c2b0
Author: Wolfram Sang <w.sang@pengutronix.de>
Date:   Fri Apr 29 15:06:40 2011 +0200

    ARM: configs: add defconfig for mach-mxs

[1] http://marc.info/?l=linux-arm-kernel&m=134401593807820&w=2

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/configs/mxs_defconfig |    1 -
 1 file changed, 1 deletion(-)

V2: Remove the setting altogether
    Update description

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index ccdb635..4edcfb4 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -34,7 +34,6 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
-CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
 CONFIG_AUTO_ZRELADDR=y
 CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
-- 
1.7.10.4
