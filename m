From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 7 Jan 2013 14:15:13 +0100
Subject: [PATCH] Add apf51 basic support
In-Reply-To: <20130107130137.GA29281@S2101-09.ap.freescale.net>
References: <1355694591-7084-1-git-send-email-laurent.cans@gmail.com>
 <20121219203936.GG26326@pengutronix.de>
 <20130103083534.GD2566@S2101-09.ap.freescale.net>
 <CAA1eMkFXVy9ti6o7nVZNtrMm=-ymaZhEKxvPRzWj9Uqp=HDt=Q@mail.gmail.com>
 <20130107130137.GA29281@S2101-09.ap.freescale.net>
Message-ID: <20130107131513.GK1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 09:01:39PM +0800, Shawn Guo wrote:
> On Sun, Jan 06, 2013 at 05:19:13PM +0100, Laurent CANS wrote:
> > 2013/1/3 Shawn Guo <shawn.guo@linaro.org>:
> > > On Wed, Dec 19, 2012 at 09:39:36PM +0100, Sascha Hauer wrote:
> > >> On Sun, Dec 16, 2012 at 10:49:51PM +0100, Laurent Cans wrote:
> > >> > Signed-off-by: Laurent Cans <laurent.cans@gmail.com>
> > >> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> > >> > ---
> > >> > +   clocks {
> > >> > +           #address-cells = <1>;
> > >> > +           #size-cells = <0>;
> > >> > +
> > >> > +           ckih1 {
> > >> > +                   compatible = "fsl,imx-ckih1", "fixed-clock";
> > >> > +                   clock-frequency = <0>;
> > >> > +           };
> > >> > +
> > >> > +           osc {
> > >> > +                   compatible = "fsl,imx-osc", "fixed-clock";
> > >> > +                   clock-frequency = <33554432>;
> > >> > +           };
> > >>
> > >> These compatible properties shouldn't be necessary, right?
> > >>
> > > Use node path instead?  But imx51 clock driver is already using
> > > compatible property to identify the clocks.
> > >
> > > Shawn
> > >
> > 
> > Hi shawn,
> > 
> > I don't understand your remarks.
> > 
> Or I misunderstood Sascha's comment?  I thought he was asking you to
> remove those compatible properties, and I do not understand how that
> would work, since clock code is looking for the node using the
> compatible property.

What I meant is that the compatible properties are already in the dtsi
file and thus can be removed from the dts.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
