From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 15 Apr 2016 17:03:14 +0800
Subject: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Message-ID: <5710AE52.2070608@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/4/15 15:53, Mark Brown wrote:
> If ACPI is selectable it is enabled by default.  This is a good choice
> for architectures where the overwhelming majority of systems use ACPI
> like x86 and IA-64 but is less clear for architectures where it's less
> common like ARM64.  Change the default selection so that it's only done
> explicitly on those architectures where ACPI is universally used.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 82b96ee8624c..2fcf87a6d270 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -8,7 +8,7 @@ menuconfig ACPI
>  	depends on IA64 || X86 || (ARM64 && EXPERT)
>  	depends on PCI
>  	select PNP
> -	default y
> +	default y if (IA64 || X86)
>  	help
>  	  Advanced Configuration and Power Interface (ACPI) support for 
>  	  Linux requires an ACPI-compliant platform (hardware/firmware),


Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
