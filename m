From: marex@denx.de (Marek Vasut)
Date: Tue, 14 Jan 2014 14:17:03 +0100
Subject: [PATCH 4/7] drivers/pci/host: don't check resource with
 devm_ioremap_resource
In-Reply-To: <1389700739-3696-4-git-send-email-wsa@the-dreams.de>
References: <1389700739-3696-1-git-send-email-wsa@the-dreams.de>
 <1389700739-3696-4-git-send-email-wsa@the-dreams.de>
Message-ID: <201401141417.03349.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, January 14, 2014 at 12:58:55 PM, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

True that,

Acked-by: Marek Vasut <marex@denx.de>

> ---
> 
> Should go via subsystem tree
> 
>  drivers/pci/host/pci-imx6.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-imx6.c b/drivers/pci/host/pci-imx6.c
> index bd70af8..5002e23 100644
> --- a/drivers/pci/host/pci-imx6.c
> +++ b/drivers/pci/host/pci-imx6.c
> @@ -426,11 +426,6 @@ static int __init imx6_pcie_probe(struct
> platform_device *pdev) "imprecise external abort");
> 
>  	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!dbi_base) {
> -		dev_err(&pdev->dev, "dbi_base memory resource not found\n");
> -		return -ENODEV;
> -	}
> -
>  	pp->dbi_base = devm_ioremap_resource(&pdev->dev, dbi_base);
>  	if (IS_ERR(pp->dbi_base)) {
>  		ret = PTR_ERR(pp->dbi_base);

Best regards,
Marek Vasut
