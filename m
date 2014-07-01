From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 1 Jul 2014 19:39:06 +0100
Subject: [PATCH v2 0/5] efistub: convert into static library
In-Reply-To: <1403792617-25792-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1403792617-25792-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140701183906.GH7539@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Jun, at 04:23:32PM, Ard Biesheuvel wrote:
> This is v2 of the series to change the #include "../../../../xxx.c" pattern
> into a static library linked into either the kernel (arm64) or a separate boot
> decompressor (x86, ARM).
> 
> Changes since v1:
> - added patch #1 to change EFI_ERROR, it is not a result code defined by UEFI so
>   it should only be returned by get_dram_base() and efi_entry()
> - added a section to libstub Makefile to clean CFLAGS of stack protecter and 
>   other options that are inappropriate for the stub
> - rebased onto the UEFI Runtime Services NEON patches (re)posted earlier today
> 
> Ard Biesheuvel (5):
>   efi/arm64: avoid EFI_ERROR as a generic return code
>   efi/x86: efistub: move shared dependencies to <asm/efi.h>
>   efi/arm64: efistub: move shared dependencies to <asm/efi.h>
>   efi: efistub: refactor stub components
>   efi: efistub: convert into static library

Thanks Ard. I've picked these up.

-- 
Matt Fleming, Intel Open Source Technology Center
