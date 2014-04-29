From: grant.likely@linaro.org (Grant Likely)
Date: Tue, 29 Apr 2014 10:56:38 +0100
Subject: [PATCH v3 part1 11/11] ACPI: Make EC depend on X86 || IA64 in
 Kconfig
In-Reply-To: <1398432017-8506-12-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <20140429095638.D694AC4095B@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Apr 2014 21:20:17 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Since EC (Embedded controller) needs SCI for the interupt which
> is not available on ARM64, make it depend on X86 || IA64 only
> in the Kconfig file.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>  drivers/acpi/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ae45088..391325c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -49,6 +49,7 @@ config ACPI_SLEEP
>  
>  config ACPI_EC_DEBUGFS
>  	tristate "EC read/write access through /sys/kernel/debug/ec"
> +	depends on X86 || IA64

Nit: This patch and patch 10 should be applied before patch 9 which adds
the option to enable ACPI, but otherwise this series looks reasonable to
me and aside from the comments made by others is pretty much ready to be
merged. Go ahead and add my reviewed-by tag to the whole series.

Reviewed-by: Grant Likely <grant.likely@linaro.org>

>  	default n
>  	help
>  	  Say N to disable Embedded Controller /sys/kernel/debug interface
> -- 
> 1.7.9.5
> 
