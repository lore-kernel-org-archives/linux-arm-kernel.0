From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Nov 2013 12:04:14 +0800
Subject: [PATCH v3 11/11] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <20131105025916.GD13472@shlinux1.ap.freescale.net>
References: <1383616183-10511-1-git-send-email-peter.chen@freescale.com>
 <1383616183-10511-12-git-send-email-peter.chen@freescale.com>
 <20131105030513.GI19770@S2101-09.ap.freescale.net>
 <20131105025916.GD13472@shlinux1.ap.freescale.net>
Message-ID: <20131105040412.GM19770@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 05, 2013 at 10:59:17AM +0800, Peter Chen wrote:
> > > @@ -83,6 +90,15 @@
> > >   */
> > >  #define MXS_PHY_SENDING_SOF_TOO_FAST		BIT(2)
> > >  
> > > +/* imx23 style PHY */
> > > +#define MXS_PHY_IMX23				BIT(3)
> > > +
> > > +/* imx6q style PHY */
> > > +#define MXS_PHY_IMX6Q				BIT(4)
> > > +
> > > +/* imx6sl style PHY */
> > > +#define MXS_PHY_IMX6SL				BIT(5)
> > > +
> > 
> > We will not need these, if we do what I suggested to carry a pointer
> > to mxs_phy_data in mxs_phy.
> > 
> > struct mxs_phy {
> > 	...
> > 	struct mxs_phy_data *data;
> > };
> > 
> > The check then can be done like below.
> > 
> > static inline int is_imx6q_phy(struct mxs_phy *mxs_phy)
> > {
> >         return mxs_phy->data == &imx6q_phy_data;
> > }
> > 
> 
> What's the benefit compared to current one?

Save those pointless flags.

Shawn
