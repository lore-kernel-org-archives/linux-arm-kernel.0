From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 28 Dec 2017 11:06:57 +0100
Subject: [PATCH net-next 1/6] phy: add 2.5G SGMII mode to the phy_mode enum
In-Reply-To: <20171228072053.GA27336@lunn.ch>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-2-antoine.tenart@free-electrons.com>
 <20171228072053.GA27336@lunn.ch>
Message-ID: <20171228100656.GF2626@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Dec 28, 2017 at 08:20:53AM +0100, Andrew Lunn wrote:
> On Wed, Dec 27, 2017 at 11:14:41PM +0100, Antoine Tenart wrote:
> > This patch adds one more generic PHY mode to the phy_mode enum, to allow
> > configuring generic PHYs to the 2.5G SGMII mode by using the set_mode
> > callback.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  include/linux/phy/phy.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > index 4f8423a948d5..70459a28f3a1 100644
> > --- a/include/linux/phy/phy.h
> > +++ b/include/linux/phy/phy.h
> > @@ -28,6 +28,7 @@ enum phy_mode {
> >  	PHY_MODE_USB_DEVICE,
> >  	PHY_MODE_USB_OTG,
> >  	PHY_MODE_SGMII,
> > +	PHY_MODE_SGMII_2_5G,
> >  	PHY_MODE_10GKR,
> >  	PHY_MODE_UFS_HS_A,
> >  	PHY_MODE_UFS_HS_B,
> 
> There was a discussion maybe last month about adding 2.5G SGMII. I
> would prefer 2500SGMII. Putting the number first makes it uniform with
> the other defines, 1000BASEX, 25000BASEX, 10GKR.

Good to know. I wasn't completely sure how to name this mode properly,
but I'm fine with PHY_MODE_2500SGMII. I'll update the patches and send a
v2 (without the dt part).

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
