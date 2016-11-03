From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 3 Nov 2016 22:20:01 +0530
Subject: [PATCH 2/3] phy: da8xx-usb: rename the ohci device to ohci-da8xx
In-Reply-To: <20161102124435.31777-3-ahaslam@baylibre.com>
References: <20161102124435.31777-1-ahaslam@baylibre.com>
 <20161102124435.31777-3-ahaslam@baylibre.com>
Message-ID: <fd6b848d-9740-70ef-6850-7f6a64e66bfb@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wednesday 02 November 2016 06:14 PM, Axel Haslam wrote:
> There is only one ohci on the da8xx series of chips,
> so remove the ".0" when creating the phy. Also add
> the "-da8xx" postfix to be consistent across davinci
> usb drivers.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
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
