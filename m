From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Dec 2013 17:06:57 +0800
Subject: [PATCH 2/2] ARM: dts: Add support for the i.MX35.
In-Reply-To: <20131219073843.GV24559@pengutronix.de>
References: <1387375826-4018-1-git-send-email-s.hauer@pengutronix.de>
 <1387375826-4018-3-git-send-email-s.hauer@pengutronix.de>
 <20131219064957.GZ6691@S2101-09.ap.freescale.net>
 <20131219073843.GV24559@pengutronix.de>
Message-ID: <20131219090655.GE6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 08:38:44AM +0100, Sascha Hauer wrote:
> On Thu, Dec 19, 2013 at 02:49:59PM +0800, Shawn Guo wrote:
> > On Wed, Dec 18, 2013 at 03:10:26PM +0100, Sascha Hauer wrote:
> > > +	clocks {
> > > +		#address-cells = <1>;
> > > +		#size-cells = <0>;
> > > +
> > > +		ckil {
> > > +			compatible = "fsl,imx-ckil", "fixed-clock";
> > > +			clock-frequency = <32768>;
> > > +		};
> > > +
> > > +		osc {
> > > +			compatible = "fsl,imx-osc", "fixed-clock";
> > > +			clock-frequency = <24000000>;
> > > +		};
> > 
> > I asked the question in the last round, but did not get any answer.  Do
> > these two clocks exist on imx35?  At least from the imx35 clock code,
> > I do not see them.
> 
> ckil does exist, but it's optional, so I think if we specify it in the
> dtsi then the rate should be 0. It's unused in the code though and noone
> ever seemed to miss it, so we can equally well just drop it.
> osc does exist aswell, but in the code it's unused and a hardcoded 24MHz
> value is used, so specifying it in the devicetree is bogus.
> I think we should just drop the nodes.

Ok, I will fixed it up and apply.

Shawn
