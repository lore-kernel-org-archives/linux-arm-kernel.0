From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Mar 2014 13:30:09 -0700
Subject: [RESEND PATCH 1/1] arm: dts: am33xx: correcting dt node unit
 address for usb
In-Reply-To: <20140306152637.GB25648@saruman.home>
References: <1394109094-19205-1-git-send-email-mugunthanvnm@ti.com>
 <20140306152637.GB25648@saruman.home>
Message-ID: <20140313203009.GE5981@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [140306 07:33]:
> On Thu, Mar 06, 2014 at 06:01:34PM +0530, Mugunthan V N wrote:
> > DT node's unit address should be its own register offset address to make it a
> > unique across the system. This patch corrects the incorrect USB entries with
> > correct register offset for unit address.
> > 
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Felipe Balbi <balbi@ti.com>
> > Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> 
> Acked-by: Felipe Balbi <balbi@ti.com>

Applying into omap-for-v3.15/fixes with cc stable v3.12+. If somebody
wants it in earlier kernels it needs to be updated and posted
to the lists.

Regards,

Tony

> > This patch was posted long back (Aug. 30, 2013), below is the archive of the
> > orginal patch.
> > https://patchwork.kernel.org/patch/2852163/
> > 
> > ---
> >  arch/arm/boot/dts/am33xx.dtsi | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index 7073429..9770e35 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -453,7 +453,7 @@
> >  			ti,hwmods = "usb_otg_hs";
> >  			status = "disabled";
> >  
> > -			usb_ctrl_mod: control at 44e10000 {
> > +			usb_ctrl_mod: control at 44e10620 {
> >  				compatible = "ti,am335x-usb-ctrl-module";
> >  				reg = <0x44e10620 0x10
> >  					0x44e10648 0x4>;
> > @@ -556,7 +556,7 @@
> >  					"tx14", "tx15";
> >  			};
> >  
> > -			cppi41dma: dma-controller at 07402000 {
> > +			cppi41dma: dma-controller at 47402000 {
> >  				compatible = "ti,am3359-cppi41";
> >  				reg =  <0x47400000 0x1000
> >  					0x47402000 0x1000
> > -- 
> > 1.9.0
> > 
> 
> -- 
> balbi



> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
