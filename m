From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Thu, 30 Apr 2015 12:08:53 +0100
Subject: [PATCH v2] ARM: vexpress: Add unified-cache Device Tree property
In-Reply-To: <20150429191228.GO15254@pengutronix.de>
References: <5509437E.6060806@arm.com>
 <1426671298-2012-1-git-send-email-r.schwebel@pengutronix.de>
 <20150429191228.GO15254@pengutronix.de>
Message-ID: <20150430110853.GN7440@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 29, 2015 at 08:12:28PM +0100, Robert Schwebel wrote:
> Hi Liviu,
> 
> On Wed, Mar 18, 2015 at 10:34:58AM +0100, Robert Schwebel wrote:
> > Without this property, we get this boot warning:
> > 
> > "L2C: device tree omits to specify unified cache"
> > 
> > Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  arch/arm/boot/dts/vexpress-v2p-ca9.dts | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Changes since v1:
> >  * fix typo in patch description
> > 
> > diff --git a/arch/arm/boot/dts/vexpress-v2p-ca9.dts b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > index 23662b5..a411274 100644
> > --- a/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > +++ b/arch/arm/boot/dts/vexpress-v2p-ca9.dts
> > @@ -170,6 +170,7 @@
> >  		compatible = "arm,pl310-cache";
> >  		reg = <0x1e00a000 0x1000>;
> >  		interrupts = <0 43 4>;
> > +		cache-unified;
> >  		cache-level = <2>;
> >  		arm,data-latency = <1 1 1>;
> >  		arm,tag-latency = <1 1 1>;
> > -- 
> > 2.1.4
> 
> Gentle ping, this patch didn't make it into 4.1-rc1.

Sorry Robert, this fell through the cracks. VExpress gets very few
patches in general and we're new to this :(

Arnd/Olof, can we add this and Sudeep's patch for Juno into one of the
later 4.1-rc pull requests?

Best regards,
Liviu

> 
> rsc
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
