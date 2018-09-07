From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 7 Sep 2018 15:38:04 +0200
Subject: [PATCH 09/10] phy: Add Cadence D-PHY support
In-Reply-To: <1838745.9zNmGlpGXc@avalon>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <d50a5f0750647dcc09ef52411641b628161b362e.1536138624.git-series.maxime.ripard@bootlin.com>
 <1838745.9zNmGlpGXc@avalon>
Message-ID: <20180907133804.ktpth3n4uft6fvl6@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 04:48:27PM +0300, Laurent Pinchart wrote:
> Hi Maxime,
> 
> Thank you for the patch.
> 
> On Wednesday, 5 September 2018 12:16:40 EEST Maxime Ripard wrote:
> > Cadence has designed a D-PHY that can be used by the, currently in tree,
> > DSI bridge (DRM), CSI Transceiver and CSI Receiver (v4l2) drivers.
> > 
> > Only the DSI driver has an ad-hoc driver for that phy at the moment, while
> > the v4l2 drivers are completely missing any phy support. In order to make
> > that phy support available to all these drivers, without having to
> > duplicate that code three times, let's create a generic phy framework
> > driver.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >  drivers/phy/Kconfig             |   1 +-
> >  drivers/phy/Makefile            |   1 +-
> >  drivers/phy/cadence/Kconfig     |  13 +-
> >  drivers/phy/cadence/Makefile    |   1 +-
> >  drivers/phy/cadence/cdns-dphy.c | 499 +++++++++++++++++++++++++++++++++-
> 
> Should the DT bindings be split from Documentation/devicetree/bindings/
> display/bridge/cdns,dsi.txt ?

Yep, I'll change it.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180907/2442119b/attachment-0001.sig>
