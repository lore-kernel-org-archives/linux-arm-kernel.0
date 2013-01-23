From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 23 Jan 2013 17:19:34 +0100 (CET)
Subject: [PATCH 5/8] ARM: shmobile: add a GPIO controller DT node for
 sh7372
In-Reply-To: <4209290.uCBdrcvT3q@avalon>
References: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
 <1358356097-26180-6-git-send-email-g.liakhovetski@gmx.de>
 <4209290.uCBdrcvT3q@avalon>
Message-ID: <Pine.LNX.4.64.1301231714450.26301@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent

Thanks for your comments. All will be addressed except for this one:

On Mon, 21 Jan 2013, Laurent Pinchart wrote:

> Hi Guennadi,
> 
> Thanks for the patch.
> 
> On Wednesday 16 January 2013 18:08:14 Guennadi Liakhovetski wrote:
> > Add a missing GPIO controller node to sh7372.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> >  arch/arm/boot/dts/sh7372.dtsi |    8 ++++++++
> >  1 files changed, 8 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/sh7372.dtsi b/arch/arm/boot/dts/sh7372.dtsi
> > index 582fdec..7ca9322 100644
> > --- a/arch/arm/boot/dts/sh7372.dtsi
> > +++ b/arch/arm/boot/dts/sh7372.dtsi
> > @@ -19,6 +19,14 @@
> >  		};
> >  	};
> > 
> > +	gpio: pfc at e6050000 {
> > +		compatible = "renesas,pfc-sh7372";
> > +		reg = <0xe6050000 0x8000>,
> > +		      <0xe605800c 0x20>;
> 
> Shouldn't the second one be
> 
> 		      <0xe605800c 0x1c>;
> 
> > +		gpio-controller;
> > +		#gpio-cells = <2>;
> > +	};
> > +
> 
> I haven't checked the board files, have you made sure that the PFC device 
> won't be instantiated twice, once from DT and once from board code ?

Don't think so. board-mackerel.c uses DT in a really dull way - it doesn't 
call of_platform_populate(). It also initialises interrupts by calling 
sh7372_init_irq(), which would conflict with intc instances in sh7372.dtsi 
too, if the latter were used. And board-mackerel-reference.c doesn't 
register PFC internally.

Thanks
Guennadi

> 
> >  	soc {
> >  		compatible = "simple-bus";
> >  		#address-cells = <1>;
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
