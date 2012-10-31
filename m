From: josh.cartwright@ni.com (Josh Cartwright)
Date: Wed, 31 Oct 2012 06:35:13 -0600
Subject: [PATCH] ARM: zynq: move ttc timer code to drivers/clocksource
In-Reply-To: <2b8e9679-dade-4448-8c16-362de455ead0@AM1EHSMHS002.ehs.local>
References: <20121029185630.GA26149@beefymiracle.amer.corp.natinst.com>
 <508FBBA5.2080707@monstr.eu> <201210302236.43473.arnd@arndb.de>
 <2b8e9679-dade-4448-8c16-362de455ead0@AM1EHSMHS002.ehs.local>
Message-ID: <20121031123513.GJ5190@beefymiracle.amer.corp.natinst.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2012 at 08:48:38AM +0000, Michal Simek wrote:
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> > On Tuesday 30 October 2012, Michal Simek wrote:
> > > On 10/29/2012 07:56 PM, Josh Cartwright wrote:
[..]
> > 
> > > >   delete mode 100644 arch/arm/mach-zynq/common.h
> > > >   delete mode 100644 arch/arm/mach-zynq/timer.c
> > > >   create mode 100644 drivers/clocksource/xilinx_ttc.c
> > > >   create mode 100644 include/linux/xilinx_ttc.h
> > >
> > > Really?
> > > If yes. shouldn't be there any better naming convention especially
> > > for headers. linux/clocksource/xilinx_ttc.h.
> >
> > Moving it is certainly the right direction, but I think we need a
> > better way to handle those forward declarations. "struct sys_timer"
> > is actually an ARM specific structure, so we might just want to add
> > all the forward declarations for the timers into
> > arch/arm/include/asm/mach/time.h. It's not ideal to do it like that,
> > but I think it's much better than having a new globally visible
> > header for each timer that is used on ARM.
> >
> > Eventually, we might want to do something similar to what we are
> > discussing for the top-level IRQ controllers at the moment, where we
> > just autodetect them from DT if possible, so we don't need to have
> > any pointer to the timer from arch code at all.
>
> Ok. It means that it is not big deal to keep timer as is in mach and
> when we have any generic solution we can follow it. This patch just
> move the code out of mach-zynq.  It should be done across architecture
> because for example timer I use for microblaze can be used by zynq
> too, also by Xilinx ppc.

That all makes sense.  Since posting, I've had to rework this a bit for
getting COMMON_CLK support working with the TTC.  I'll pull this patch
(in proper form, and with some slight modifications) into my pending
COMMON_CLK support patchset.

Thanks,

  Josh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121031/50460231/attachment.sig>
