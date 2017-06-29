From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 29 Jun 2017 08:18:43 +0000
Subject: [PATCH v2 1/7] arm: efi: remove forbidden values from the PE/COFF
 header
In-Reply-To: <20170629081849.15081-1-ard.biesheuvel@linaro.org>
References: <20170629081849.15081-1-ard.biesheuvel@linaro.org>
Message-ID: <20170629081849.15081-2-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring the PE/COFF header in line with the PE/COFF spec, by setting
NumberOfSymbols to 0, and removing the section alignment flags.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/boot/compressed/efi-header.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/compressed/efi-header.S b/arch/arm/boot/compressed/efi-header.S
index a17ca8d78656..4169b900d9d4 100644
--- a/arch/arm/boot/compressed/efi-header.S
+++ b/arch/arm/boot/compressed/efi-header.S
@@ -44,7 +44,7 @@ coff_header:
 		.short	2			@ nr_sections
 		.long	0 			@ TimeDateStamp
 		.long	0			@ PointerToSymbolTable
-		.long	1			@ NumberOfSymbols
+		.long	0			@ NumberOfSymbols
 		.short	section_table - optional_header
 						@ SizeOfOptionalHeader
 		.short	0x306			@ Characteristics.
@@ -110,7 +110,7 @@ section_table:
 		.long	0			@ PointerToLineNumbers
 		.short	0			@ NumberOfRelocations
 		.short	0			@ NumberOfLineNumbers
-		.long	0x42100040		@ Characteristics
+		.long	0x42000040		@ Characteristics
 
 		.ascii	".text\0\0\0"
 		.long	_end - __efi_start	@ VirtualSize
@@ -121,7 +121,7 @@ section_table:
 		.long	0			@ PointerToLineNumbers
 		.short	0			@ NumberOfRelocations
 		.short	0			@ NumberOfLineNumbers
-		.long	0xe0500020		@ Characteristics
+		.long	0xe0000020		@ Characteristics
 
 		.align	9
 __efi_start:
-- 
2.9.3
