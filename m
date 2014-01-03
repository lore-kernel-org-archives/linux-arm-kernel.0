From: psquid@psquid.net (Robert Graffham)
Date: Fri, 3 Jan 2014 00:36:11 +0000
Subject: [PATCH] Slightly outdated CONFIG_SMP documentation fix
In-Reply-To: <20140102151547.fde4aa5855cc75e91fea95e5@linux-foundation.org>
References: <20131231225921.GA1624@sylph>
 <23596.1388674589@warthog.procyon.org.uk>
 <20140102150219.3df32a23cf7dbe9618ea118e@linux-foundation.org>
 <CAAJfVc7vK9W9Zy0LvGWSTWMSEb_JEx7FbLECy44QEwj+CWgSGg@mail.gmail.com>
 <20140102151547.fde4aa5855cc75e91fea95e5@linux-foundation.org>
Message-ID: <20140103003610.GA21711@sylph>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As requested, I've modified "singleprocessor" to "uniprocessor" in my tree, and
the revised patch is included below (with the Signed-off-by at the right end
this time - thanks Andrew).

To re-summarize given the new revision, this patch now removes an outdated
reference to "most personal computers" having only one CPU, and changes the use
of "singleprocessor" and "single processor" in CONFIG_SMP's documentation to
"uniprocessor" across all arches where that documentation is present.

Signed-off-by: Robert Graffham <psquid@psquid.net>

diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/alpha/Kconfig linux/arch/alpha/Kconfig
--- linux-vanilla/arch/alpha/Kconfig	2013-12-22 18:03:11.881499508 +0000
+++ linux/arch/alpha/Kconfig	2014-01-03 00:20:04.660530554 +0000
@@ -539,13 +539,13 @@ config SMP
 	depends on ALPHA_SABLE || ALPHA_LYNX || ALPHA_RAWHIDE || ALPHA_DP264 || ALPHA_WILDFIRE || ALPHA_TITAN || ALPHA_GENERIC || ALPHA_SHARK || ALPHA_MARVEL
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also the SMP-HOWTO available at
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
+++ linux/arch/arm/Kconfig	2014-01-03 00:18:04.776533229 +0000
@@ -1435,14 +1435,14 @@ config SMP
 	depends on MMU || ARM_MPU
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
-	  you say Y here, the kernel will run on many, but not all, single
-	  processor machines. On a single processor machine, the kernel will
-	  run faster if you say N here.
+	  you say Y here, the kernel will run on many, but not all,
+	  uniprocessor machines. On a uniprocessor machine, the kernel
+	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/m32r/Kconfig linux/arch/m32r/Kconfig
--- linux-vanilla/arch/m32r/Kconfig	2013-12-22 18:03:13.100499481 +0000
+++ linux/arch/m32r/Kconfig	2014-01-03 00:19:05.746531868 +0000
@@ -277,13 +277,13 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mips/Kconfig linux/arch/mips/Kconfig
--- linux-vanilla/arch/mips/Kconfig	2013-12-22 18:03:13.290499477 +0000
+++ linux/arch/mips/Kconfig	2014-01-03 00:19:16.904531619 +0000
@@ -2128,13 +2128,13 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	help
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/mn10300/Kconfig linux/arch/mn10300/Kconfig
--- linux-vanilla/arch/mn10300/Kconfig	2013-12-22 18:03:13.598499470 +0000
+++ linux/arch/mn10300/Kconfig	2014-01-03 00:19:02.061531951 +0000
@@ -184,13 +184,13 @@ config SMP
 	depends on MN10300_PROC_MN2WS0038 || MN10300_PROC_MN2WS0050
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also <file:Documentation/x86/i386/IO-APIC.txt>,
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/parisc/Kconfig linux/arch/parisc/Kconfig
--- linux-vanilla/arch/parisc/Kconfig	2013-12-22 18:03:13.682499468 +0000
+++ linux/arch/parisc/Kconfig	2014-01-03 00:18:38.464532477 +0000
@@ -229,13 +229,13 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/s390/Kconfig linux/arch/s390/Kconfig
--- linux-vanilla/arch/s390/Kconfig	2014-01-03 00:09:20.086544936 +0000
+++ linux/arch/s390/Kconfig	2014-01-03 00:19:59.831530662 +0000
@@ -334,10 +334,10 @@ config SMP
 	  a system with only one CPU, say N. If you have a system with more
 	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  See also the SMP-HOWTO available at
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/sh/Kconfig linux/arch/sh/Kconfig
--- linux-vanilla/arch/sh/Kconfig	2013-12-22 18:03:14.188499457 +0000
+++ linux/arch/sh/Kconfig	2014-01-03 00:18:58.090532039 +0000
@@ -714,13 +714,13 @@ config SMP
 	depends on SYS_SUPPORTS_SMP
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/sparc/Kconfig linux/arch/sparc/Kconfig
--- linux-vanilla/arch/sparc/Kconfig	2013-12-22 18:03:14.368499453 +0000
+++ linux/arch/sparc/Kconfig	2014-01-03 00:19:50.073530879 +0000
@@ -152,10 +152,10 @@ config SMP
 	  a system with only one CPU, say N. If you have a system with more
 	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  People using multiprocessor machines who say Y here should also say
diff -uprN -X linux-vanilla/Documentation/dontdiff linux-vanilla/arch/x86/Kconfig linux/arch/x86/Kconfig
--- linux-vanilla/arch/x86/Kconfig	2013-12-22 18:03:14.584499448 +0000
+++ linux/arch/x86/Kconfig	2014-01-03 00:20:02.957530592 +0000
@@ -278,13 +278,13 @@ config SMP
 	bool "Symmetric multi-processing support"
 	---help---
 	  This enables support for systems with more than one CPU. If you have
-	  a system with only one CPU, like most personal computers, say N. If
-	  you have a system with more than one CPU, say Y.
+	  a system with only one CPU, say N. If you have a system with more
+	  than one CPU, say Y.
 
-	  If you say N here, the kernel will run on single and multiprocessor
+	  If you say N here, the kernel will run on uni- and multiprocessor
 	  machines, but will use only one CPU of a multiprocessor machine. If
 	  you say Y here, the kernel will run on many, but not all,
-	  singleprocessor machines. On a singleprocessor machine, the kernel
+	  uniprocessor machines. On a uniprocessor machine, the kernel
 	  will run faster if you say N here.
 
 	  Note that if you say Y here and choose architecture "586" or
