From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 3 Jan 2018 16:08:30 +0100
Subject: [PATCH net-next 1/6] phy: add 2.5G SGMII mode to the phy_mode enum
In-Reply-To: <20180103143541.GE21727@kwain>
References: <20171227221446.18459-1-antoine.tenart@free-electrons.com>
 <20171227221446.18459-2-antoine.tenart@free-electrons.com>
 <20171228072053.GA27336@lunn.ch> <20171228100656.GF2626@kwain>
 <91838ce5-a1a8-c41a-36e8-bef7adaf82fd@gmail.com>
 <20180103143541.GE21727@kwain>
Message-ID: <20180103150830.GB3401@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > >>> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> > >>> index 4f8423a948d5..70459a28f3a1 100644
> > >>> --- a/include/linux/phy/phy.h
> > >>> +++ b/include/linux/phy/phy.h
> > >>> @@ -28,6 +28,7 @@ enum phy_mode {
> > >>>  	PHY_MODE_USB_DEVICE,
> > >>>  	PHY_MODE_USB_OTG,
> > >>>  	PHY_MODE_SGMII,
> > >>> +	PHY_MODE_SGMII_2_5G,
> > >>>  	PHY_MODE_10GKR,
> > >>>  	PHY_MODE_UFS_HS_A,
> > >>>  	PHY_MODE_UFS_HS_B,
> > >>
> > >> There was a discussion maybe last month about adding 2.5G SGMII. I
> > >> would prefer 2500SGMII. Putting the number first makes it uniform with
> > >> the other defines, 1000BASEX, 25000BASEX, 10GKR.
> > > 
> > > Good to know. I wasn't completely sure how to name this mode properly,
> > > but I'm fine with PHY_MODE_2500SGMII. I'll update the patches and send a
> > > v2 (without the dt part).
> > 
> > And since you are respinning, please make sure you update phy_modes() in
> > the same header file as well as
> > Documentation/devicetree/bindings/net/ethernet.txt with the newly added
> > PHY interface mode.
> 
> Actually it's a generic PHY mode I'm adding, not a network PHY mode.
> There's no phy_modes() function for generic PHYs (and this 2500BaseX
> mode already is supported in the network PHY modes).

Hi Antoine

Don't you need it in both include/linux/phy/phy.h and
include/linux/phy.h?

	Andrew
