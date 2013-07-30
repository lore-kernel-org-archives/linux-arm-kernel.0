From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 30 Jul 2013 15:55:01 +0100
Subject: [Patch V2 4/4] ARM: dts: AM33XX: update rtc node compatibility
In-Reply-To: <51F749B0.7020802@ti.com>
References: <1372841225-18813-1-git-send-email-gururaja.hebbar@ti.com>
 <1372841225-18813-5-git-send-email-gururaja.hebbar@ti.com>
 <51F749B0.7020802@ti.com>
Message-ID: <20130730145501.GA29859@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 06:05:52AM +0100, Gururaja Hebbar wrote:
> Hi,
> 
> On 7/3/2013 2:17 PM, Hebbar Gururaja wrote:
> > Since AM33xx  RTC IP has RTC_IRQWAKEEN to support Alarm Wake-up.
> >
> > Update the rtc compatible property to "ti,am3352-rtc" to enable handling
> > of this feature inside rtc-omap driver.
> 
> The other 2 rtc driver related patches have been pulled up. If you have 
> no comments, can you please pull this up.
> 
> Regards
> Gururaja
> 
> >
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> > ---
> > :100644 100644 77aa1b0... dde180a... M	arch/arm/boot/dts/am33xx.dtsi
> >   arch/arm/boot/dts/am33xx.dtsi |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index 77aa1b0..dde180a 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -297,7 +297,7 @@
> >   		};
> >
> >   		rtc at 44e3e000 {
> > -			compatible = "ti,da830-rtc";
> > +			compatible = "ti,am3352-rtc";

Given that this is backwards compatible with the old binding, it would
be nicer to have this as:

	compatible = "ti,am3352-rtc", "ti,da830-rtc";

We must get into the habit of changing dts files in a
backwards-compatible fashion.

Thanks,
Mark.
