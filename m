From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 10 Mar 2011 11:45:19 +0000
Subject: [PATCH 2/8] macb: detect hclk presence from platform data
In-Reply-To: <20110310114137.GC6198@pulham.picochip.com>
References: <1299751843-9743-1-git-send-email-jamie@jamieiles.com>
	<1299751843-9743-3-git-send-email-jamie@jamieiles.com>
	<20110310101554.GD11273@n2100.arm.linux.org.uk>
	<20110310114137.GC6198@pulham.picochip.com>
Message-ID: <20110310114519.GD6198@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 11:41:37AM +0000, Jamie Iles wrote:
> diff --git a/drivers/net/macb.c b/drivers/net/macb.c
> index bfd3601..8e6d8e3 100644
> --- a/drivers/net/macb.c
> +++ b/drivers/net/macb.c
> @@ -246,9 +246,7 @@ static int macb_mii_init(struct macb *bp)
>  	bp->mii_bus->parent = &bp->dev->dev;
>  	pdata = bp->pdev->dev.platform_data;
>  
> -	if (pdata)
> -		bp->mii_bus->phy_mask = pdata->phy_mask;
> -
> +	bp->mii_bus->phy_mask = pdata->phy_mask;
>  	bp->mii_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
>  	if (!bp->mii_bus->irq) {
>  		err = -ENOMEM;

Doh, too hasty.  That hunk shouldn't be there now.  I'll fix that up for 
next time.

Jamie
