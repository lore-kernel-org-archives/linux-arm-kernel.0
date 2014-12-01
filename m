From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 1 Dec 2014 12:48:12 +0000
Subject: [PATCH] mfd: atmel-hlcdc: Add Kconfig option description and name
In-Reply-To: <1417431156-4914-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417431156-4914-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141201124812.GB12068@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 01 Dec 2014, Boris Brezillon wrote:

> The MFD_ATMEL_HLCDC was first intended to be selected by its sub-devices
> but these sub-devices now depends on this option, we thus need to add
> a name and a description so that users can see it.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/mfd/Kconfig | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index c9200d3..4a637f4 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -60,10 +60,15 @@ config MFD_AAT2870_CORE
>  	  functionality of the device.
>  
>  config MFD_ATMEL_HLCDC
> -	tristate
> +	tristate "Atmel HLCDC (High-end LCD Controller)"
>  	select MFD_CORE
>  	select REGMAP_MMIO
>  	depends on OF
> +	help
> +	  If you say yes here you get support for the HLCDC block.
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the
> +	  functionality of the device.
>  
>  config MFD_BCM590XX
>  	tristate "Broadcom BCM590xx PMUs"

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
