From: viresh.linux@gmail.com (Viresh Kumar)
Date: Fri, 20 Apr 2012 22:52:49 +0530
Subject: [PATCH 9/9] SPEAr: Update MAINTAINERS and Documentation
In-Reply-To: <cover.1334942163.git.viresh.kumar@st.com>
References: <cover.1334942163.git.viresh.kumar@st.com>
Message-ID: <d4b986d5387474e0dbf79243fd8d491eb72d159a.1334942163.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates MAINTAINERS files, makes shiraz as second Maintainer for
SPEAr SoCs.

It also updates Documentation mostly for SPEAr13xx.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 Documentation/arm/SPEAr/overview.txt            |   32 ++++++++++++----------
 Documentation/devicetree/bindings/arm/spear.txt |   14 +++++-----
 MAINTAINERS                                     |   13 +++++++++
 3 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/Documentation/arm/SPEAr/overview.txt b/Documentation/arm/SPEAr/overview.txt
index 28a9af9..57aae77 100644
--- a/Documentation/arm/SPEAr/overview.txt
+++ b/Documentation/arm/SPEAr/overview.txt
@@ -8,9 +8,8 @@ Introduction
   weblink : http://www.st.com/spear
 
   The ST Microelectronics SPEAr range of ARM9/CortexA9 System-on-Chip CPUs are
-  supported by the 'spear' platform of ARM Linux. Currently SPEAr300,
-  SPEAr310, SPEAr320 and SPEAr600 SOCs are supported. Support for the SPEAr13XX
-  series is in progress.
+  supported by the 'spear' platform of ARM Linux. Currently SPEAr1310,
+  SPEAr1340, SPEAr300, SPEAr310, SPEAr320 and SPEAr600 SOCs are supported.
 
   Hierarchy in SPEAr is as follows:
 
@@ -26,33 +25,36 @@ Introduction
 		- SPEAr600 (SOC)
 			- SPEAr600 Evaluation Board
 	- SPEAr13XX (13XX SOC series, based on ARM CORTEXA9)
-		- SPEAr1300 (SOC)
+		- SPEAr1310 (SOC)
+			- SPEAr1310 Evaluation Board
+		- SPEAr1340 (SOC)
+			- SPEAr1340 Evaluation Board
 
   Configuration
   -------------
 
   A generic configuration is provided for each machine, and can be used as the
   default by
-	make spear600_defconfig
-	make spear300_defconfig
-	make spear310_defconfig
-	make spear320_defconfig
+	make spear13xx_defconfig
+	make spear3xx_defconfig
+	make spear6xx_defconfig
 
   Layout
   ------
 
-  The common files for multiple machine families (SPEAr3XX, SPEAr6XX and
-  SPEAr13XX) are located in the platform code contained in arch/arm/plat-spear
+  The common files for multiple machine families (SPEAr3xx, SPEAr6xx and
+  SPEAr13xx) are located in the platform code contained in arch/arm/plat-spear
   with headers in plat/.
 
   Each machine series have a directory with name arch/arm/mach-spear followed by
   series name. Like mach-spear3xx, mach-spear6xx and mach-spear13xx.
 
-  Common file for machines of spear3xx family is mach-spear3xx/spear3xx.c and for
-  spear6xx is mach-spear6xx/spear6xx.c. mach-spear* also contain soc/machine
-  specific files, like spear300.c, spear310.c, spear320.c and spear600.c.
-  mach-spear* doesn't contains board specific files as they fully support
-  Flattened Device Tree.
+  Common file for machines of spear3xx family is mach-spear3xx/spear3xx.c, for
+  spear6xx is mach-spear6xx/spear6xx.c and for spear13xx family is
+  mach-spear13xx/spear13xx.c. mach-spear* also contain soc/machine specific
+  files, like spear1310.c, spear1340.c spear300.c, spear310.c, spear320.c and
+  spear600.c.  mach-spear* doesn't contains board specific files as they fully
+  support Flattened Device Tree.
 
 
   Document Author
diff --git a/Documentation/devicetree/bindings/arm/spear.txt b/Documentation/devicetree/bindings/arm/spear.txt
index aa5f355..0d42949 100644
--- a/Documentation/devicetree/bindings/arm/spear.txt
+++ b/Documentation/devicetree/bindings/arm/spear.txt
@@ -2,25 +2,25 @@ ST SPEAr Platforms Device Tree Bindings
 ---------------------------------------
 
 Boards with the ST SPEAr600 SoC shall have the following properties:
-
 Required root node property:
-
 compatible = "st,spear600";
 
 Boards with the ST SPEAr300 SoC shall have the following properties:
-
 Required root node property:
-
 compatible = "st,spear300";
 
 Boards with the ST SPEAr310 SoC shall have the following properties:
-
 Required root node property:
-
 compatible = "st,spear310";
 
 Boards with the ST SPEAr320 SoC shall have the following properties:
+Required root node property:
+compatible = "st,spear320";
 
+Boards with the ST SPEAr1310 SoC shall have the following properties:
 Required root node property:
+compatible = "st,spear1310";
 
-compatible = "st,spear320";
+Boards with the ST SPEAr1340 SoC shall have the following properties:
+Required root node property:
+compatible = "st,spear1340";
diff --git a/MAINTAINERS b/MAINTAINERS
index 618d4fd..103d20a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6285,14 +6285,25 @@ F:	include/linux/compiler.h
 
 SPEAR PLATFORM SUPPORT
 M:	Viresh Kumar <viresh.kumar@st.com>
+M:	Shiraz Hashim <shiraz.hashim@st.com>
 L:	spear-devel at list.st.com
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
 S:	Maintained
 F:	arch/arm/plat-spear/
 
+SPEAR13XX MACHINE SUPPORT
+M:	Viresh Kumar <viresh.kumar@st.com>
+M:	Shiraz Hashim <shiraz.hashim@st.com>
+L:	spear-devel at list.st.com
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+W:	http://www.st.com/spear
+S:	Maintained
+F:	arch/arm/mach-spear13xx/
+
 SPEAR3XX MACHINE SUPPORT
 M:	Viresh Kumar <viresh.kumar@st.com>
+M:	Shiraz Hashim <shiraz.hashim@st.com>
 L:	spear-devel at list.st.com
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
@@ -6301,6 +6312,8 @@ F:	arch/arm/mach-spear3xx/
 
 SPEAR6XX MACHINE SUPPORT
 M:	Rajeev Kumar <rajeev-dlh.kumar@st.com>
+M:	Shiraz Hashim <shiraz.hashim@st.com>
+M:	Viresh Kumar <viresh.kumar@st.com>
 L:	spear-devel at list.st.com
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.st.com/spear
-- 
1.7.9
