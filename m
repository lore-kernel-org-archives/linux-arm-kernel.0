From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Oct 2012 21:09:31 +0000
Subject: [PATCH] ARM: versatile: fix versatile_defconfig
Message-ID: <201210262109.31794.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the introduction of CONFIG_ARCH_MULTIPLATFORM, versatile is
no longer the default platform, so we need to enable
CONFIG_ARCH_VERSATILE explicitly in order for that to be selected
rather than the multiplatform configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

I've applied this to the arm-soc fixes branch, since it seems obvious
and uncontroversial. I only noticed because of another unrelated bug.

diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index cdd4d2b..2ba9e63 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -1,3 +1,4 @@
+CONFIG_ARCH_VERSATILE=y
 CONFIG_EXPERIMENTAL=y
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
