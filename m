From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 14:10:54 +0530
Subject: [PATCH V2 Resend 11/12] ST SPEAr: Updated Maintainers and added
	Documentation/arm/SPEAr
In-Reply-To: <1269506455-15173-11-git-send-email-viresh.kumar@st.com>
References: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-2-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-3-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-4-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-5-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-6-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-7-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-8-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-9-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-10-git-send-email-viresh.kumar@st.com>
	<1269506455-15173-11-git-send-email-viresh.kumar@st.com>
Message-ID: <1269506455-15173-12-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 Documentation/arm/00-INDEX           |    2 +
 Documentation/arm/SPEAr/overview.txt |   60 ++++++++++++++++++++++++++++++++++
 MAINTAINERS                          |   40 ++++++++++++++++++++++
 3 files changed, 102 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/arm/SPEAr/overview.txt

diff --git a/Documentation/arm/00-INDEX b/Documentation/arm/00-INDEX
index 82e418d..7f5fc3b 100644
--- a/Documentation/arm/00-INDEX
+++ b/Documentation/arm/00-INDEX
@@ -20,6 +20,8 @@ Samsung-S3C24XX
 	- S3C24XX ARM Linux Overview
 Sharp-LH
 	- Linux on Sharp LH79524 and LH7A40X System On a Chip (SOC)
+SPEAr
+	- ST SPEAr platform Linux Overview
 VFP/
 	- Release notes for Linux Kernel Vector Floating Point support code
 empeg/
diff --git a/Documentation/arm/SPEAr/overview.txt b/Documentation/arm/SPEAr/overview.txt
new file mode 100644
index 0000000..253a35c
--- /dev/null
+++ b/Documentation/arm/SPEAr/overview.txt
@@ -0,0 +1,60 @@
+			SPEAr ARM Linux Overview
+			==========================
+
+Introduction
+------------
+
+  SPEAr (Structured Processor Enhanced Architecture).
+  weblink : http://www.st.com/spear
+
+  The ST Microelectronics SPEAr range of ARM9/CortexA9 System-on-Chip CPUs are
+  supported by the 'spear' platform of ARM Linux. Currently SPEAr300,
+  SPEAr310, SPEAr320 and SPEAr600 SOCs are supported. Support for the SPEAr13XX
+  series is in progress.
+
+  Hierarchy in SPEAr is as follows:
+
+  SPEAr (Platform)
+	- SPEAr3XX (3XX SOC series, based on ARM9)
+		- SPEAr300 (SOC)
+			- SPEAr300_EVB (Evaluation Board)
+		- SPEAr310 (SOC)
+			- SPEAr310_EVB (Evaluation Board)
+		- SPEAr320 (SOC)
+			- SPEAr320_EVB (Evaluation Board)
+	- SPEAr6XX (6XX SOC series, based on ARM9)
+		- SPEAr600 (SOC)
+			- SPEAr600_EVB (Evaluation Board)
+	- SPEAr13XX (13XX SOC series, based on ARM CORTEXA9)
+		- SPEAr1300 (SOC)
+
+  Configuration
+  -------------
+
+  A generic configuration is provided for each machine, and can be used as the
+  default by
+	make spear600_defconfig
+	make spear300_defconfig
+	make spear310_defconfig
+	make spear320_defconfig
+
+  Layout
+  ------
+
+  The common files for multiple machine families (SPEAr3XX, SPEAr6XX and
+  SPEAr13XX) are located in the platform code contained in arch/arm/plat-spear
+  with headers in plat/.
+
+  Each machine series have a directory with name arch/arm/mach-spear followed by
+  series name. Like mach-spear3xx, mach-spear6xx and mach-spear13xx.
+
+  Common file for machines of spear3xx family is mach-spear3xx/spear3xx.c and for
+  spear6xx is mach-spear6xx/spear6xx.c. mach-spear* also contain soc/machine
+  specific files, like spear300.c, spear310.c, spear320.c and spear600.c.
+  mach-spear* also contains board specific files for each machine type.
+
+
+  Document Author
+  ---------------
+
+  Viresh Kumar, (c) 2010 ST Microelectronics
diff --git a/MAINTAINERS b/MAINTAINERS
index 449d444..dc6b246 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5238,6 +5238,46 @@ F:	drivers/serial/sunsu.c
 F:	drivers/serial/sunzilog.c
 F:	drivers/serial/sunzilog.h
 
+SPEAR PLATFORM SUPPORT
+M:	Viresh Kumar <viresh.kumar@st.com>
+W:	http://www.st.com/spear
+S:	Maintained
+F:	arch/arm/plat-spear/
+
+SPEAR3XX MACHINE SUPPORT
+M:	Viresh Kumar <viresh.kumar@st.com>
+W:	http://www.st.com/spear
+S:	Maintained
+F:	arch/arm/mach-spear3xx/
+
+SPEAR6XX MACHINE SUPPORT
+M:	Rajeev Kumar <rajeev-dlh.kumar@st.com>
+W:	http://www.st.com/spear
+S:	Maintained
+F:	arch/arm/mach-spear6xx/
+
+SPEAR CLOCK FRAMEWORK SUPPORT
+M:	Viresh Kumar <viresh.kumar@st.com>
+W:	http://www.st.com/spear
+S:	Maintained
+F:	arch/arm/mach-spear*/clock.c
+F:	arch/arm/mach-spear*/include/mach/clkdev.h
+F:	arch/arm/plat-spear/clock.c
+F:	arch/arm/plat-spear/include/plat/clock.h and clkdev.h
+
+SPEAR PAD MULTIPLEXING SUPPORT
+M:	Viresh Kumar <viresh.kumar@st.com>
+W:	http://www.st.com/spear
+S:	Maintained
+F:	arch/arm/plat-spear/include/plat/padmux.h
+F:	arch/arm/plat-spear/padmux.c
+F:	arch/arm/mach-spear*/spear*xx.c
+F:	arch/arm/mach-spear*/include/mach/generic.h
+F:	arch/arm/mach-spear3xx/spear3*0.c
+F:	arch/arm/mach-spear3xx/spear3*0_evb.c
+F:	arch/arm/mach-spear6xx/spear600.c
+F:	arch/arm/mach-spear6xx/spear600_evb.c
+
 SPECIALIX IO8+ MULTIPORT SERIAL CARD DRIVER
 M:	Roger Wolff <R.E.Wolff@BitWizard.nl>
 S:	Supported
-- 
1.6.0.2
