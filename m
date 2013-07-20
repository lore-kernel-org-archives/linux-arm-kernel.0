From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 20 Jul 2013 06:44:39 +0100
Subject: [PATCH] of: match the compatible in the order set by the dts file
In-Reply-To: <51DBC58D.90002@freescale.com>
References: <1373013818-11365-1-git-send-email-b32955@freescale.com>
 <20130709070541.GQ516@pengutronix.de> <51DBBFDA.70302@freescale.com>
 <20130709075124.GR516@pengutronix.de> <51DBC58D.90002@freescale.com>
Message-ID: <20130720054439.308B33E13F0@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 9 Jul 2013 16:10:53 +0800, Huang Shijie <b32955@freescale.com> wrote:
> ??? 2013???07???09??? 15:51, Sascha Hauer ??????:
> > On Tue, Jul 09, 2013 at 03:46:34PM +0800, Huang Shijie wrote:
> >> ??? 2013???07???09??? 15:05, Sascha Hauer ??????:
> >>> Why don't you set the matching order in the driver the way you want it
> >>> to be, i.e.:
> >>>
> >>> 	{ .compatible = "fsl,imx6q-uart", ... },
> >>> 	{ .compatible = "fsl,imx21-uart", ... },
> >>> 	{ .compatible = "fsl,imx1-uart", ... },
> >>>
> >> yes. i can set it like this.
> >>
> >> but this method looks like a ugly workaround.
> > If a driver has different ways of supporting a single device, then
> > putting the preferred or most feature rich on top doesn't look very ugly
> > to me.
> this method makes it much _coupled_ between the driver and the dts file.
> 
> IMHO, it's an unnecessary _burden_ to the driver programmer:
>     he should puts the most feature compatible on the top.
> 
> it's much graceful if we let the driver programmer be transparent about 
> this.

Absolutely true. Applied, thanks.

g.
