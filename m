From: wangxiongfeng2@huawei.com (Xiongfeng Wang)
Date: Tue, 5 Sep 2017 15:22:11 +0800
Subject: [RFC 4/4] ACPI: Enable PPTT support on ARM64
In-Reply-To: <20170805001159.12769-5-jeremy.linton@arm.com>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
 <20170805001159.12769-5-jeremy.linton@arm.com>
Message-ID: <397f2aa0-b7d9-dc63-0410-6afacee26571@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeremy,

On 2017/8/5 8:11, Jeremy Linton wrote:
> Now that we have a parser, and arm64 has appropriate
> hooks in place to utilize it, lets enable PPTT
> parsing in the arm64 ACPI build.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  drivers/acpi/arm64/Kconfig  | 3 +++
>  drivers/acpi/arm64/Makefile | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
> index 5a6f80f..74b855a 100644
> --- a/drivers/acpi/arm64/Kconfig
> +++ b/drivers/acpi/arm64/Kconfig
> @@ -7,3 +7,6 @@ config ACPI_IORT
>  
>  config ACPI_GTDT
>  	bool
> +
> +config ACPI_PPTT
> +	bool

We may need to select ACPI_PPTT in arch/arm64/Kconfig, just like ACPI_GTDT

> \ No newline at end of file
> diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
> index 1017def..b6dee6b 100644
> --- a/drivers/acpi/arm64/Makefile
> +++ b/drivers/acpi/arm64/Makefile
> @@ -1,2 +1,3 @@
>  obj-$(CONFIG_ACPI_IORT) 	+= iort.o
>  obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
> +obj-$(CONFIG_ACPI_GTDT) 	+= pptt.o
obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
> 


Thanks,
Xiongfeng Wang
