From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 18 Nov 2009 14:33:11 +0100
Subject: [PATCH 16/19] ARM: S5PC1XX: enable S5PC110 sub-platform
In-Reply-To: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
References: <1258551194-16018-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1258551194-16018-17-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch enables S5PC110 sub-platform.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

---
 arch/arm/Kconfig              |    1 +
 arch/arm/Makefile             |    1 +
 arch/arm/plat-s5pc1xx/Kconfig |    3 +++
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..280c38e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -770,6 +770,7 @@ source "arch/arm/plat-stmp3xxx/Kconfig"
 
 if ARCH_S5PC1XX
 source "arch/arm/mach-s5pc100/Kconfig"
+source "arch/arm/mach-s5pc110/Kconfig"
 endif
 
 source "arch/arm/mach-lh7a40x/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index daea150..d9daa45 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -161,6 +161,7 @@ machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c24
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
+machine-$(CONFIG_ARCH_S5PC110)		:= s5pc110
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 898cd82..137371f 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -30,6 +30,9 @@ choice
 config ARCH_S5PC100
 	bool "S5PC100"
 
+config ARCH_S5PC110
+	bool "S5PC110"
+
 endchoice
 
 
-- 
1.6.4
