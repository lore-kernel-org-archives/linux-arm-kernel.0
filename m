From: slash.tmp@free.fr (Mason)
Date: Wed, 18 May 2016 10:30:17 +0200
Subject: CONFIG_ZBOOT_ROM_TEXT and CONFIG_ZBOOT_ROM_BSS in defconfig
In-Reply-To: <573B3F3C.80800@free.fr>
References: <573B3F3C.80800@free.fr>
Message-ID: <573C2819.3090109@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/05/2016 17:56, Mason wrote:

> I can submit a patch changing the default from 0 to 0x0, i.e.
> no functional change. The two entries would then disappear
> from defconfigs.

Specifically, this is what I meant:

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 70764838dfcc..6831c46a3672 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1823,7 +1823,7 @@ config DEPRECATED_PARAM_STRUCT
 # TEXT and BSS so we preserve their values in the config files.
 config ZBOOT_ROM_TEXT
 	hex "Compressed ROM boot loader base address"
-	default "0"
+	default 0x0
 	help
 	  The physical address at which the ROM-able zImage is to be
 	  placed in the target.  Platforms which normally make use of
@@ -1834,7 +1834,7 @@ config ZBOOT_ROM_TEXT
 
 config ZBOOT_ROM_BSS
 	hex "Compressed ROM boot loader BSS address"
-	default "0"
+	default 0x0
 	help
 	  The base address of an area of read/write memory in the target
 	  for the ROM-able zImage which must be available while the
