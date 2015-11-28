From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sat, 28 Nov 2015 12:34:23 -0500 (EST)
Subject: [PATCH 5/5] arm: boot: store ATAGs structure into DT
 "/chosen/linux,atags" entry
In-Reply-To: <20151128123328.GC30871@n2100.arm.linux.org.uk>
References: <20150713131902.GH26485@atomide.com>
 <20151127132722.GA30871@n2100.arm.linux.org.uk>
 <20151127195148.GB30871@n2100.arm.linux.org.uk> <11537945.4HX4Y84tjV@wuerfel>
 <alpine.LFD.2.20.1511271817230.22569@knanqh.ubzr>
 <20151128123328.GC30871@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.20.1511281232440.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 28 Nov 2015, Russell King - ARM Linux wrote:

> On Fri, Nov 27, 2015 at 06:28:50PM -0500, Nicolas Pitre wrote:
> > On Fri, 27 Nov 2015, Arnd Bergmann wrote:
> > 
> > > I don't mind creating the /proc/atags compatibility hack from the kernel
> > > for a DT based N700 kernel, as long as we limit it as much as we can
> > > to the machines that need it. Leaving a board file for the N700 in place
> > > that contains the procfs code (and not much more) seems reasonable
> > > here, as we are talking about a board specific hack and the whole point
> > > appears to be running unmodified user space.
> > > 
> > > Regarding how to get the data into the kernel in the first place, my
> > > preferred choice would still be to have an intermediate bootloader
> > > such as pxa-impedance-matcher, but I won't complain if others are
> > > happy enough about putting it into the ATAGS compat code we already
> > > have, as long as it's limited to the boards we know need it.
> > 
> > Assuming you have a N700 board file for special procfs code, then why 
> > not getting at the atags in memory where the bootloader has put them 
> > directly from that same board file? This way it'll really be limited to 
> > the board we know needs it and the special exception will be contained 
> > to that one file.  Amongst the machine specific hooks, there is one that 
> > gets invoked early during boot before those atags are overwritten.
> 
> I've already suggested that.

Good. And Arnd likes the idea too. So we might be converging at last 
which is a good thing.


Nicolas
