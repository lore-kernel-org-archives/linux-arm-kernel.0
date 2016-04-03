From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  3 Apr 2016 23:39:24 +0900
Subject: [RFC PATCH 6/9] ARM: rockchip: move mach-rockchip/ to
 platforms/rockchip/
In-Reply-To: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
References: <1459694367-18635-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1459694367-18635-7-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/Kconfig                                          | 2 --
 arch/arm/Makefile                                         | 1 -
 arch/arm/platforms/Kconfig                                | 1 +
 arch/arm/platforms/Makefile                               | 1 +
 arch/arm/{mach-rockchip => platforms/rockchip}/Kconfig    | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/Makefile   | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/core.h     | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/headsmp.S  | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/platsmp.c  | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/pm.c       | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/pm.h       | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/rockchip.c | 0
 arch/arm/{mach-rockchip => platforms/rockchip}/sleep.S    | 0
 13 files changed, 2 insertions(+), 3 deletions(-)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/Kconfig (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/Makefile (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/core.h (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/headsmp.S (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/platsmp.c (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/pm.c (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/pm.h (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/rockchip.c (100%)
 rename arch/arm/{mach-rockchip => platforms/rockchip}/sleep.S (100%)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ce9ba91..51e2663 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -810,8 +810,6 @@ source "arch/arm/mach-qcom/Kconfig"
 
 source "arch/arm/mach-realview/Kconfig"
 
-source "arch/arm/mach-rockchip/Kconfig"
-
 source "arch/arm/mach-sa1100/Kconfig"
 
 source "arch/arm/mach-spear/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 9850f92..923be10 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -199,7 +199,6 @@ machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
-machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
 machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx
 machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
diff --git a/arch/arm/platforms/Kconfig b/arch/arm/platforms/Kconfig
index 18a1e85..ce6ed8a 100644
--- a/arch/arm/platforms/Kconfig
+++ b/arch/arm/platforms/Kconfig
@@ -1,5 +1,6 @@
 # This is sorted alphabetically by directory pathname.
 
+source "arch/arm/platforms/rockchip/Kconfig"
 source "arch/arm/platforms/socfpga/Kconfig"
 source "arch/arm/platforms/sunxi/Kconfig"
 source "arch/arm/platforms/uniphier/Kconfig"
diff --git a/arch/arm/platforms/Makefile b/arch/arm/platforms/Makefile
index e37786d..bf88c66e 100644
--- a/arch/arm/platforms/Makefile
+++ b/arch/arm/platforms/Makefile
@@ -1,5 +1,6 @@
 # This list sorted alphanumerically by CONFIG_* macro name.
 
+obj-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip/
 obj-$(CONFIG_ARCH_SOCFPGA)		+= socfpga/
 obj-$(CONFIG_ARCH_SUNXI)		+= sunxi/
 obj-$(CONFIG_ARCH_UNIPHIER)		+= uniphier/
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/platforms/rockchip/Kconfig
similarity index 100%
rename from arch/arm/mach-rockchip/Kconfig
rename to arch/arm/platforms/rockchip/Kconfig
diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/platforms/rockchip/Makefile
similarity index 100%
rename from arch/arm/mach-rockchip/Makefile
rename to arch/arm/platforms/rockchip/Makefile
diff --git a/arch/arm/mach-rockchip/core.h b/arch/arm/platforms/rockchip/core.h
similarity index 100%
rename from arch/arm/mach-rockchip/core.h
rename to arch/arm/platforms/rockchip/core.h
diff --git a/arch/arm/mach-rockchip/headsmp.S b/arch/arm/platforms/rockchip/headsmp.S
similarity index 100%
rename from arch/arm/mach-rockchip/headsmp.S
rename to arch/arm/platforms/rockchip/headsmp.S
diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/platforms/rockchip/platsmp.c
similarity index 100%
rename from arch/arm/mach-rockchip/platsmp.c
rename to arch/arm/platforms/rockchip/platsmp.c
diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/platforms/rockchip/pm.c
similarity index 100%
rename from arch/arm/mach-rockchip/pm.c
rename to arch/arm/platforms/rockchip/pm.c
diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/platforms/rockchip/pm.h
similarity index 100%
rename from arch/arm/mach-rockchip/pm.h
rename to arch/arm/platforms/rockchip/pm.h
diff --git a/arch/arm/mach-rockchip/rockchip.c b/arch/arm/platforms/rockchip/rockchip.c
similarity index 100%
rename from arch/arm/mach-rockchip/rockchip.c
rename to arch/arm/platforms/rockchip/rockchip.c
diff --git a/arch/arm/mach-rockchip/sleep.S b/arch/arm/platforms/rockchip/sleep.S
similarity index 100%
rename from arch/arm/mach-rockchip/sleep.S
rename to arch/arm/platforms/rockchip/sleep.S
-- 
1.9.1
