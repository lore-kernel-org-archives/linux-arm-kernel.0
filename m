From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 7 Jan 2013 21:01:39 +0800
Subject: [PATCH] Add apf51 basic support
In-Reply-To: <CAA1eMkFXVy9ti6o7nVZNtrMm=-ymaZhEKxvPRzWj9Uqp=HDt=Q@mail.gmail.com>
References: <1355694591-7084-1-git-send-email-laurent.cans@gmail.com>
 <20121219203936.GG26326@pengutronix.de>
 <20130103083534.GD2566@S2101-09.ap.freescale.net>
 <CAA1eMkFXVy9ti6o7nVZNtrMm=-ymaZhEKxvPRzWj9Uqp=HDt=Q@mail.gmail.com>
Message-ID: <20130107130137.GA29281@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 06, 2013 at 05:19:13PM +0100, Laurent CANS wrote:
> 2013/1/3 Shawn Guo <shawn.guo@linaro.org>:
> > On Wed, Dec 19, 2012 at 09:39:36PM +0100, Sascha Hauer wrote:
> >> On Sun, Dec 16, 2012 at 10:49:51PM +0100, Laurent Cans wrote:
> >> > Signed-off-by: Laurent Cans <laurent.cans@gmail.com>
> >> > Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> >> > ---
> >> > +   clocks {
> >> > +           #address-cells = <1>;
> >> > +           #size-cells = <0>;
> >> > +
> >> > +           ckih1 {
> >> > +                   compatible = "fsl,imx-ckih1", "fixed-clock";
> >> > +                   clock-frequency = <0>;
> >> > +           };
> >> > +
> >> > +           osc {
> >> > +                   compatible = "fsl,imx-osc", "fixed-clock";
> >> > +                   clock-frequency = <33554432>;
> >> > +           };
> >>
> >> These compatible properties shouldn't be necessary, right?
> >>
> > Use node path instead?  But imx51 clock driver is already using
> > compatible property to identify the clocks.
> >
> > Shawn
> >
> 
> Hi shawn,
> 
> I don't understand your remarks.
> 
Or I misunderstood Sascha's comment?  I thought he was asking you to
remove those compatible properties, and I do not understand how that
would work, since clock code is looking for the node using the
compatible property.

Shawn

> The method used to define clocks is incorrect? What is the recommended
> method to define clocks?
> 
> Laurent
