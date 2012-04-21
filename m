From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat, 21 Apr 2012 13:11:16 +0400
Subject: [PATCH 03/17] ARM clps711x: Selecting CPU-variant automatically for
 clps711x targets
In-Reply-To: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
References: <1334999490-27177-1-git-send-email-shc_work@mail.ru>
Message-ID: <1334999490-27177-4-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/Kconfig |   33 ++++++++++++++++-----------------
 1 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index f86aec1..28ac4d6 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -2,14 +2,25 @@ if ARCH_CLPS711X
 
 menu "CLPS711X/EP721X/EP731X Implementations"
 
+config SOC_EP7211
+	bool
+
+config SOC_EP7212
+	bool
+
+config SOC_EP7312
+	bool
+
 config ARCH_AUTCPU12
 	bool "AUTCPU12"
+	select SOC_EP7212
 	help
 	  Say Y if you intend to run the kernel on the autronix autcpu12
 	  board. This board is based on a Cirrus Logic CS89712.
 
 config ARCH_CDB89712
 	bool "CDB89712"
+	select SOC_EP7212
 	select ISA
 	help
 	  This is an evaluation board from Cirrus for the CS89712 processor.
@@ -18,17 +29,20 @@ config ARCH_CDB89712
 
 config ARCH_CEIVA
 	bool "CEIVA"
+	select SOC_EP7212
 	help
 	  Say Y here if you intend to run this kernel on the Ceiva/Polaroid
 	  PhotoMax Digital Picture Frame.
 
 config ARCH_CLEP7312
 	bool "CLEP7312"
+	select SOC_EP7312
 	help
 	  Boards based on the Cirrus Logic 7212/7312 chips.
 
 config ARCH_EDB7211
 	bool "EDB7211"
+	select SOC_EP7211
 	select ISA
 	select ARCH_SPARSEMEM_ENABLE
 	select ARCH_SELECT_MEMORY_MODEL
@@ -38,29 +52,14 @@ config ARCH_EDB7211
 
 config ARCH_P720T
 	bool "P720T"
+	select SOC_EP7212
 	help
 	  Say Y here if you intend to run this kernel on the ARM Prospector
 	  720T.
 
 config ARCH_FORTUNET
 	bool "FORTUNET"
-
-# XXX Maybe these should indicate register compatibility
-# instead of being mutually exclusive.
-config SOC_EP7211
-	bool
-	depends on ARCH_EDB7211
-	default y
-
-config SOC_EP7212
-	bool
-	depends on ARCH_P720T || ARCH_CEIVA
-	default y
-
-config SOC_EP7312
-	bool
-	depends on ARCH_FORTUNET
-	default y
+	select SOC_EP7312
 
 config EP72XX_ROM_BOOT
 	bool "EP72xx ROM boot"
-- 
1.7.3.4
