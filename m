From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 17 Jul 2017 15:24:28 +0200
Subject: [PATCH v2] ARM: shmobile: Remove ARCH_SHMOBILE_MULTI
Message-ID: <1500297868-7479-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The migration from ARCH_SHMOBILE_MULTI to ARCH_RENESAS has been
completed in v4.12 by commit 9ed2d4bc5c0c244d ("ARM: dts: renesas:
Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS"), so the
ARCH_SHMOBILE_MULTI symbol can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Reference final commit.
---
 arch/arm/mach-shmobile/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ad7d604ff0013268..280e7312a9e1b300 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,9 +1,6 @@
 config ARCH_SHMOBILE
 	bool
 
-config ARCH_SHMOBILE_MULTI
-	bool
-
 config PM_RMOBILE
 	bool
 	select PM
@@ -34,7 +31,6 @@ menuconfig ARCH_RENESAS
 	depends on ARCH_MULTI_V7 && MMU
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_SHMOBILE
-	select ARCH_SHMOBILE_MULTI
 	select ARM_GIC
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
-- 
2.7.4
