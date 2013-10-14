From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 14 Oct 2013 09:36:52 +0800
Subject: [PATCH 05/12] usb: phy-mxs: Add implementation of
 nofity_suspend and notify_resume
In-Reply-To: <201310121142.07174.marex@denx.de>
References: <1381568986-19802-1-git-send-email-peter.chen@freescale.com>
 <1381568986-19802-6-git-send-email-peter.chen@freescale.com>
 <201310121142.07174.marex@denx.de>
Message-ID: <20131014013651.GD3879@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 12, 2013 at 11:42:06AM +0200, Marek Vasut wrote:
> Dear Peter Chen,
> 
> > Add notify_suspend and notify_resume according to different SoCs.
> > 
> > Signed-off-by: Peter Chen <peter.chen@freescale.com>
> > ---
> >  drivers/usb/phy/phy-mxs-usb.c |   73
> > +++++++++++++++++++++++++++++++++++++++++ 1 files changed, 73
> > insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> > index e0b0de0..8661dae 100644
> > --- a/drivers/usb/phy/phy-mxs-usb.c
> > +++ b/drivers/usb/phy/phy-mxs-usb.c
> > @@ -197,6 +197,78 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
> >  	return 0;
> >  }
> > 
> > +static int mxs_phy_on_suspend_workaround(struct usb_phy *phy,
> > +		enum usb_device_speed speed)
> > +{
> > +	dev_dbg(phy->dev, "%s speed device has suspended\n",
> > +		(speed == USB_SPEED_HIGH) ? "high" : "non-high");
> 
> HS : FS/LS you mean?

Yes, it is what I mean.
OK, I will change to HS and FS/LS.

> 
> > +/*
> > + * For mxs PHY, there are two PHY issues related to suspend/resume.
> > + * For mx23 and mx28, both of two issues are existed.
> > + * For mx6q and mx6dl, only one issue is existed.
> > + * For mx6 sololite, none issue is existed.
> > + */
> > +static void mxs_phy_workaround(struct mxs_phy *mxs_phy)
> > +{
> > +	if (is_mx23_phy(mxs_phy)) {
> 
> This is_mx23_phy() returns 1 for mx28 too? It's not too clear, not even from the 
> comment above, a short comment here would help for sure.

mx23 and mx28 PHY are the same PHY, so the fixes are the same.
Anything I need to add?

-- 

Best Regards,
Peter Chen
