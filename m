From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Tue, 6 Jan 2015 16:37:00 +0000
Subject: [PATCH v4 5/8] arm64/efi: set EFI_ALLOC_ALIGN to 64 KB
In-Reply-To: <1419245944-2424-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1419245944-2424-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419245944-2424-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150106163700.GD3827@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 10:59:01AM +0000, Ard Biesheuvel wrote:
> Set EFI_ALLOC_ALIGN to 64 KB so that all allocations done by the stub
> are naturally compatible with a 64 KB granule kernel.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/include/asm/efi.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
> index a34fd3b12e2b..71291253114f 100644
> --- a/arch/arm64/include/asm/efi.h
> +++ b/arch/arm64/include/asm/efi.h
> @@ -44,4 +44,6 @@ extern void efi_idmap_init(void);
>  
>  #define efi_call_early(f, ...) sys_table_arg->boottime->f(__VA_ARGS__)
>  
> +#define EFI_ALLOC_ALIGN		SZ_64K
> +
>  #endif /* _ASM_EFI_H */
> -- 
> 1.8.3.2

Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
