From: ludovic.Barre@st.com (Ludovic Barre)
Date: Tue, 2 Jan 2018 16:01:45 +0100
Subject: [PATCH v3 1/7] Documentation: arm: stm32: move to rst format
In-Reply-To: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
References: <1514905311-12925-1-git-send-email-ludovic.Barre@st.com>
Message-ID: <1514905311-12925-2-git-send-email-ludovic.Barre@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch rewrites stm32 documentation to rst
(ReStructuredText) format.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/arm/stm32/overview.rst           | 31 +++++++++++++++++++++++
 Documentation/arm/stm32/overview.txt           | 33 -------------------------
 Documentation/arm/stm32/stm32f429-overview.rst | 26 ++++++++++++++++++++
 Documentation/arm/stm32/stm32f429-overview.txt | 22 -----------------
 Documentation/arm/stm32/stm32f746-overview.rst | 33 +++++++++++++++++++++++++
 Documentation/arm/stm32/stm32f746-overview.txt | 34 --------------------------
 Documentation/arm/stm32/stm32h743-overview.rst | 34 ++++++++++++++++++++++++++
 Documentation/arm/stm32/stm32h743-overview.txt | 30 -----------------------
 8 files changed, 124 insertions(+), 119 deletions(-)
 create mode 100644 Documentation/arm/stm32/overview.rst
 delete mode 100644 Documentation/arm/stm32/overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f429-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32f429-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32f746-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32f746-overview.txt
 create mode 100644 Documentation/arm/stm32/stm32h743-overview.rst
 delete mode 100644 Documentation/arm/stm32/stm32h743-overview.txt

