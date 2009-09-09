From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Wed, 9 Sep 2009 10:56:47 +0400
Subject: [PATCH] SA1100: fix multimachine kernel issue
Message-ID: <mailman.3.1252500869.2253.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Zaurus Collie and Siemens Simpad both have machine-specific hacks
in arch/arm/boot/compressed/head-sa1100.S which force their respective
machine ID regardless of what bootloader passes (or not passes - that's
the reason these hacks are here - a workaround for broken bootloaders).
This breaks booting multimachine kernel on other machines. So forbid
selecting other machines in Kconfig if SA1100_COLLIE or SA1100_SIMPAD
are selected.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/Kconfig |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 81ffff7..d4e4fea 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -4,6 +4,7 @@ menu "SA11x0 Implementations"
 
 config SA1100_ASSABET
 	bool "Assabet"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  Say Y here if you are using the Intel(R) StrongARM(R) SA-1110
 	  Microprocessor Development Board (also known as the Assabet).
@@ -19,6 +20,7 @@ config ASSABET_NEPONSET
 
 config SA1100_CERF
 	bool "CerfBoard"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  The Intrinsyc CerfBoard is based on the StrongARM 1110 (Discontinued).
 	  More information is available at:
@@ -53,6 +55,7 @@ config SA1100_COLLIE
 
 config SA1100_H3100
 	bool "Compaq iPAQ H3100"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3100 handheld computer.  Information about this machine and the
@@ -63,6 +66,7 @@ config SA1100_H3100
 
 config SA1100_H3600
 	bool "Compaq iPAQ H3600/H3700"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  Say Y here if you intend to run this kernel on the Compaq iPAQ
 	  H3600 handheld computer.  Information about this machine and the
@@ -78,6 +82,7 @@ config SA1100_H3XXX
 
 config SA1100_BADGE4
 	bool "HP Labs BadgePAD 4"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	select SA1111
 	help
 	  Say Y here if you want to build a kernel for the HP Laboratories
@@ -85,6 +90,7 @@ config SA1100_BADGE4
 
 config SA1100_JORNADA720
 	bool "HP Jornada 720"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	select SA1111
 	help
 	  Say Y here if you want to build a kernel for the HP Jornada 720
@@ -103,12 +109,14 @@ config SA1100_JORNADA720_SSP
 
 config SA1100_HACKKIT
 	bool "HackKit Core CPU Board"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  Say Y here to support the HackKit Core CPU Board
 	  <http://hackkit.eletztrick.de>;
 
 config SA1100_LART
 	bool "LART"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  Say Y here if you are using the Linux Advanced Radio Terminal
 	  (also known as the LART).  See <http://www.lartmaker.nl/> for
@@ -116,6 +124,7 @@ config SA1100_LART
 
 config SA1100_PLEB
 	bool "PLEB"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  Say Y here if you are using version 1 of the Portable Linux
 	  Embedded Board (also known as PLEB).
@@ -124,6 +133,7 @@ config SA1100_PLEB
 
 config SA1100_SHANNON
 	bool "Shannon"
+	depends on !SA1100_COLLIE && !SA1100_SIMPAD
 	help
 	  The Shannon (also known as a Tuxscreen, and also as a IS2630) was a
 	  limited edition webphone produced by Philips. The Shannon is a SA1100
@@ -132,6 +142,7 @@ config SA1100_SHANNON
 
 config SA1100_SIMPAD
 	bool "Simpad"
+	depends on !SA1100_COLLIE
 	help
 	  The SIEMENS webpad SIMpad is based on the StrongARM 1110. There
 	  are two different versions CL4 and SL4. CL4 has 32MB RAM and 16MB
-- 
1.6.3.4


--2oS5YaxWCcQjTEyO--
