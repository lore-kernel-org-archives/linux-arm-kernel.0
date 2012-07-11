From: dinguyen@altera.com (Dinh Nguyen)
Date: Wed, 11 Jul 2012 10:20:26 -0500
Subject: [PATCH v2 1/2] clocksource: dw_apb_timer: Add common DTS glue
 for  dw_apb_timer
In-Reply-To: <20120710231525.GA27641@page>
References: <1341956381-496-1-git-send-email-dinguyen@altera.com>
 <20120710231525.GA27641@page>
Message-ID: <1342020026.4790.1.camel@dinguyen-VirtualBox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-07-11 at 00:15 +0100, Jamie Iles wrote:
> Hi,
> 
> On Tue, Jul 10, 2012 at 04:39:40PM -0500, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Make a common device tree glue for clocksource/dw_apb_timer.
> > Move mach-picoxcell/time.c to be a generic device tree application
> > of the dw_apb_timer.
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/dw-apb.txt   |   24 ++++++++++
> >  arch/arm/Kconfig                                   |    1 +
> >  drivers/clocksource/Kconfig                        |    3 ++
> >  drivers/clocksource/Makefile                       |    1 +
> >  .../clocksource/dw_apb_timer_of.c                  |   49 +++++++++++---------
> >  5 files changed, 57 insertions(+), 21 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/dw-apb.txt
> >  rename arch/arm/mach-picoxcell/time.c => drivers/clocksource/dw_apb_timer_of.c (60%)
> > 
> > diff --git a/arch/arm/mach-picoxcell/time.c  
> > b/drivers/clocksource/dw_apb_timer_of.c
> > similarity index 60%
> > rename from arch/arm/mach-picoxcell/time.c
> > rename to drivers/clocksource/dw_apb_timer_of.c
> > index 2ecba67..83bd997 100644
> > --- a/arch/arm/mach-picoxcell/time.c
> > +++ b/drivers/clocksource/dw_apb_timer_of.c
> > @@ -1,11 +1,20 @@
> [...]
> > -static const struct of_device_id picoxcell_rtc_ids[] __initconst = {
> > -	{ .compatible = "picochip,pc3x2-rtc" },
> > +static const struct of_device_id sptimer_ids[] __initconst = {
> > +	{ .compatible = "snps,dw-apb-timer-sp" },
> >  	{ /* Sentinel */ },
> 
> Please keep picochip,pc3x2-rtc in the compatible list otherwise we won't 
> boot any more.

Should I add another .compatible entry here, or make the change in
picoxcell-pc3x2 and picoxcell-pc3x3 dtsi files?

> 
> > -static const struct of_device_id picoxcell_timer_ids[] __initconst = 
> > {
> > -	{ .compatible = "picochip,pc3x2-timer" },
> > +static const struct of_device_id osctimer_ids[] __initconst = {
> > +	{ .compatible = "snps,dw-apb-timer-osc" },
> >  	{},
> >  };
> 
> The same here.  Also, I'm not sure that the split of these patches is 
> correct - there isn't any bisectability here as you remove the timer in 
> this patch but picoxcell won't build.  I think squashing these 2 patches 
> is fine.

Will do...thanks for the review.

Dinh
> 
> I can't test on hardware right now, but with those changes:
> 
> Acked-by: Jamie Iles <jamie@jamieiles.com>
> 
> Jamie
> 
