From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Wed, 20 Apr 2016 10:57:28 -0500
Subject: [PATCH 1/3 v2] arm64: defconfig: cleanup the defconfig
Message-ID: <1461167848-3205-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When doing:
   make defconfig
   make savedefconfig

...without making any changes, the newly saved defconfig does
not match arch/arm64/configs/defconfig, and the diff looks
like:

$ diff defconfig arch/arm64/configs/defconfig
3a4
> CONFIG_FHANDLE=y

Clean that up by committing the output of savedefconfig.

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a44ef99..248c242 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1,7 +1,6 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
-CONFIG_FHANDLE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
-- 
1.9.0
