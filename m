From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 29 Aug 2014 17:01:51 +0100
Subject: [PATCH 1/2] efi/arm64: use UEFI for system poweroff
In-Reply-To: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1409324757-12607-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140829160151.GA18555@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Fri, Aug 29, 2014 at 04:05:56PM +0100, Ard Biesheuvel wrote:
> If UEFI Runtime Services are available, they are preferred over direct
> PSCI calls or other methods to power down the system.

Could you elaborate on why they should be preferred?

Mark.

> Enable the existing efi_reboot() code by supplying a definition of
> efi_poweroff_required() that returns true.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/efi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> index e72f3100958f..78c85c4252bc 100644
> --- a/arch/arm64/kernel/efi.c
> +++ b/arch/arm64/kernel/efi.c
> @@ -475,3 +475,11 @@ err_unmap:
>  	return -1;
>  }
>  early_initcall(arm64_enter_virtual_mode);
> +
> +/*
> + * Override the weak definition in drivers/firmware/efi/reboot.c
> + */
> +bool efi_poweroff_required(void)
> +{
> +	return true;
> +}
> -- 
> 1.8.3.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
