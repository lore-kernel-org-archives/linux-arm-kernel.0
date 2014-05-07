From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 May 2014 16:57:39 -0500
Subject: [PATCH 3/7] phy: usb: sunxi: Introduce Allwinner A31 USB PHY
 support
In-Reply-To: <536A36A2.5030109@ti.com>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
 <1399434623-20383-4-git-send-email-maxime.ripard@free-electrons.com>
 <536A36A2.5030109@ti.com>
Message-ID: <20140507215739.GB7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 07, 2014 at 07:05:30PM +0530, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Wednesday 07 May 2014 09:20 AM, Maxime Ripard wrote:
> > The USB phy controller in the A31 differs mostly from the older controllers
> > because it has a clock dedicated for each phy, while the older ones were having
> > a single clock for all the phys.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/phy/phy-sun4i-usb.c | 35 ++++++++++++++++++++++++++---------
> >  1 file changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/phy/phy-sun4i-usb.c b/drivers/phy/phy-sun4i-usb.c
> > index e6e6c4ba7145..1d83abe07a29 100644
> > --- a/drivers/phy/phy-sun4i-usb.c
> > +++ b/drivers/phy/phy-sun4i-usb.c
> > @@ -61,16 +61,17 @@
> >  #define MAX_PHYS			3
> >  
> >  struct sun4i_usb_phy_data {
> > -	struct clk *clk;
> >  	void __iomem *base;
> >  	struct mutex mutex;
> >  	int num_phys;
> >  	u32 disc_thresh;
> > +	bool dedicated_clocks;
> 
> Don't think we need this structure member as it's been used only in probe.

Ah, right.

I'll change this in the next version.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/18a492da/attachment.sig>
