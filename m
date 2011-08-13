From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 13 Aug 2011 20:12:28 +0800
Subject: [PATCH 1/6] arm/cpuimx51: gpio_to_irq() should be used to get
	irq from gpio number
In-Reply-To: <20110813093529.GN4775@n2100.arm.linux.org.uk>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
	<1313135701-22456-2-git-send-email-shawn.guo@linaro.org>
	<CAB4PhKdAgasG3wJ2JvS_Ds0ReGjDCgZh_prepNGF=FqG6fRx7A@mail.gmail.com>
	<20110812111306.GH6618@S2100-06.ap.freescale.net>
	<20110813093529.GN4775@n2100.arm.linux.org.uk>
Message-ID: <20110813121227.GA7244@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 13, 2011 at 10:35:29AM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 12, 2011 at 07:13:07PM +0800, Shawn Guo wrote:
> > On Fri, Aug 12, 2011 at 05:36:32PM +0800, Jason Liu wrote:
> > > 2011/8/12 Shawn Guo <shawn.guo@linaro.org>:
> > > > Instead of irq_to_gpio(), gpio_to_irq() should be used to get irq
> > > > from gpio number.
> > > >
> > > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > > ?arch/arm/mach-mx5/board-cpuimx51.c | ? ?2 +-
> > > > ?1 files changed, 1 insertions(+), 1 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-mx5/board-cpuimx51.c b/arch/arm/mach-mx5/board-cpuimx51.c
> > > > index 7c893fa..68934ea 100644
> > > > --- a/arch/arm/mach-mx5/board-cpuimx51.c
> > > > +++ b/arch/arm/mach-mx5/board-cpuimx51.c
> > > > @@ -81,7 +81,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
> > > > ? ? ? ? ? ? ? ?.flags = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST | UPF_IOREMAP,
> > > > ? ? ? ?}, {
> > > > ? ? ? ? ? ? ? ?.mapbase = (unsigned long)(MX51_CS1_BASE_ADDR + 0x2000000),
> > > > - ? ? ? ? ? ? ? .irq = irq_to_gpio(CPUIMX51_QUARTD_GPIO),
> > > > + ? ? ? ? ? ? ? .irq = gpio_to_irq(CPUIMX51_QUARTD_GPIO),
> > > > ? ? ? ? ? ? ? ?.irqflags = IRQF_TRIGGER_HIGH,
> > > > ? ? ? ? ? ? ? ?.uartclk = CPUIMX51_QUART_XTAL,
> > > > ? ? ? ? ? ? ? ?.regshift = CPUIMX51_QUART_REGSHIFT,
> > > > --
> > > 
> > > The fix has already in Sascah's tree:
> > > 
> > > Author: Ben Dooks <ben-linux@fluff.org>
> > > Date:   Thu Aug 4 16:47:35 2011 +0100
> > > 
> > >     ARM: mx5: board-cpuimx51.c fixup irq_to_gpio() usage
> > > 
> > >     irq_to_gpio() is being called on a GPIO so change to using
> > >     gpio_to_irq() instead.
> > > 
> > >     Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> > >     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > Jason
> > > 
> > Sorry, I missed that.  Thanks for pointing it out, Jason.
> > 
> > I will fold Ben's patch here, as I see Russell would probably pick up
> > the series.  Otherwise, Russell, please let me know if I should base
> > it on Sascha's tree.
> 
> Shouldn't this patch be targetted for -rc and maybe stable?  It's
> difficult to tell from the commit description whether it really does
> cause a runtime problem or not.
> 
> If it does go in to a -rc, then I can easily move my gpio patch set
> forward.
> 
Ah, yes.  I just noticed that the patch is on the way to -rc2 through
arm-soc tree.

-- 
Regards,
Shawn
