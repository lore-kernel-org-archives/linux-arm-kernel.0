From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 2 Jul 2013 06:14:30 +0000
Subject: [PATCH 4/4] ARM: dts: AM33XX: update rtc node compatibility
In-Reply-To: <51D26F61.7080308@ti.com>
References: <1372412109-986-1-git-send-email-gururaja.hebbar@ti.com>
 <1372412109-986-5-git-send-email-gururaja.hebbar@ti.com>
 <51D26F61.7080308@ti.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EC4E7E6@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 02, 2013 at 11:42:49, Nori, Sekhar wrote:
> Changing to Benoit's gmail id since he apparently wont access TI mail
> anymore.
> 
> On 6/28/2013 3:05 PM, Hebbar Gururaja wrote:
> > Since AM33xx  RTC IP has RTC_IRQWAKEEN to support Alarm Wake-up.
> > 
> > Update the rtc compatible property to "ti,am3352-rtc" to enable handling
> > of this feature inside rtc-omap driver.
> > 
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Sekhar Nori <nsekhar@ti.com>
> > Cc: Kevin Hilman <khilman@linaro.org>
> > Cc: b-cousson at ti.com
> > ---
> > :100644 100644 77aa1b0... dde180a... M	arch/arm/boot/dts/am33xx.dtsi
> >  arch/arm/boot/dts/am33xx.dtsi |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index 77aa1b0..dde180a 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -297,7 +297,7 @@
> >  		};
> >  
> >  		rtc at 44e3e000 {
> > -			compatible = "ti,da830-rtc";
> > +			compatible = "ti,am3352-rtc";
> 
> compatible is a list so you can instead do:
> 	
> 	compatible = "ti,am3352-rtc", "ti,da830-rtc";
> 
> That way the dts works irrespective of driver updates. When driver
> supports enhanced features of hardware, they are available to the user
> else the basic functionality still works.

Ok. I will update the same now in v2.

> 
> Thanks,
> Sekhar
> 


Regards, 
Gururaja
