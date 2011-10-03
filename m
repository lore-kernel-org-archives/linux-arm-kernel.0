From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Oct 2011 12:27:21 +0900
Subject: [PATCH 0/4] ARM: EXYNOS4: Support generic Power domain framework
	for EXYNOS4210
In-Reply-To: <201110022000.56556.rjw@sisk.pl>
References: <4E4360B2.2060508@samsung.com> <201110021508.44083.rjw@sisk.pl>
	<20111002131307.GV11710@n2100.arm.linux.org.uk>
	<201110022000.56556.rjw@sisk.pl>
Message-ID: <005701cc817c$5c54a240$14fde6c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rafael J. Wysocki wrote:
> 
> On Sunday, October 02, 2011, Russell King - ARM Linux wrote:
> > On Sun, Oct 02, 2011 at 03:08:43PM +0200, Rafael J. Wysocki wrote:
> > > On Sunday, October 02, 2011, Russell King - ARM Linux wrote:
> > > > How do these misconceptions start?
> > > >
> > > > The clock API.  Drivers are supposed to get a clock (source) when
they
> > > > initialize.  Drivers then enable and disable the clock as they
_themselves_
> > > > require the use of that clock.
> > >
> > > OK
> > >
> > > Now think of a driver that should handle the same device on both ARM
and
> > > x86-based SoCs.  Is the clock API available on x86?
> >
> > No one's bothered yet.
> 
> Prehaps because x86 doesn't allow us to control device clocks directly.
> They are controlled through PCI PM or through ACPI methods, both of which
> hide the clocks behind abstract low-power states we're supposed to use.
> 
Well, I think Embedded drivers especially ARM sometimes need to control its
own clock directly and each embedded drivers know when clock controlling is
required or not. Actually, Samsung driver stuff have calling clk_enable() in
probe() or open() and clk_disable() when clock is not needed more. But I'm
not sure we _really_ can get some benefits when matching clock and power
control on ARM devices.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
