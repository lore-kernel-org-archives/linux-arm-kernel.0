From: alexandre.torgue@st.com (Alexandre TORGUE)
Date: Wed, 26 Oct 2016 17:11:19 +0200
Subject: [PATCH 1/5] ARM: mach-stm32: Add a new SOC - STM32F746
In-Reply-To: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
References: <1477494683-29890-1-git-send-email-alexandre.torgue@st.com>
Message-ID: <1477494683-29890-2-git-send-email-alexandre.torgue@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

diff --git a/Documentation/arm/stm32/overview.txt b/Documentation/arm/stm32/overview.txt
index 09aed55..a03b035 100644
--- a/Documentation/arm/stm32/overview.txt
+++ b/Documentation/arm/stm32/overview.txt
@@ -5,7 +5,8 @@ Introduction
 ------------
 
   The STMicroelectronics family of Cortex-M based MCUs are supported by the
-  'STM32' platform of ARM Linux. Currently only the STM32F429 is supported.
+  'STM32' platform of ARM Linux. Currently only the STM32F429 (Cortex-M4)
+  and STM32F746 (Cortex-M7) are supported.
 
 
 Configuration
diff --git a/Documentation/arm/stm32/stm32f746-overview.txt b/Documentation/arm/stm32/stm32f746-overview.txt
new file mode 100644
index 0000000..cffd2b1
--- /dev/null
+++ b/Documentation/arm/stm32/stm32f746-overview.txt
@@ -0,0 +1,34 @@
+			STM32F746 Overview
+			==================
+
+  Introduction
+  ------------
+	The STM32F746 is a Cortex-M7 MCU aimed at various applications.
+	It features:
+	- Cortex-M7 core running up to @216MHz
+	- 1MB internal flash, 320KBytes internal RAM (+4KB of backup SRAM)
+	- FMC controller to connect SDRAM, NOR and NAND memories
+	- Dual mode QSPI
+	- SD/MMC/SDIO support
+	- Ethernet controller
+	- USB OTFG FS & HS controllers
+	- I2C, SPI, CAN busses support
+	- Several 16 & 32 bits general purpose timers
+	- Serial Audio interface
+	- LCD controller
+	- HDMI-CEC
+	- SPDIFRX
+
+  Resources
+  ---------
+	Datasheet and reference manual are publicly available on ST website:
+	- http://www.st.com/content/st_com/en/products/microcontrollers/stm32-32-bit-arm-cortex-mcus/stm32f7-series/stm32f7x6/stm32f746ng.html
+
+  Document Author
+  ---------------
+	Alexandre Torgue <alexandre.torgue@st.com>
+
+
+
+
+
diff --git a/arch/arm/mach-stm32/board-dt.c b/arch/arm/mach-stm32/board-dt.c
index ceee477..c354222 100644
--- a/arch/arm/mach-stm32/board-dt.c
+++ b/arch/arm/mach-stm32/board-dt.c
@@ -11,6 +11,7 @@
 static const char *const stm32_compat[] __initconst = {
 	"st,stm32f429",
 	"st,stm32f469",
+	"st,stm32f746",
 	NULL
 };
 
-- 
1.9.1
