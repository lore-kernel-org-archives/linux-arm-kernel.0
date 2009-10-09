From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri,  9 Oct 2009 15:02:19 +0100
Subject: [PATCH 3/6] ARM: update Kconfig help text for floating point
In-Reply-To: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Message-ID: <1255096942-10451-3-git-send-email-alan-jenkins@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We do now support some floating point hardware.  Update the help text
for floating point emulation accordingly, and rename the enclosing
Kconfig menu to "floating point support".  Also remove a reference to
the Acorn FPEmulator; the last public release was built for kernel
version 2.2 and will not load on 2.6.[1]

[1] http://ftp.arm.linux.org.uk/pub/linux/arm/fpemulator/

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 arch/arm/Kconfig |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1c4119c..085644c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1411,21 +1411,19 @@ source "drivers/cpuidle/Kconfig"
 
 endmenu
 
-menu "Floating point emulation"
+menu "Floating point support"
 
-comment "At least one emulation must be selected"
+comment "At least one option must be selected"
 
 config FPE_NWFPE
 	bool "NWFPE math emulation"
 	depends on !AEABI || OABI_COMPAT
 	---help---
 	  Say Y to include the NWFPE floating point emulator in the kernel.
-	  This is necessary to run most binaries. Linux does not currently
-	  support floating point hardware so you need to say Y here even if
-	  your machine has an FPA or floating point co-processor podule.
-
-	  You may say N here if you are going to load the Acorn FPEmulator
-	  early in the bootup.
+	  This is necessary to run most old ABI binaries. Linux does not
+	  support FPA floating point hardware, so you need to say Y here
+	  even if your machine has an FPA or floating point co-processor
+	  podule.
 
 config FPE_NWFPE_XP
 	bool "Support extended precision"
@@ -1437,7 +1435,7 @@ config FPE_NWFPE_XP
 	  so in most cases this option only enlarges the size of the
 	  floating point emulator without any good reason.
 
-	  You almost surely want to say N here.
+	  You almost certainly want to say N here.
 
 config FPE_FASTFPE
 	bool "FastFPE math emulation (EXPERIMENTAL)"
-- 
1.6.3.2
