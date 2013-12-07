From: balbi@ti.com (Felipe Balbi)
Date: Sat, 7 Dec 2013 11:51:27 -0600
Subject: [PATCH v4 4/4] USB: OMAP1: Tahvo USB transceiver driver
In-Reply-To: <20131207141623.GL30823@blackmetal.musicnaut.iki.fi>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
 <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
 <20131206204629.GL21086@saruman.home>
 <20131207141623.GL30823@blackmetal.musicnaut.iki.fi>
Message-ID: <20131207175127.GA12628@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 07, 2013 at 04:16:23PM +0200, Aaro Koskinen wrote:
> > fixed it up with:
> >
> > diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
> > index 7cf1766..8bb833e 100644
> > --- a/drivers/usb/phy/phy-tahvo.c
> > +++ b/drivers/usb/phy/phy-tahvo.c
> > @@ -368,7 +368,9 @@ static int tahvo_usb_probe(struct platform_device *pdev)
> >  
> >  	tu->extcon.name = DRIVER_NAME;
> >  	tu->extcon.supported_cable = tahvo_cable;
> > -	ret = extcon_dev_register(&tu->extcon, &pdev->dev);
> > +	tu->extcon.dev.parent = &pdev->dev;
> > +
> > +	ret = extcon_dev_register(&tu->extcon);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "could not register extcon device: %d\n",
> >  			ret);
> > 
> > please make sure it still works with v3.13-rc2 + this patch.
> 
> Yes, that works fine with 3.13-rc2. Sorry for this, I was accidentally

cool, thanks :-)

> testing & basing these patches on an old branch.

no problem, s**t happens to everybody :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131207/5bd6d1f9/attachment.sig>
