From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 27 Oct 2017 09:44:19 -0700
Subject: [PATCH v10 6/9] LPC: Support the LPC host on Hip06/Hip07 with DT
 bindings
In-Reply-To: <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
 <1509120687-7352-7-git-send-email-gabriele.paoloni@huawei.com>
Message-ID: <de9f0362-6f2d-2f73-a23a-af248a9b1963@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/27/17 09:11, Gabriele Paoloni wrote:
> diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
> index 2408ea3..358eed3 100644
> --- a/drivers/bus/Kconfig
> +++ b/drivers/bus/Kconfig
> @@ -64,6 +64,15 @@ config BRCMSTB_GISB_ARB
>  	  arbiter. This driver provides timeout and target abort error handling
>  	  and internal bus master decoding.
>  
> +config HISILICON_LPC
> +	bool "Support for ISA I/O space on Hisilicon Hip0X"
> +	depends on (ARM64 && (ARCH_HISI || COMPILE_TEST))
> +	select LOGIC_PIO
> +	select INDIRECT_PIO
> +	help
> +	  Driver needed for some legacy ISA devices attached to Low-Pin-Count
> +	  on Hisilicon Hip0X SoC.
> +
>  config IMX_WEIM
>  	bool "Freescale EIM DRIVER"
>  	depends on ARCH_MXC

Hi,

Why bool? why not tristate?

-- 
~Randy
