From: gabriel.fernandez@st.com (gabriel.fernandez at st.com)
Date: Tue, 17 Apr 2018 11:15:19 +0200
Subject: [PATCH] clk: stm32: fix: stm32 clock drivers are not compiled by
 default
Message-ID: <1523956519-20976-1-git-send-email-gabriel.fernandez@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Clock driver is mandatory if the machine is selected.
Then don't use 'bool' and 'depends on' commands, but 'def_bool'
with the machine(s).

Fixes: da32d3539fca ("clk: stm32: add configuration flags for each of the stm32 drivers")


Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/clk/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 41492e9..34968a3 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -266,15 +266,13 @@ config COMMON_CLK_STM32MP157
 	  Support for stm32mp157 SoC family clocks
 
 config COMMON_CLK_STM32F
-	bool "Clock driver for stm32f4 and stm32f7 SoC families"
-	depends on MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746
+	def_bool COMMON_CLK && (MACH_STM32F429 || MACH_STM32F469 || MACH_STM32F746)
 	help
 	---help---
 	  Support for stm32f4 and stm32f7 SoC families clocks
 
 config COMMON_CLK_STM32H7
-	bool "Clock driver for stm32h7 SoC family"
-	depends on MACH_STM32H743
+	def_bool COMMON_CLK && MACH_STM32H743
 	help
 	---help---
 	  Support for stm32h7 SoC family clocks
-- 
1.9.1
