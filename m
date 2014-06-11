From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 11 Jun 2014 15:40:16 +0900
Subject: [patch] char: xilinx_hwicap: missing error code if ioremap() fails
In-Reply-To: <20140611060433.GB7569@mwanda>
References: <20140611060433.GB7569@mwanda>
Message-ID: <000001cf8540$017e4f90$047aeeb0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 11, 2014 3:05 PM, Dan Carpenter wrote:
> 
> Return -ENOMEM instead of success if ioremap() fails.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han

> ---
> Static checker stuff, I can't compile this.
> 
> diff --git a/drivers/char/xilinx_hwicap/xilinx_hwicap.c b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> index f6345f9..9b1a5ac 100644
> --- a/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> +++ b/drivers/char/xilinx_hwicap/xilinx_hwicap.c
> @@ -661,6 +661,7 @@ static int hwicap_setup(struct device *dev, int id,
>  	drvdata->base_address = ioremap(drvdata->mem_start, drvdata->mem_size);
>  	if (!drvdata->base_address) {
>  		dev_err(dev, "ioremap() failed\n");
> +		retval = -ENOMEM;
>  		goto failed2;
>  	}
> 
