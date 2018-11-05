From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  5 Nov 2018 20:43:19 +0100
Subject: [PATCH v2 0/2] ARM: compressed: reorganize section layout and enable
 EFI debugging
Message-ID: <20181105194321.26657-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tweak the output section layout of the decompressor so that the ELF and
PE/COFF .text sections start at the same offset in the image. This is
a prerequisite for enabling a EFI debug header that is highly useful
when debugging the interactions of the EFI stub code with the firmware.

v2:
- drop changes to the .start and .text sections: those changes were based
  on a misinterpretation on my part of the documented behavior of ld.bfd
  when it comes   to ordering input sections.

Ard Biesheuvel (2):
  ARM: compressed: put zImage header and EFI header in dedicated section
  ARM: efi: add PE/COFF debug table to EFI header

 arch/arm/boot/compressed/Makefile      |  4 ++
 arch/arm/boot/compressed/efi-header.S  | 47 ++++++++++++++++++++
 arch/arm/boot/compressed/head.S        |  4 +-
 arch/arm/boot/compressed/vmlinux.lds.S |  5 ++-
 4 files changed, 58 insertions(+), 2 deletions(-)

-- 
2.19.1
