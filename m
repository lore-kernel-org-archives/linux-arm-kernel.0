From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:35 +0100
Subject: [PATCH 17/21] ARM: S5PC1XX: enable S5PC110 sub-platform
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-18-git-send-email-m.szyprowski@samsung.com>
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
index c2238cd..d30057b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -798,6 +798,7 @@ source "arch/arm/plat-stmp3xxx/Kconfig"
 
 if ARCH_S5PC1XX
 source "arch/arm/mach-s5pc100/Kconfig"
+source "arch/arm/mach-s5pc110/Kconfig"
 endif
 
 source "arch/arm/mach-lh7a40x/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index f00d2d8..70d43d4 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -162,6 +162,7 @@ machine-$(CONFIG_ARCH_S3C2410)		:= s3c2410 s3c2400 s3c2412 s3c2440 s3c2442 s3c24
 machine-$(CONFIG_ARCH_S3C24A0)		:= s3c24a0
 machine-$(CONFIG_ARCH_S3C64XX)		:= s3c6400 s3c6410
 machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
+machine-$(CONFIG_ARCH_S5PC110)		:= s5pc110
 machine-$(CONFIG_ARCH_SA1100)		:= sa1100
 machine-$(CONFIG_ARCH_SHARK)		:= shark
 machine-$(CONFIG_ARCH_STMP378X)		:= stmp378x
diff --git a/arch/arm/plat-s5pc1xx/Kconfig b/arch/arm/plat-s5pc1xx/Kconfig
index 10c9130..09a572d 100644
--- a/arch/arm/plat-s5pc1xx/Kconfig
+++ b/arch/arm/plat-s5pc1xx/Kconfig
@@ -31,6 +31,9 @@ choice
 config ARCH_S5PC100
 	bool "S5PC100"
 
+config ARCH_S5PC110
+	bool "S5PC110"
+
 endchoice
 
 
-- 
1.6.4
