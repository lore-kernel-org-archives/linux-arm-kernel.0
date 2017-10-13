From: guohanjun@huawei.com (Hanjun Guo)
Date: Fri, 13 Oct 2017 17:53:54 +0800
Subject: [PATCH v3 2/7] ACPI: Enable PPTT support on ARM64
In-Reply-To: <20171012194856.13844-3-jeremy.linton@arm.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-3-jeremy.linton@arm.com>
Message-ID: <59E08D32.2010605@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On 2017/10/13 3:48, Jeremy Linton wrote:
> Now that we have a PPTT parser, in preparation for its use
> on arm64, lets build it.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/Kconfig         | 1 +
>  drivers/acpi/Makefile      | 1 +
>  drivers/acpi/arm64/Kconfig | 3 +++
>  3 files changed, 5 insertions(+)
>
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 0df64a6a56d4..68c9d1289735 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -7,6 +7,7 @@ config ARM64
>  	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>  	select ACPI_MCFG if ACPI
>  	select ACPI_SPCR_TABLE if ACPI
> +	select ACPI_PPTT if ACPI
>  	select ARCH_CLOCKSOURCE_DATA
>  	select ARCH_HAS_DEBUG_VIRTUAL
>  	select ARCH_HAS_DEVMEM_IS_ALLOWED
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 90265ab4437a..c92a0c937551 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -85,6 +85,7 @@ obj-$(CONFIG_ACPI_BGRT)		+= bgrt.o
>  obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
> +obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 5a6f80fce0d6..74b855a669ea 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -7,3 +7,6 @@ config ACPI_IORT
>  
>  config ACPI_GTDT
>  	bool
> +
> +config ACPI_PPTT
> +	bool

Can this be located in drivers/acpi/Kconfig? then other
platform can select ACPI_PPTT if they want.

Thanks
Hanjun

> \ No newline at end of file
