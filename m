From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 20 Nov 2014 10:19:43 +0100
Subject: [PATCH 2/7] mfd: MT6397: Add regmap for MT8135 and MT6397 SoC
In-Reply-To: <20141119170454.GJ1875@x1>
References: <1416210027-5562-1-git-send-email-flora.fu@mediatek.com>
 <1416210027-5562-3-git-send-email-flora.fu@mediatek.com>
 <20141118114645.GX24004@x1> <20141118134618.GF30369@pengutronix.de>
 <20141119170454.GJ1875@x1>
Message-ID: <20141120091943.GJ30369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 05:04:54PM +0000, Lee Jones wrote:
> On Tue, 18 Nov 2014, Sascha Hauer wrote:
> 
> > On Tue, Nov 18, 2014 at 11:46:45AM +0000, Lee Jones wrote:
> > > On Mon, 17 Nov 2014, Flora Fu wrote:
> > > 
> > > > Add PMIC wrapper of MT8135 to access MFD MT6397.
> > > > This is regmap of MT6397 MFD.
> > > > 
> > > > Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> > > > ---
> > > >  drivers/mfd/Kconfig            |   8 +
> > > >  drivers/mfd/Makefile           |   1 +
> > > >  drivers/mfd/mt8135-pmic-wrap.c | 847 +++++++++++++++++++++++++++++++++++++++++
> > > 
> > > All of the PMIC functionality needs removing from MFD and placed
> > > somewhere else.  I suggest either drivers/power or drivers/regulator.
> > 
> > This is no PMIC functionality. The MT8135 has a unit which is is used to
> > access the PMIC (which is not only a PMIC, but also Touchscreen
> > interface and other stuff). This unit is called pmic-wrapper in the
> > docs. See the introductory mail for a nice picture.
> 
> I saw the picture, it's very nice.  Whatever this is, it's not an
> MFD.  It's a device which is located on an MFD.  There is far too much
> functional (the operative word here) code contained in this patch.

The MT6397 is a classical MFD device. It has a PMIC, an audio amp and a
RTC. It is very tightly coupled to the SoC via SPI, but the SPI itself
is not directly visible on the SoC. It's accessible indirectly via the
PMIC-wrapper. Indeed the PMIC-wrapper is not MFD. Another dumping ground
that comes to my mind is drivers/soc/. We could move over there.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