diff --git a/Documentation/arm/stm32/overview.rst b/Documentation/arm/stm32/overview.rst
new file mode 100644
index 0000000..6be6059
--- /dev/null
+++ b/Documentation/arm/stm32/overview.rst
@@ -0,0 +1,31 @@
+========================
+STM32 ARM Linux Overview
+========================
+
+Introduction
+------------
+
+The STMicroelectronics family of Cortex-M based MCUs are supported by the
+'STM32' platform of ARM Linux. Currently only the STM32F429 (Cortex-M4)
+and STM32F746 (Cortex-M7) are supported.
+
+Configuration
+-------------
+
+A generic configuration is provided for STM32 family, and can be used as the
+default by
+        make stm32_defconfig
+
+Layout
+------
+
+All the files for multiple machine families are located in the platform code
+contained in arch/arm/mach-stm32
+
+There is a generic board board-dt.c in the mach folder which support
+Flattened Device Tree, which means, it works with any compatible board with
+Device Trees.
+
+:Authors:
+
+Maxime Coquelin <mcoquelin.stm32@gmail.com>
diff --git a/Documentation/arm/stm32/overview.txt b/Documentation/arm/stm32/overview.txt
deleted file mode 100644
index a03b035..0000000
--- a/Documentation/arm/stm32/overview.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-			STM32 ARM Linux Overview
-			========================
-
-Introduction
-------------
-
-  The STMicroelectronics family of Cortex-M based MCUs are supported by the
-  'STM32' platform of ARM Linux. Currently only the STM32F429 (Cortex-M4)
-  and STM32F746 (Cortex-M7) are supported.
-
-
-Configuration
--------------
-
-  A generic configuration is provided for STM32 family, and can be used as the
-  default by
-	make stm32_defconfig
-
-Layout
-------
-
-  All the files for multiple machine families are located in the platform code
-  contained in arch/arm/mach-stm32
-
-  There is a generic board board-dt.c in the mach folder which support
-  Flattened Device Tree, which means, it works with any compatible board with
-  Device Trees.
-
-
-Document Author
----------------
-
-  Maxime Coquelin <mcoquelin.stm32@gmail.com>
diff --git a/Documentation/arm/stm32/stm32f429-overview.rst b/Documentation/arm/stm32/stm32f429-overview.rst
new file mode 100644
index 0000000..18feda9
--- /dev/null
+++ b/Documentation/arm/stm32/stm32f429-overview.rst
@@ -0,0 +1,26 @@
+STM32F429 Overview
+==================
+
+Introduction
+------------
+
+The STM32F429 is a Cortex-M4 MCU aimed at various applications.
+It features:
+
+- ARM Cortex-M4 up to 180MHz with FPU
+- 2MB internal Flash Memory
+- External memory support through FMC controller (PSRAM, SDRAM, NOR, NAND)
+- I2C, SPI, SAI, CAN, USB OTG, Ethernet controllers
+- LCD controller & Camera interface
+- Cryptographic processor
+
+Resources
+---------
+
+Datasheet and reference manual are publicly available on ST website (STM32F429_).
+
+.. _STM32F429: http://www.st.com/web/en/catalog/mmc/FM141/SC1169/SS1577/LN1806?ecmp=stm32f429-439_pron_pr-ces2014_nov2013
+
+:Authors:
+
+Maxime Coquelin <mcoquelin.stm32@gmail.com>
diff --git a/Documentation/arm/stm32/stm32f429-overview.txt b/Documentation/arm/stm32/stm32f429-overview.txt
deleted file mode 100644
index 5206822..0000000
--- a/Documentation/arm/stm32/stm32f429-overview.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-			STM32F429 Overview
-			==================
-
-  Introduction
-  ------------
-	The STM32F429 is a Cortex-M4 MCU aimed at various applications.
-	It features:
-	- ARM Cortex-M4 up to 180MHz with FPU
-	- 2MB internal Flash Memory
-	- External memory support through FMC controller (PSRAM, SDRAM, NOR, NAND)
-	- I2C, SPI, SAI, CAN, USB OTG, Ethernet controllers
-	- LCD controller & Camera interface
-	- Cryptographic processor
-
-  Resources
-  ---------
-	Datasheet and reference manual are publicly available on ST website:
-	- http://www.st.com/web/en/catalog/mmc/FM141/SC1169/SS1577/LN1806?ecmp=stm32f429-439_pron_pr-ces2014_nov2013
-
-  Document Author
-  ---------------
-	Maxime Coquelin <mcoquelin.stm32@gmail.com>
diff --git a/Documentation/arm/stm32/stm32f746-overview.rst b/Documentation/arm/stm32/stm32f746-overview.rst
new file mode 100644
index 0000000..b5f4b6c
--- /dev/null
+++ b/Documentation/arm/stm32/stm32f746-overview.rst
@@ -0,0 +1,33 @@
+STM32F746 Overview
+==================
+
+Introduction
+------------
+
+The STM32F746 is a Cortex-M7 MCU aimed at various applications.
+It features:
+
+- Cortex-M7 core running up to @216MHz
+- 1MB internal flash, 320KBytes internal RAM (+4KB of backup SRAM)
+- FMC controller to connect SDRAM, NOR and NAND memories
+- Dual mode QSPI
+- SD/MMC/SDIO support
+- Ethernet controller
+- USB OTFG FS & HS controllers
+- I2C, SPI, CAN busses support
+- Several 16 & 32 bits general purpose timers
+- Serial Audio interface
+- LCD controller
+- HDMI-CEC
+- SPDIFRX
+
+Resources
+---------
+
+Datasheet and reference manual are publicly available on ST website (STM32F746_).
+
+.. _STM32F746: http://www.st.com/content/st_com/en/products/microcontrollers/stm32-32-bit-arm-cortex-mcus/stm32f7-series/stm32f7x6/stm32f746ng.html
+
+:Authors:
+
+Alexandre Torgue <alexandre.torgue@st.com>
diff --git a/Documentation/arm/stm32/stm32f746-overview.txt b/Documentation/arm/stm32/stm32f746-overview.txt
deleted file mode 100644
index cffd2b1c..0000000
--- a/Documentation/arm/stm32/stm32f746-overview.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-			STM32F746 Overview
-			==================
-
-  Introduction
-  ------------
-	The STM32F746 is a Cortex-M7 MCU aimed at various applications.
-	It features:
-	- Cortex-M7 core running up to @216MHz
-	- 1MB internal flash, 320KBytes internal RAM (+4KB of backup SRAM)
-	- FMC controller to connect SDRAM, NOR and NAND memories
-	- Dual mode QSPI
-	- SD/MMC/SDIO support
-	- Ethernet controller
-	- USB OTFG FS & HS controllers
-	- I2C, SPI, CAN busses support
-	- Several 16 & 32 bits general purpose timers
-	- Serial Audio interface
-	- LCD controller
-	- HDMI-CEC
-	- SPDIFRX
-
-  Resources
-  ---------
-	Datasheet and reference manual are publicly available on ST website:
-	- http://www.st.com/content/st_com/en/products/microcontrollers/stm32-32-bit-arm-cortex-mcus/stm32f7-series/stm32f7x6/stm32f746ng.html
-
-  Document Author
-  ---------------
-	Alexandre Torgue <alexandre.torgue@st.com>
-
-
-
-
-
diff --git a/Documentation/arm/stm32/stm32h743-overview.rst b/Documentation/arm/stm32/stm32h743-overview.rst
new file mode 100644
index 0000000..3458dc0
--- /dev/null
+++ b/Documentation/arm/stm32/stm32h743-overview.rst
@@ -0,0 +1,34 @@
+STM32H743 Overview
+==================
+
+Introduction
+------------
+
+The STM32H743 is a Cortex-M7 MCU aimed at various applications.
+It features:
+
+- Cortex-M7 core running up to @400MHz
+- 2MB internal flash, 1MBytes internal RAM
+- FMC controller to connect SDRAM, NOR and NAND memories
+- Dual mode QSPI
+- SD/MMC/SDIO support
+- Ethernet controller
+- USB OTFG FS & HS controllers
+- I2C, SPI, CAN busses support
+- Several 16 & 32 bits general purpose timers
+- Serial Audio interface
+- LCD controller
+- HDMI-CEC
+- SPDIFRX
+- DFSDM
+
+Resources
+---------
+
+Datasheet and reference manual are publicly available on ST website (STM32H743_).
+
+.. _STM32H743: http://www.st.com/en/microcontrollers/stm32h7x3.html?querycriteria=productId=LN2033
+
+:Authors:
+
+Alexandre Torgue <alexandre.torgue@st.com>
diff --git a/Documentation/arm/stm32/stm32h743-overview.txt b/Documentation/arm/stm32/stm32h743-overview.txt
deleted file mode 100644
index 3031cba..0000000
--- a/Documentation/arm/stm32/stm32h743-overview.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-			STM32H743 Overview
-			==================
-
-  Introduction
-  ------------
-	The STM32H743 is a Cortex-M7 MCU aimed at various applications.
-	It features:
-	- Cortex-M7 core running up to @400MHz
-	- 2MB internal flash, 1MBytes internal RAM
-	- FMC controller to connect SDRAM, NOR and NAND memories
-	- Dual mode QSPI
-	- SD/MMC/SDIO support
-	- Ethernet controller
-	- USB OTFG FS & HS controllers
-	- I2C, SPI, CAN busses support
-	- Several 16 & 32 bits general purpose timers
-	- Serial Audio interface
-	- LCD controller
-	- HDMI-CEC
-	- SPDIFRX
-	- DFSDM
-
-  Resources
-  ---------
-	Datasheet and reference manual are publicly available on ST website:
-	- http://www.st.com/en/microcontrollers/stm32h7x3.html?querycriteria=productId=LN2033
-
-  Document Author
-  ---------------
-	Alexandre Torgue <alexandre.torgue@st.com>
-- 
2.7.4
