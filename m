From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu,  9 Feb 2017 11:18:49 +0100
Subject: [PATCH 2/2] ARM: shmobile: Remove ARCH_SHMOBILE_MULTI
In-Reply-To: <1486635529-6636-1-git-send-email-geert+renesas@glider.be>
References: <1486635529-6636-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1486635529-6636-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The migration from ARCH_SHMOBILE_MULTI to ARCH_RENESAS started by commit
9b5ba0df4ea4 ("ARM: shmobile: Introduce ARCH_RENESAS") has been
completed, so the ARCH_SHMOBILE_MULTI symbol can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2bb4b09f079e2e64..ce2aee1481dfb98e 100644
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
1.9.1
