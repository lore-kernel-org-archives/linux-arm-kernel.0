From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 3 Jan 2013 16:35:36 +0800
Subject: [PATCH] Add apf51 basic support
In-Reply-To: <20121219203936.GG26326@pengutronix.de>
References: <1355694591-7084-1-git-send-email-laurent.cans@gmail.com>
 <20121219203936.GG26326@pengutronix.de>
Message-ID: <20130103083534.GD2566@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 09:39:36PM +0100, Sascha Hauer wrote:
> On Sun, Dec 16, 2012 at 10:49:51PM +0100, Laurent Cans wrote:
> > Signed-off-by: Laurent Cans <laurent.cans@gmail.com>
> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > ---
> > +	clocks {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		ckih1 {
> > +			compatible = "fsl,imx-ckih1", "fixed-clock";
> > +			clock-frequency = <0>;
> > +		};
> > +
> > +		osc {
> > +			compatible = "fsl,imx-osc", "fixed-clock";
> > +			clock-frequency = <33554432>;
> > +		};
> 
> These compatible properties shouldn't be necessary, right?
> 
Use node path instead?  But imx51 clock driver is already using
compatible property to identify the clocks.

Shawn
