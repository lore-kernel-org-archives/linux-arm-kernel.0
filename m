From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 28 Jan 2016 15:53:43 +0000
Subject: [PATCH 0/3] arm efi minor fixes
In-Reply-To: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160128155341.GP17123@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 12:07:31PM +0100, Ard Biesheuvel wrote:
> This fixes two minor issues with the handling of .init data in the stub (#1, #2)
> 
> Patch #3 replaces some instances of early_memremap() with early_memremap_ro()
> where the region in question is only accessed in r/o mode.

Nice!

The series looks sensible to me, and having given it a spin on Juno
(atop of v4.5-rc1 defconfig) everything seems to work, so FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> Ard Biesheuvel (3):
>   arm64: efistub: drop __init annotation from handle_kernel_image()
>   arm64: vmlinux.lds.S: handle .init.rodata.xxx and .init.bss sections
>   efi: arm-init: use read-only early mappings
> 
>  arch/arm64/kernel/vmlinux.lds.S           |  1 +
>  drivers/firmware/efi/arm-init.c           | 14 +++++++-------
>  drivers/firmware/efi/libstub/arm64-stub.c | 14 +++++++-------
>  3 files changed, 15 insertions(+), 14 deletions(-)
> 
> -- 
> 2.5.0
> 
