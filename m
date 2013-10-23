From: peter.chen@freescale.com (Peter Chen)
Date: Wed, 23 Oct 2013 14:54:45 +0800
Subject: [Patch v2 13/14] usb: phy-mxs: Add implementation of set_wakeup
In-Reply-To: <20131023063521.GH2839@S2101-09.ap.freescale.net>
References: <1382421528-17897-1-git-send-email-peter.chen@freescale.com>
 <1382421528-17897-14-git-send-email-peter.chen@freescale.com>
 <20131023063521.GH2839@S2101-09.ap.freescale.net>
Message-ID: <20131023065444.GG8534@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 02:35:23PM +0800, Shawn Guo wrote:
> >  
> > +static void mxs_phy_disconnect_line(struct mxs_phy *mxs_phy, bool on)
> > +{
> > +	void __iomem *base = mxs_phy->phy.io_priv;
> > +	bool vbus_is_on = false;
> > +	static bool line_is_disconnected;
> > +	unsigned int vbus_value = 0;
> > +
> > +	/* Only the SoCs have anatop need below operation */
> > +	if (!mxs_phy->disconnect_line_without_vbus_is_needed)
> > +		return;
> 
> As per the comment, shouldn't the if-clause be the following?  Or is the
> comment incorrect?
> 
> 	if (!mxs_phy->regmap_anatop)
> 
> Shawn
> 

Thanks,

I will change the comment to 
	/* If the SoC doesn't need to disconnect line without vbus, quit */

-- 

Best Regards,
Peter Chen
