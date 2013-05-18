From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 18 May 2013 08:57:41 +0200 (CEST)
Subject: [PATCH v3 09/20] ARM: shmobile: r8a7790: Add GPIO controller
 devices to device tree
In-Reply-To: <14114689.gQXHdCTQYZ@avalon>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1368577100-3530-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <Pine.LNX.4.64.1305171423270.31481@axis700.grange>
 <14114689.gQXHdCTQYZ@avalon>
Message-ID: <Pine.LNX.4.64.1305180851320.9241@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent

On Sat, 18 May 2013, Laurent Pinchart wrote:

> Hi Guennadi,
> 
> On Friday 17 May 2013 14:26:48 Guennadi Liakhovetski wrote:
> > Hi Laurent
> > 
> > On Wed, 15 May 2013, Laurent Pinchart wrote:
> > > Add GPIO controller nodes to the r8a7790 core device tree.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/r8a7790.dtsi | 54 +++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 54 insertions(+)
> > 
> > Also here a couple of things are missing (presumably, for other SoCs you
> > need the same):
> 
> Thank you for testing the patch set. I'll integrate the modification in the 
> next version for r8a7778, r8a7779 and r8a7790.
> 
> As the gpio-ranges property specifies the number of GPIOs handled by the 
> controller, what's your opinion on dropping the #gpio-lines property from the 
> bindings ?

Well, gpio-ranges can contain several ranges, so, in a generic case you 
would have to sum them up to get a total count. But if you're ok with that 
or if your platforms only have 1 gpio gange per controller, of course, 
that property seems redundant. OTOH it is already used in r8a7779.dtsi, 
and thus already belongs to the ABI... Not sure whether removing it would 
be accepted.

Thanks
Guennadi

> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> > b/arch/arm/boot/dts/r8a7790.dtsi
> > index 674ee39..cd1a04f 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -51,6 +51,7 @@
> >  		interrupts = <0 4 0x4>;
> >  		#gpio-cells = <2>;
> >  		gpio-controller;
> > +		gpio-ranges = <&pfc 0 0 32>;
> >  	};
> > 
> >  	gpio1: gpio at ffc41000 {

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
