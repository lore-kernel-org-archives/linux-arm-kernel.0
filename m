From: marex@denx.de (Marek Vasut)
Date: Fri,  3 Aug 2012 17:55:54 +0200
Subject: [PATCH] MXS: Fix mxs_defconfig MMAP_MIN_ADDR
Message-ID: <1344009354-13249-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initially reported by Detlev Zundel <dzu@denx.de>, this caused breakage
when "su - testuser" was called. "testuser" being a regular user account,
the command ended with SIGKILL.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/configs/mxs_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index ccdb635..f212802 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -34,7 +34,7 @@ CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
-CONFIG_DEFAULT_MMAP_MIN_ADDR=65536
+CONFIG_DEFAULT_MMAP_MIN_ADDR=32768
 CONFIG_AUTO_ZRELADDR=y
 CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
-- 
1.7.10.4
