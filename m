From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Wed, 21 Nov 2018 21:30:36 +0300
Subject: [RFC PATCH v3 03/17] ARM: sunxi: add Allwinner ARMv5 SoCs
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Message-ID: <731846a31ad2c602ca4fcf1c417deace60c625b8.1542824904.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add option for Allwinner ARMv5 SoCs and SoC F1C100s (which has a die
used for many new F-series products, including F1C100A, F1C100s, F1C200s,
F1C500, F1C600).

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 16 +++++++++++++++-
 arch/arm/mach-sunxi/sunxi.c | 10 ++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 7e5f173..23dffbd 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,6 +1,6 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
-	depends on ARCH_MULTI_V7
+	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
@@ -64,4 +64,18 @@ config ARCH_SUNXI_MC_SMP
 
 endif
 
+if ARCH_MULTI_V5
+
+config ARCH_SUNXI_V5
+	bool
+
+config MACH_SUNIV
+	bool "Allwinner ARMv5 F-series (suniv) SoCs support"
+	select ARCH_SUNXI_V5
+	help
+	  Support for Allwinner suniv ARMv5 SoCs. 
+	  (F1C100A, F1C100s, F1C200s, F1C500, F1C600) 
+
+endif
+
 endif
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index de4b0e9..155cd9e 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -101,3 +101,13 @@ static const char * const sun9i_board_dt_compat[] = {
 DT_MACHINE_START(SUN9I_DT, "Allwinner sun9i Family")
 	.dt_compat	= sun9i_board_dt_compat,
 MACHINE_END
+
+static const char * const suniv_board_dt_compat[] = {
+	"allwinner,suniv-f1c100s",
+	NULL,
+};
+
+DT_MACHINE_START(SUNIV_DT, "Allwinner suniv Family")
+	.dt_compat	= suniv_board_dt_compat,
+MACHINE_END
+
-- 
2.7.4
