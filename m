From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 11 Dec 2016 10:40:18 +0100
Subject: [RFC PATCH 2/2] ARM: i.MX: dts: add fsl, imx25-wdt compatible to
 all relevant watchdog nodes
In-Reply-To: <20160926062759.3eoezyezog6clz6x@pengutronix.de>
References: <1474850361-20884-1-git-send-email-vz@mleia.com>
 <1474850361-20884-3-git-send-email-vz@mleia.com>
 <20160926062759.3eoezyezog6clz6x@pengutronix.de>
Message-ID: <20161211094018.zechblje3pburxx3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Sep 26, 2016 at 08:27:59AM +0200, Uwe Kleine-K?nig wrote:
> On Mon, Sep 26, 2016 at 03:39:21AM +0300, Vladimir Zapolskiy wrote:
> > Watchdog device controller found on all modern SoCs from i.MX series
> > and firstly introduced in i.MX25 is not one in one compatible with the
> > watchdog controllers on i.MX21, i.MX27 and i.MX31, the latter
> > controlles don't have WICR (and pretimeout notification support) and
> > WMCR registers. To get benefit from the more advanced watchdog device
> > and to avoid operations over non-existing registers on legacy SoCs add
> > fsl,imx25-wdt compatible to descriptions of all i.MX25 compatible
> > watchdog controllers.
> > 
> > Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> > ---
> >  arch/arm/boot/dts/imx35.dtsi   |  3 ++-
> >  arch/arm/boot/dts/imx50.dtsi   |  3 ++-
> >  arch/arm/boot/dts/imx51.dtsi   |  6 ++++--
> >  arch/arm/boot/dts/imx53.dtsi   |  6 ++++--
> >  arch/arm/boot/dts/imx6qdl.dtsi |  6 ++++--
> >  arch/arm/boot/dts/imx6sl.dtsi  |  6 ++++--
> >  arch/arm/boot/dts/imx6sx.dtsi  |  9 ++++++---
> >  arch/arm/boot/dts/imx6ul.dtsi  |  6 ++++--
> >  arch/arm/boot/dts/imx7s.dtsi   | 12 ++++++++----
> >  arch/arm/boot/dts/ls1021a.dtsi |  2 +-
> >  arch/arm/boot/dts/vfxxx.dtsi   |  3 ++-
> >  11 files changed, 41 insertions(+), 21 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
> > index 490b7b4..8fd4482 100644
> > --- a/arch/arm/boot/dts/imx35.dtsi
> > +++ b/arch/arm/boot/dts/imx35.dtsi
> > @@ -284,7 +284,8 @@
> >  			};
> >  
> >  			wdog: wdog at 53fdc000 {
> > -				compatible = "fsl,imx35-wdt", "fsl,imx21-wdt";
> > +				compatible = "fsl,imx35-wdt", "fsl,imx25-wdt",
> > +					     "fsl,imx21-wdt";
> 
> When this is used on an old kernel that doesn't know about fsl,imx25-wdt
> this picks up the imx21 driver logic. As this is wrong I think you
> should drop imx21-wdt here. Can one of the dt-people comfirm?

I forgot in the mail at the other end of this thread that the dti were
already addressed. I (implicitly) wrote there that fsl,imx35-wdt should
be the new compatible describing the wdt with misc register. Picking
imx25 (as you did) works, too, but e.g. the CSPI device has

	compatible = "fsl,imx25-cspi", "fsl,imx35-cspi";

on the i.MX25 and

	compatible = "fsl,imx35-cspi";

on the i.MX35. So I think we should pick i.MX35 here, too, as the one
giving its name.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
