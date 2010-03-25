From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 14:10:52 +0530
Subject: [PATCH V2 Resend 09/12] ST SPEAr: Added support for SPEAr platform
	and machines in arch/arm/
In-Reply-To: <1269506455-15173-9-git-send-email-viresh.kumar@st.com>
References: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-2-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-3-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-4-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-5-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-6-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-7-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-8-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-9-git-send-email-viresh.kumar@st.com>
Message-ID: <1269506455-15173-10-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/Kconfig  |   13 +++++++++++++
 arch/arm/Makefile |    5 +++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c5408bf..1459231 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -801,6 +801,18 @@ config ARCH_OMAP
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
+config PLAT_SPEAR
+	bool "ST SPEAr"
+	select ARM_AMBA
+	select ARCH_REQUIRE_GPIOLIB
+	select COMMON_CLKDEV
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select GENERIC_TIME
+	select HAVE_CLK
+	help
+	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
+
 endchoice
 
 #
@@ -886,6 +898,7 @@ source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 source "arch/arm/plat-s5p/Kconfig"
 source "arch/arm/plat-s5pc1xx/Kconfig"
+source "arch/arm/plat-spear/Kconfig"
 
 if ARCH_S3C2410
 source "arch/arm/mach-s3c2400/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ed820e7..b3a3518 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -178,6 +178,10 @@ machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_ARCH_NUC93X)		:= nuc93x
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
+machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
+machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
+machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
+machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
@@ -192,6 +196,7 @@ plat-$(CONFIG_PLAT_PXA)		:= pxa
 plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx samsung
 plat-$(CONFIG_PLAT_S5PC1XX)	:= s5pc1xx samsung
 plat-$(CONFIG_PLAT_S5P)		:= s5p samsung
+plat-$(CONFIG_PLAT_SPEAR)	:= spear
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
 # This is what happens if you forget the IOCS16 line.
-- 
1.6.0.2
