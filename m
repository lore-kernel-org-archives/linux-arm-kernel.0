From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 30 Aug 2010 16:08:40 +0530
Subject: [PATCH 09/74] ST SPEAr: Adding information in Documentation/ and
	MAINTAINERS
In-Reply-To: <cover.1283161023.git.viresh.kumar@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
Message-ID: <09499075f7a7177877c7038937079c48dbd4fe95.1283161023.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 Documentation/arm/SPEAr/overview.txt |   33 +++++++++++++++++++++++----------
 MAINTAINERS                          |    6 ++++++
 2 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/Documentation/arm/SPEAr/overview.txt b/Documentation/arm/SPEAr/overview.txt
index 253a35c..0e91cbf 100644
--- a/Documentation/arm/SPEAr/overview.txt
+++ b/Documentation/arm/SPEAr/overview.txt
@@ -9,8 +9,9 @@ Introduction
 
   The ST Microelectronics SPEAr range of ARM9/CortexA9 System-on-Chip CPUs are
   supported by the 'spear' platform of ARM Linux. Currently SPEAr300,
-  SPEAr310, SPEAr320 and SPEAr600 SOCs are supported. Support for the SPEAr13XX
-  series is in progress.
+  SPEAr310, SPEAr320, SPEAr600 and SPEAr1300 SOCs are supported.
+  SPEAr3XX and SPEAr6XX are based on ARM9 whereas SPEAr13XX is based on latest
+  ARM Cortex A9 CPUs.
 
   Hierarchy in SPEAr is as follows:
 
@@ -27,16 +28,26 @@ Introduction
 			- SPEAr600_EVB (Evaluation Board)
 	- SPEAr13XX (13XX SOC series, based on ARM CORTEXA9)
 		- SPEAr1300 (SOC)
+			- SPEAr1300_EVB (Evaluation Board)
 
   Configuration
   -------------
 
   A generic configuration is provided for each machine, and can be used as the
   default by
-	make spear600_defconfig
-	make spear300_defconfig
-	make spear310_defconfig
-	make spear320_defconfig
+	#make ARCH=arm spear600_defconfig
+	#make ARCH=arm spear300_defconfig
+	#make ARCH=arm spear310_defconfig
+	#make ARCH=arm spear320_defconfig
+	#make ARCH=arm spear1300_defconfig
+	#make ARCH=arm spear1300-smp_defconfig (for SMP based configuration)
+
+  Compilation
+  -----------
+
+  After applying default configuration, Linux kernel for SPEAr architecture
+  can be compiled as
+	#make ARCH=arm CROSS_COMPILE=arm-linux- uImage
 
   Layout
   ------
@@ -48,13 +59,15 @@ Introduction
   Each machine series have a directory with name arch/arm/mach-spear followed by
   series name. Like mach-spear3xx, mach-spear6xx and mach-spear13xx.
 
-  Common file for machines of spear3xx family is mach-spear3xx/spear3xx.c and for
-  spear6xx is mach-spear6xx/spear6xx.c. mach-spear* also contain soc/machine
+  Common file for machines of spear3xx family is mach-spear3xx/spear3xx.c, for
+  spear6xx is mach-spear6xx/spear6xx.c and similarly for spear13xx is
+  mach-spear13xx/spear13xx.c. mach-spear* also contain soc/machine
   specific files, like spear300.c, spear310.c, spear320.c and spear600.c.
-  mach-spear* also contains board specific files for each machine type.
+  Board specific files for each machine type is also contained in mach-spear*
+  folder.
 
 
   Document Author
   ---------------
 
-  Viresh Kumar, (c) 2010 ST Microelectronics
+  Viresh Kumar, Shiraz Hashim (c) 2010 ST Microelectronics
diff --git a/MAINTAINERS b/MAINTAINERS
index a1df54b..257e396 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5434,6 +5434,12 @@ W:	http://www.st.com/spear
 S:	Maintained
 F:	arch/arm/plat-spear/
 
+SPEAR13XX MACHINE SUPPORT
+M:	Shiraz Hashim <shiraz.hashim@st.com>
+W:	http://www.st.com/spear
+S:	Maintained
+F:	arch/arm/mach-spear13xx/
+
 SPEAR3XX MACHINE SUPPORT
 M:	Viresh Kumar <viresh.kumar@st.com>
 W:	http://www.st.com/spear
-- 
1.7.2.2
