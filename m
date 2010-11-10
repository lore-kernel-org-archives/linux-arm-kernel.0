From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 10 Nov 2010 11:25:21 +0530
Subject: [PATCH] ARM: Temporary fix for broken arch reboot
In-Reply-To: <1289320692.11461.21.camel@e102109-lin.cambridge.arm.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
	<20101109131838.GF2869@n2100.arm.linux.org.uk>
	<1289320692.11461.21.camel@e102109-lin.cambridge.arm.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAE5C@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Tuesday, November 09, 2010 10:08 PM
> To: Russell King - ARM Linux
> Cc: Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org; Gadiyar,
> Anand
> Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> 
> On Tue, 2010-11-09 at 13:18 +0000, Russell King - ARM Linux wrote:
> > On Tue, Nov 09, 2010 at 06:40:39PM +0530, Shilimkar, Santosh wrote:
> > > With commit 3d3f78d752bf, reboot seems to broken on ARM
> > > machines. CPU dies while doing flush_pmd_entry() as part of
> > > setup_mm_for_reboot()
> 
> What do you mean by 'dies'? Can you still connect with a debugger or it
> got to some weird state?
> 
It goes to some weird state. Basically the emulation connection dies,
and debugger gets disconnected.

> > > I know this is not the fix but intention is to report the
> > > issue and also provide temporary fix till it get fixed correctly
> >
> > So you're now rebooting with the secondary CPUs still running.  I guess
> > that the secondary CPUs end up crashing and don't restart.
> >
> > I think more the question is why the CP15 cache clean/flush is hanging
> > with the other CPUs taken down.  All the other CPUs will be doing is
> > sitting in a loop doing nothing.
> 
> I can't think of anything. Did the other CPUs print 'stopping'?
No it doesn't not print anything.
