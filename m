From: rdunlap@infradead.org (Randy Dunlap)
Date: Fri, 14 Sep 2018 14:30:11 -0700
Subject: [PATCH v2 3/4] iio: adc: Add Xilinx AMS driver
In-Reply-To: <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
 <1536909510-7166-4-git-send-email-manish.narani@xilinx.com>
Message-ID: <f169ebb6-6c2c-6f30-d59c-e89561622ecb@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 9/14/18 12:18 AM, Manish Narani wrote:
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/iio/adc/Kconfig      |   10 +
>  drivers/iio/adc/Makefile     |    1 +
>  drivers/iio/adc/xilinx-ams.c | 1337 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1348 insertions(+)
>  create mode 100644 drivers/iio/adc/xilinx-ams.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 4a75492..405ea00 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -941,4 +941,14 @@ config XILINX_XADC
>  	  The driver can also be build as a module. If so, the module will be called

oops (some other driver:)
	                         built

>  	  xilinx-xadc.
>  
> +config XILINX_AMS
> +	tristate "Xilinx AMS driver"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say yes here to have support for the Xilinx AMS.
> +
> +	  The driver can also be build as a module. If so, the module will be called

	                         built

> +	  xilinx-ams.
> +
>  endmenu


-- 
~Randy
