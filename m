From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 11 Jan 2013 16:17:03 +0900
Subject: [PATCH 2/5] ARM: mach-shmobile: fix memory size for kota2_defconfig
In-Reply-To: <1357888626-4946-1-git-send-email-horms+renesas@verge.net.au>
References: <1357888626-4946-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1357888626-4946-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CONFIG_MEMORY_SIZE value is interpreted as a 32 bit integer, which
makes sense on a system without PAE. It appears that a trailing 0 was
appended to the value and after some testing it appears that 0x1e000000 is
the correct value.

Without this patch, building kota2_defconfig results in:

/home/arnd/linux-arm/arch/arm/kernel/setup.c:790:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]

Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/kota2_defconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/kota2_defconfig b/arch/arm/configs/kota2_defconfig
index fa83db1..57ad3d4 100644
--- a/arch/arm/configs/kota2_defconfig
+++ b/arch/arm/configs/kota2_defconfig
@@ -21,7 +21,7 @@ CONFIG_ARCH_SHMOBILE=y
 CONFIG_KEYBOARD_GPIO_POLLED=y
 CONFIG_ARCH_SH73A0=y
 CONFIG_MACH_KOTA2=y
-CONFIG_MEMORY_SIZE=0x1e0000000
+CONFIG_MEMORY_SIZE=0x1e000000
 # CONFIG_SH_TIMER_TMU is not set
 # CONFIG_SWP_EMULATE is not set
 CONFIG_CPU_BPREDICT_DISABLE=y
-- 
1.7.10.4
