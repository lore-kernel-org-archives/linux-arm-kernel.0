From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 11 Jul 2012 17:03:58 +0100
Subject: [PATCH v2 1/2] clocksource: dw_apb_timer: Add common DTS glue
 for  dw_apb_timer
In-Reply-To: <1342020026.4790.1.camel@dinguyen-VirtualBox>
References: <1341956381-496-1-git-send-email-dinguyen@altera.com>
 <20120710231525.GA27641@page>
 <1342020026.4790.1.camel@dinguyen-VirtualBox>
Message-ID: <20120711160358.GA8444@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 10:20:26AM -0500, Dinh Nguyen wrote:
> On Wed, 2012-07-11 at 00:15 +0100, Jamie Iles wrote:
> > On Tue, Jul 10, 2012 at 04:39:40PM -0500, dinguyen at altera.com wrote:
> > > --- a/arch/arm/mach-picoxcell/time.c
> > > +++ b/drivers/clocksource/dw_apb_timer_of.c
> > > @@ -1,11 +1,20 @@
> > [...]
> > > -static const struct of_device_id picoxcell_rtc_ids[] __initconst = {
> > > -	{ .compatible = "picochip,pc3x2-rtc" },
> > > +static const struct of_device_id sptimer_ids[] __initconst = {
> > > +	{ .compatible = "snps,dw-apb-timer-sp" },
> > >  	{ /* Sentinel */ },
> > 
> > Please keep picochip,pc3x2-rtc in the compatible list otherwise we won't 
> > boot any more.
> 
> Should I add another .compatible entry here, or make the change in
> picoxcell-pc3x2 and picoxcell-pc3x3 dtsi files?

I think that adding another compatible entry is the right thing to do 
here - it avoids churn of the dtsi files and means that the compiled 
device-tree blobs on deployed devices won't need updating.

Jamie
