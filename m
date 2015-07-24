From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 24 Jul 2015 17:41:59 +0900
Subject: [PATCH 2/2] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
In-Reply-To: <cover.1437725057.git.horms+renesas@verge.net.au>
References: <cover.1437725057.git.horms+renesas@verge.net.au>
Message-ID: <765b50030c218f65ee4ffd2eeb07045aa79fd5ee.1437725057.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Regulator setup seems identical to Koelsch.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Kconfig                     | 1 +
 arch/arm/mach-shmobile/Makefile                    | 1 +
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index c59d75eff7a4..429157d437f5 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -83,6 +83,7 @@ config ARCH_R8A7791
 config ARCH_R8A7793
 	bool "R-Car M2-N (R8A7793)"
 	select ARCH_RCAR_GEN2
+	select I2C
 
 config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e4b8fdbf6c96..def7a093d99c 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_ARCH_RCAR_GEN2)	+= setup-rcar-gen2.o platsmp-apmu.o $(cpu-y)
 CFLAGS_setup-rcar-gen2.o	+= -march=armv7-a
 obj-$(CONFIG_ARCH_R8A7790)	+= regulator-quirk-rcar-gen2.o
 obj-$(CONFIG_ARCH_R8A7791)	+= regulator-quirk-rcar-gen2.o
+obj-$(CONFIG_ARCH_R8A7793)	+= regulator-quirk-rcar-gen2.o
 
 # SMP objects
 smp-y				:= $(cpu-y)
diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 384e6e934b87..62437b57813e 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -123,7 +123,8 @@ static int __init rcar_gen2_regulator_quirk(void)
 	u32 mon;
 
 	if (!of_machine_is_compatible("renesas,koelsch") &&
-	    !of_machine_is_compatible("renesas,lager"))
+	    !of_machine_is_compatible("renesas,lager") &&
+	    !of_machine_is_compatible("renesas,gose"))
 		return -ENODEV;
 
 	irqc = ioremap(IRQC_BASE, PAGE_SIZE);
-- 
2.1.4
