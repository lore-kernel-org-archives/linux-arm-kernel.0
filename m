From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 23 Mar 2017 19:00:48 +0000
Subject: [PATCH v3 5/8] arm64: efi: remove forbidden values from the PE/COFF
 header
In-Reply-To: <20170323190051.14882-1-ard.biesheuvel@linaro.org>
References: <20170323190051.14882-1-ard.biesheuvel@linaro.org>
Message-ID: <20170323190051.14882-6-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bring the PE/COFF header in line with the PE/COFF spec, by setting
NumberOfSymbols to 0, and removing the section alignment flags.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi-header.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
index 9b24ce130afb..515624bbfcd0 100644
--- a/arch/arm64/kernel/efi-header.S
+++ b/arch/arm64/kernel/efi-header.S
@@ -15,7 +15,7 @@ coff_header:
 	.short	2					// nr_sections
 	.long	0 					// TimeDateStamp
 	.long	0					// PointerToSymbolTable
-	.long	1					// NumberOfSymbols
+	.long	0					// NumberOfSymbols
 	.short	section_table - optional_header		// SizeOfOptionalHeader
 	.short	0x206					// Characteristics.
 							// IMAGE_FILE_DEBUG_STRIPPED |
@@ -88,7 +88,7 @@ section_table:
 	.long	0					// PointerToLineNumbers
 	.short	0					// NumberOfRelocations
 	.short	0					// NumberOfLineNumbers
-	.long	0x42100040				// Characteristics (section flags)
+	.long	0x42000040				// Characteristics (section flags)
 
 
 	.ascii	".text"
@@ -104,7 +104,7 @@ section_table:
 	.long	0					// PointerToLineNumbers
 	.short	0					// NumberOfRelocations
 	.short	0					// NumberOfLineNumbers
-	.long	0xe0500020				// Characteristics
+	.long	0xe0000020				// Characteristics
 
 #ifdef CONFIG_DEBUG_EFI
 	/*
-- 
2.9.3
