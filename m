From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 7 Dec 2013 16:16:23 +0200
Subject: [PATCH v4 4/4] USB: OMAP1: Tahvo USB transceiver driver
In-Reply-To: <20131206204629.GL21086@saruman.home>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
 <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
 <20131206204629.GL21086@saruman.home>
Message-ID: <20131207141623.GL30823@blackmetal.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Dec 06, 2013 at 02:46:29PM -0600, Felipe Balbi wrote:
> On Fri, Dec 06, 2013 at 04:13:07PM +0200, Aaro Koskinen wrote:
> > Add Tahvo USB transceiver driver.
> > 
> > Based on old code from linux-omap tree. The original driver was written
> > by Juha Yrj?l?, Tony Lindgren, and Timo Ter?s.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> compile error:

[...]

> fixed it up with:
>
> diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
> index 7cf1766..8bb833e 100644
> --- a/drivers/usb/phy/phy-tahvo.c
> +++ b/drivers/usb/phy/phy-tahvo.c
> @@ -368,7 +368,9 @@ static int tahvo_usb_probe(struct platform_device *pdev)
>  
>  	tu->extcon.name = DRIVER_NAME;
>  	tu->extcon.supported_cable = tahvo_cable;
> -	ret = extcon_dev_register(&tu->extcon, &pdev->dev);
> +	tu->extcon.dev.parent = &pdev->dev;
> +
> +	ret = extcon_dev_register(&tu->extcon);
>  	if (ret) {
>  		dev_err(&pdev->dev, "could not register extcon device: %d\n",
>  			ret);
> 
> please make sure it still works with v3.13-rc2 + this patch.

Yes, that works fine with 3.13-rc2. Sorry for this, I was accidentally
testing & basing these patches on an old branch.

A.
