From: psquid@psquid.net (Robert Graffham)
Date: Tue, 31 Dec 2013 22:59:22 +0000
Subject: [PATCH] Slightly outdated CONFIG_SMP documentation fix
Message-ID: <20131231225921.GA1624@sylph>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've removed a reference to "most personal computers" being singleprocessor
machines in multiple arches' config help, and also brought the arch/arm spacing
for "singleprocessor" (vs. "single processor" used there originally) in line
with other arches that had that text.

The diff is included below, and cleanly applies and builds on my system. I have
not tested on other systems yet since a documentation fix shouldn't fail to
build inconsistently, but if that's no excuse, I'll be happy to test further
when I can.


diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/alpha/Kconfig linux/arch/alpha/Kconfig
--- linux-vanilla/arch/alpha/Kconfig	2013-12-22 18:03:11.881499508 +0000
+++ linux/arch/alpha/Kconfig	2013-12-22 17:58:31.448505765 +0000
@@ -539,8 +539,8 @@ config SMP
 	depends on ALPHA_SABLE || ALPHA_LYNX || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/arc/Kconfig linux/arch/arc/Kconfig
--- linux-vanilla/arch/arc/Kconfig	2013-12-22 18:03:11.933499507 +0000
+++ linux/arch/arc/Kconfig	2013-12-22 17:58:24.412505922 +0000
@@ -128,8 +128,8 @@ config SMP
 	default n
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 if SMP
 
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/arm/Kconfig linux/arch/arm/Kconfig
--- linux-vanilla/arch/arm/Kconfig	2013-12-22 18:03:11.956499506 +0000
+++ linux/arch/arm/Kconfig	2013-12-22 17:56:31.187508449 +0000
@@ -1435,14 +1435,14 @@ config SMP
 	depends on MMU || ARM_MPU
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on many, but not all, single
-	  processor machines. On a single processor machine, the kernel will
-	  run faster if you say N here.
+	  you say Y here, the kernel will run on many, but not all,
+	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/m32r/Kconfig linux/arch/m32r/Kconfig
--- linux-vanilla/arch/m32r/Kconfig	2013-12-22 18:03:13.100499481 +0000
+++ linux/arch/m32r/Kconfig	2013-12-22 17:58:27.485505854 +0000
@@ -277,8 +277,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-vanilla/arch/mips/Kconfig	2013-12-22 18:03:13.290499477 +0000
+++ linux/arch/mips/Kconfig	2013-12-22 17:58:28.576505829 +0000
@@ -2128,8 +2128,8 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mn10300/Kconfig linux/arch/mn10300/Kconfig
--- linux-vanilla/arch/mn10300/Kconfig	2013-12-22 18:03:13.598499470 +0000
+++ linux/arch/mn10300/Kconfig	2013-12-22 17:58:26.460505877 +0000
@@ -184,8 +184,8 @@ config SMP
 	depends on MN10300_PROC_MN2WS0038 || MN10300_PROC_MN2WS0050
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/parisc/Kconfig linux/arch/parisc/Kconfig
--- linux-vanilla/arch/parisc/Kconfig	2013-12-22 18:03:13.682499468 +0000
+++ linux/arch/parisc/Kconfig	2013-12-22 17:57:38.097506956 +0000
@@ -229,8 +229,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/s390/Kconfig linux/arch/s390/Kconfig
--- linux-vanilla/arch/s390/Kconfig	2013-12-22 18:03:14.077499459 +0000
+++ linux/arch/s390/Kconfig	2013-12-22 17:58:29.631505806 +0000
@@ -332,8 +332,8 @@ config SMP
 	prompt "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/sh/Kconfig linux/arch/sh/Kconfig
--- linux-vanilla/arch/sh/Kconfig	2013-12-22 18:03:14.188499457 +0000
+++ linux/arch/sh/Kconfig	2013-12-22 17:58:25.470505899 +0000
@@ -714,8 +714,8 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/x86/Kconfig linux/arch/x86/Kconfig
--- linux-vanilla/arch/x86/Kconfig	2013-12-22 18:03:14.584499448 +0000
+++ linux/arch/x86/Kconfig	2013-12-22 17:58:30.711505782 +0000
@@ -278,8 +278,8 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
 	  If you say N here, the kernel will run on single and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
Signed-off-by: Robert Graffham <psquid@psquid.net>
