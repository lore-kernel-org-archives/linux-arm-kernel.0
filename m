From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 14 Oct 2011 09:26:43 +0800
Subject: [PATCH 2/2] arm/mx5: add device tree support for imx51 babbage
In-Reply-To: <20111013162025.GI21648@n2100.arm.linux.org.uk>
References: <1317389747-24589-1-git-send-email-shawn.guo@linaro.org>
	<1317389747-24589-3-git-send-email-shawn.guo@linaro.org>
	<4E970D62.9090403@free.fr>
	<20111013162025.GI21648@n2100.arm.linux.org.uk>
Message-ID: <20111014012636.GC27048@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 05:20:25PM +0100, Russell King - ARM Linux wrote:
> On Thu, Oct 13, 2011 at 06:10:10PM +0200, Julien Boibessot wrote:
> > On 30/09/2011 15:35, Shawn Guo wrote:
> > > It adds device tree support for imx51 babbage board.
> > >
> > cut
> > > diff --git a/arch/arm/mach-mx5/imx51-dt.c b/arch/arm/mach-mx5/imx51-dt.c
> > > new file mode 100644
> > > index 0000000..0878441
> > > --- /dev/null
> > > +++ b/arch/arm/mach-mx5/imx51-dt.c
> > > @@ -0,0 +1,116 @@
> > cut
> > > +
> > > +static void __init imx51_timer_init(void)
> > > +{
> > > +	mx51_clocks_init(32768, 24000000, 22579200, 0);
> > > +}
> > From my understanding, if put in arch/arm/mach-mx5/imx51-dt.c, this
> > clock initialization will apply to all i.MX51 based platforms.
> > Am I right ?
> 
> In the general case, from the above code fragment, I'd say you are.
> The timer init stuff is supposed to be for bringing up the timers.
> 
Inside mx51_clocks_init(), after necessary clock setup, it will call
mxc_timer_init() to bring up the timer.  I agree with the suggestion
below, but I'm trying to reuse non-dt setup as much as possible with
minimum changes and impact to non-dt case.

Regards,
Shawn

> We do have an early init callback which can be used for this - which
> gets things like the clk stuff up and running from immediately after
> the page tables have been setup and initial device mappings put in
> place - before any drivers or even IRQ controllers have been
> initialized.
> 
