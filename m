From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 30 Apr 2014 09:10:44 +0200
Subject: [PATCH 2/3] arm: dts: imx6* Add clock-names for all ssi nodes
In-Reply-To: <20140430064104.GE16727@dragon>
References: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
 <1398694356-22511-3-git-send-email-mpa@pengutronix.de>
 <20140430064104.GE16727@dragon>
Message-ID: <20140430071044.GI15179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 30, 2014 at 02:41:06PM +0800, Shawn Guo wrote:
> On Mon, Apr 28, 2014 at 04:12:35PM +0200, Markus Pargmann wrote:
> > There are two possible clocks now, baud and ipg. To avoid any issues,
> > add clock-names to all ssi device nodes.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 3 +++
> >  arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> > index b230c09..288c76e 100644
> > --- a/arch/arm/boot/dts/imx6qdl.dtsi
> > +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> > @@ -257,6 +257,7 @@
> >  					reg = <0x02028000 0x4000>;
> >  					interrupts = <0 46 IRQ_TYPE_LEVEL_HIGH>;
> >  					clocks = <&clks 178>;
> > +					clock-names = "ipg";
> 
> I'd like to make such change at the time when we have multiple clocks to
> define here.

Currently the fsl-ssi code acquires the clock using
"devm_clk_get(dev, NULL)" and later another clock using a clock name
"baud". I would like to have a clock-names property so that it does not
depend on the order of the clocks in the "clocks" property.

However I will have a look at the clocks and add a correct baudclock and
send a new version.

Thanks,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140430/2fdeb098/attachment.sig>
