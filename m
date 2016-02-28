From: vishnupatekar0510@gmail.com (Vishnu Patekar)
Date: Sun, 28 Feb 2016 23:18:58 +0800
Subject: [PATCH v2 13/13] ARM: sunxi: Introduce MACH_SUN8I_A83T option
In-Reply-To: <1456672738-4993-1-git-send-email-vishnupatekar0510@gmail.com>
References: <1456672738-4993-1-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <1456672738-4993-14-git-send-email-vishnupatekar0510@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A83T has CPUS clock similar to A80's. currently, a80 cpus clock only
compiled for A80. So, Introduce MACH_SUN8I_A83T to compile it for
A83T as well.

Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 5 +++++
 drivers/clk/sunxi/Makefile  | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index c124d65..424b76d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -41,6 +41,11 @@ config MACH_SUN8I
 	select ARM_GIC
 	select MFD_SUN6I_PRCM
 
+config MACH_SUN8I_A83T
+	bool "Allwinner A83T (sun8i) SoCs support"
+	default ARCH_SUNXI
+	select ARM_GIC
+
 config MACH_SUN9I
 	bool "Allwinner (sun9i) SoCs support"
 	default ARCH_SUNXI
diff --git a/drivers/clk/sunxi/Makefile b/drivers/clk/sunxi/Makefile
index 3fd7901..2aabfc4 100644
--- a/drivers/clk/sunxi/Makefile
+++ b/drivers/clk/sunxi/Makefile
@@ -20,6 +20,9 @@ obj-y += clk-usb.o
 obj-$(CONFIG_MACH_SUN9I) += clk-sun8i-apb0.o
 obj-$(CONFIG_MACH_SUN9I) += clk-sun9i-cpus.o
 
+obj-$(CONFIG_MACH_SUN8I_A83T) += clk-sun8i-apb0.o
+obj-$(CONFIG_MACH_SUN8I_A83T) += clk-sun9i-cpus.o
+
 obj-$(CONFIG_MFD_SUN6I_PRCM) += \
 	clk-sun6i-ar100.o clk-sun6i-apb0.o clk-sun6i-apb0-gates.o \
 	clk-sun8i-apb0.o
-- 
1.9.1
