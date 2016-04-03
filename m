From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:27 +0900
Subject: [RFC PATCH 9/9] ARM: bcm: move mach-bcm/ to platforms/bcm/
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-10-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig                                       | 2 --
 arch/arm/Makefile                                      | 1 -
 arch/arm/platforms/Kconfig                             | 1 +
 arch/arm/platforms/Makefile                            | 1 +
 arch/arm/{mach-bcm => platforms/bcm}/Kconfig           | 0
 arch/arm/{mach-bcm => platforms/bcm}/Makefile          | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx.c         | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_pmb.c     | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.c     | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.h     | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_5301x.c       | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_cygnus.c      | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.c    | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.h    | 0
 arch/arm/{mach-bcm => platforms/bcm}/bcm_nsp.c         | 0
 arch/arm/{mach-bcm => platforms/bcm}/board_bcm21664.c  | 0
 arch/arm/{mach-bcm => platforms/bcm}/board_bcm281xx.c  | 0
 arch/arm/{mach-bcm => platforms/bcm}/board_bcm2835.c   | 0
 arch/arm/{mach-bcm => platforms/bcm}/brcmstb.c         | 0
 arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.c   | 0
 arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.h   | 0
 arch/arm/{mach-bcm => platforms/bcm}/platsmp-brcmstb.c | 0
 arch/arm/{mach-bcm => platforms/bcm}/platsmp.c         | 0
 23 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-bcm => platforms/bcm}/Kconfig (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/Makefile (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_pmb.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm63xx_smp.h (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_5301x.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_cygnus.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_kona_smc.h (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/bcm_nsp.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/board_bcm21664.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/board_bcm281xx.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/board_bcm2835.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/brcmstb.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/kona_l2_cache.h (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/platsmp-brcmstb.c (100%)
 rename arch/arm/{mach-bcm => platforms/bcm}/platsmp.c (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 443b125..adb0733 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -735,8 +735,6 @@ source "arch/arm/mach-at91/Kconfig"
 
 source "arch/arm/mach-axxia/Kconfig"
 
-source "arch/arm/mach-bcm/Kconfig"
-
 source "arch/arm/mach-berlin/Kconfig"
 
 source "arch/arm/mach-clps711x/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 33d031f..b51aefe 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -157,7 +157,6 @@ machine-$(CONFIG_ARCH_ALPINE)		+= alpine
 machine-$(CONFIG_ARCH_ARTPEC)		+= artpec
 machine-$(CONFIG_ARCH_AT91)		+= at91
 machine-$(CONFIG_ARCH_AXXIA)		+= axxia
-machine-$(CONFIG_ARCH_BCM)		+= bcm
 machine-$(CONFIG_ARCH_BERLIN)		+= berlin
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
index 8b3b93a..d2741c0 100644
--- a/arch/arm/platforms/Kconfig
+++ b/arch/arm/platforms/Kconfig
@@ -1,5 +1,6 @@
 # This is sorted alphabetically by directory pathname.
 
+source "arch/arm/platforms/bcm/Kconfig"
 source "arch/arm/platforms/highbank/Kconfig"
 source "arch/arm/platforms/mediatek/Kconfig"
 source "arch/arm/platforms/rockchip/Kconfig"
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
index 2bb3622..4fd91e1 100644
--- a/arch/arm/platforms/Makefile
+++ b/arch/arm/platforms/Makefile
@@ -1,5 +1,6 @@
 # This list sorted alphanumerically by CONFIG_* macro name.
 
+obj-$(CONFIG_ARCH_BCM)			+= bcm/
 obj-$(CONFIG_ARCH_HIGHBANK)		+= highbank/
 obj-$(CONFIG_ARCH_MEDIATEK)		+= mediatek/
 obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/platforms/bcm/Kconfig
similarity index 100%
rename from arch/arm/mach-bcm/Kconfig
rename to arch/arm/platforms/bcm/Kconfig
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/platforms/bcm/Makefile
similarity index 100%
rename from arch/arm/mach-bcm/Makefile
rename to arch/arm/platforms/bcm/Makefile
diff --git a/arch/arm/mach-bcm/bcm63xx.c b/arch/arm/platforms/bcm/bcm63xx.c
similarity index 100%
rename from arch/arm/mach-bcm/bcm63xx.c
rename to arch/arm/platforms/bcm/bcm63xx.c
diff --git a/arch/arm/mach-bcm/bcm63xx_pmb.c b/arch/arm/platforms/bcm/bcm63xx_pmb.c
similarity index 100%
rename from arch/arm/mach-bcm/bcm63xx_pmb.c
rename to arch/arm/platforms/bcm/bcm63xx_pmb.c
diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/platforms/bcm/bcm63xx_smp.c
similarity index 100%
rename from arch/arm/mach-bcm/bcm63xx_smp.c
rename to arch/arm/platforms/bcm/bcm63xx_smp.c
diff --git a/arch/arm/mach-bcm/bcm63xx_smp.h b/arch/arm/platforms/bcm/bcm63xx_smp.h
similarity index 100%
rename from arch/arm/mach-bcm/bcm63xx_smp.h
rename to arch/arm/platforms/bcm/bcm63xx_smp.h
diff --git a/arch/arm/mach-bcm/bcm_5301x.c b/arch/arm/platforms/bcm/bcm_5301x.c
similarity index 100%
rename from arch/arm/mach-bcm/bcm_5301x.c
rename to arch/arm/platforms/bcm/bcm_5301x.c
diff --git a/arch/arm/mach-bcm/bcm_cygnus.c b/arch/arm/platforms/bcm/bcm_cygnus.c
similarity index 100%
rename from arch/arm/mach-bcm/bcm_cygnus.c
rename to arch/arm/platforms/bcm/bcm_cygnus.c
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/platforms/bcm/bcm_kona_smc.c
similarity index 100%
rename from arch/arm/mach-bcm/bcm_kona_smc.c
rename to arch/arm/platforms/bcm/bcm_kona_smc.c
diff --git a/arch/arm/mach-bcm/bcm_kona_smc.h b/arch/arm/platforms/bcm/bcm_kona_smc.h
similarity index 100%
rename from arch/arm/mach-bcm/bcm_kona_smc.h
rename to arch/arm/platforms/bcm/bcm_kona_smc.h
diff --git a/arch/arm/mach-bcm/bcm_nsp.c b/arch/arm/platforms/bcm/bcm_nsp.c
similarity index 100%
rename from arch/arm/mach-bcm/bcm_nsp.c
rename to arch/arm/platforms/bcm/bcm_nsp.c
diff --git a/arch/arm/mach-bcm/board_bcm21664.c b/arch/arm/platforms/bcm/board_bcm21664.c
similarity index 100%
rename from arch/arm/mach-bcm/board_bcm21664.c
rename to arch/arm/platforms/bcm/board_bcm21664.c
diff --git a/arch/arm/mach-bcm/board_bcm281xx.c b/arch/arm/platforms/bcm/board_bcm281xx.c
similarity index 100%
rename from arch/arm/mach-bcm/board_bcm281xx.c
rename to arch/arm/platforms/bcm/board_bcm281xx.c
diff --git a/arch/arm/mach-bcm/board_bcm2835.c b/arch/arm/platforms/bcm/board_bcm2835.c
similarity index 100%
rename from arch/arm/mach-bcm/board_bcm2835.c
rename to arch/arm/platforms/bcm/board_bcm2835.c
diff --git a/arch/arm/mach-bcm/brcmstb.c b/arch/arm/platforms/bcm/brcmstb.c
similarity index 100%
rename from arch/arm/mach-bcm/brcmstb.c
rename to arch/arm/platforms/bcm/brcmstb.c
diff --git a/arch/arm/mach-bcm/kona_l2_cache.c b/arch/arm/platforms/bcm/kona_l2_cache.c
similarity index 100%
rename from arch/arm/mach-bcm/kona_l2_cache.c
rename to arch/arm/platforms/bcm/kona_l2_cache.c
diff --git a/arch/arm/mach-bcm/kona_l2_cache.h b/arch/arm/platforms/bcm/kona_l2_cache.h
similarity index 100%
rename from arch/arm/mach-bcm/kona_l2_cache.h
rename to arch/arm/platforms/bcm/kona_l2_cache.h
diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/platforms/bcm/platsmp-brcmstb.c
similarity index 100%
rename from arch/arm/mach-bcm/platsmp-brcmstb.c
rename to arch/arm/platforms/bcm/platsmp-brcmstb.c
diff --git a/arch/arm/mach-bcm/platsmp.c b/arch/arm/platforms/bcm/platsmp.c
similarity index 100%
rename from arch/arm/mach-bcm/platsmp.c
rename to arch/arm/platforms/bcm/platsmp.c
-- 
1.9.1
