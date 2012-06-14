From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Thu, 14 Jun 2012 08:48:20 -0700
Subject: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
In-Reply-To: <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120614154820.GG17140@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 03:59:24PM +0530, Santosh Shilimkar wrote:
> From: Aneesh V <aneesh@ti.com>
> 
> Device tree support for the EMIF driver.
> 
> Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Aneesh V <aneesh@ti.com>
> [santosh.shilimkar at ti.com: Rebased against 3.5-rc]
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Am I the memory maintainer now taking these patches?

> @@ -1267,7 +1534,13 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
>  	struct resource		*res;
>  	int			irq;
>  
> -	emif = get_device_details(pdev);
> +#if defined(CONFIG_OF)
> +	if (pdev->dev.of_node)
> +		emif = of_get_device_details(pdev->dev.of_node, &pdev->dev);
> +	else
> +#endif
> +		emif = get_device_details(pdev);
> +

Can't you do this without the #ifdef?

thanks,

greg k-h
