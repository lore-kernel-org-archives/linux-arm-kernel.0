From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Sun, 2 Oct 2011 20:00:56 +0200
Subject: [PATCH 0/4] ARM: EXYNOS4: Support generic Power domain framework
	for EXYNOS4210
In-Reply-To: <20111002131307.GV11710@n2100.arm.linux.org.uk>
References: <4E4360B2.2060508@samsung.com> <201110021508.44083.rjw@sisk.pl>
	<20111002131307.GV11710@n2100.arm.linux.org.uk>
Message-ID: <201110022000.56556.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, October 02, 2011, Russell King - ARM Linux wrote:
> On Sun, Oct 02, 2011 at 03:08:43PM +0200, Rafael J. Wysocki wrote:
> > On Sunday, October 02, 2011, Russell King - ARM Linux wrote:
> > > How do these misconceptions start?
> > > 
> > > The clock API.  Drivers are supposed to get a clock (source) when they
> > > initialize.  Drivers then enable and disable the clock as they _themselves_
> > > require the use of that clock.
> > 
> > OK
> > 
> > Now think of a driver that should handle the same device on both ARM and
> > x86-based SoCs.  Is the clock API available on x86?
> 
> No one's bothered yet.

Prehaps because x86 doesn't allow us to control device clocks directly.
They are controlled through PCI PM or through ACPI methods, both of which
hide the clocks behind abstract low-power states we're supposed to use.

Thanks,
Rafael
