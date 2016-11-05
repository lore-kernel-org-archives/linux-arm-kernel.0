From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Sat, 5 Nov 2016 10:51:13 +0530
Subject: [PATCH v2 2/3] phy: da8xx-usb: rename the ohci device to
 ohci-da8xx
In-Reply-To: <20161103160308.29588-3-ahaslam@baylibre.com>
References: <20161103160308.29588-1-ahaslam@baylibre.com>
 <20161103160308.29588-3-ahaslam@baylibre.com>
Message-ID: <e8bfd316-efe5-5ab5-99ea-b84539fbf8c7@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Thursday 03 November 2016 09:33 PM, Axel Haslam wrote:
> The ohci device name has changed in the board configuraion files,
> hence, change the phy lookup table to match the new name.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

merged, thanks.

-Kishon
> ---
>  drivers/phy/phy-da8xx-usb.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-da8xx-usb.c b/drivers/phy/phy-da8xx-usb.c
> index 32ae78c..c85fb0b 100644
> --- a/drivers/phy/phy-da8xx-usb.c
> +++ b/drivers/phy/phy-da8xx-usb.c
> @@ -198,7 +198,8 @@ static int da8xx_usb_phy_probe(struct platform_device *pdev)
>  	} else {
>  		int ret;
>  
> -		ret = phy_create_lookup(d_phy->usb11_phy, "usb-phy", "ohci.0");
> +		ret = phy_create_lookup(d_phy->usb11_phy, "usb-phy",
> +					"ohci-da8xx");
>  		if (ret)
>  			dev_warn(dev, "Failed to create usb11 phy lookup\n");
>  		ret = phy_create_lookup(d_phy->usb20_phy, "usb-phy",
> @@ -216,7 +217,7 @@ static int da8xx_usb_phy_remove(struct platform_device *pdev)
>  
>  	if (!pdev->dev.of_node) {
>  		phy_remove_lookup(d_phy->usb20_phy, "usb-phy", "musb-da8xx");
> -		phy_remove_lookup(d_phy->usb11_phy, "usb-phy", "ohci.0");
> +		phy_remove_lookup(d_phy->usb11_phy, "usb-phy", "ohci-da8xx");
>  	}
>  
>  	return 0;
> 
