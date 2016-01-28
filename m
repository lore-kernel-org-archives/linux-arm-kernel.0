From: will.deacon@arm.com (Will Deacon)
Date: Thu, 28 Jan 2016 15:56:11 +0000
Subject: [PATCH 1/3] arm64: efistub: drop __init annotation from
 handle_kernel_image()
In-Reply-To: <1453979254-25374-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1453979254-25374-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453979254-25374-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160128155611.GK775@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 12:07:32PM +0100, Ard Biesheuvel wrote:
> After moving arm64-stub.c to libstub/, all of its sections are emitted
> as .init.xxx sections automatically, and the __init annotation of
> handle_kernel_image() causes it to end up in .init.init.text, which is
> not recognized as an __init section by the linker scripts. So drop the
> annotation.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/arm64-stub.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/drivers/firmware/efi/libstub/arm64-stub.c b/drivers/firmware/efi/libstub/arm64-stub.c
> index 78dfbd34b6bf..9e0342745e4f 100644
> --- a/drivers/firmware/efi/libstub/arm64-stub.c
> +++ b/drivers/firmware/efi/libstub/arm64-stub.c
> @@ -13,13 +13,13 @@
>  #include <asm/efi.h>
>  #include <asm/sections.h>
>  
> -efi_status_t __init handle_kernel_image(efi_system_table_t *sys_table_arg,
> -					unsigned long *image_addr,
> -					unsigned long *image_size,
> -					unsigned long *reserve_addr,
> -					unsigned long *reserve_size,
> -					unsigned long dram_base,
> -					efi_loaded_image_t *image)
> +efi_status_t handle_kernel_image(efi_system_table_t *sys_table_arg,
> +				 unsigned long *image_addr,
> +				 unsigned long *image_size,
> +				 unsigned long *reserve_addr,
> +				 unsigned long *reserve_size,
> +				 unsigned long dram_base,
> +				 efi_loaded_image_t *image)
>  {
>  	efi_status_t status;
>  	unsigned long kernel_size, kernel_memsize = 0;
> -- 
> 2.5.0
> 
