From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 9 Nov 2010 18:55:04 +0530
Subject: [PATCH] ARM: Temporary fix for broken arch reboot
In-Reply-To: <20101109131838.GF2869@n2100.arm.linux.org.uk>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
	<20101109131838.GF2869@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FABB4@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Tuesday, November 09, 2010 6:49 PM
> To: Shilimkar, Santosh; Catalin Marinas
> Cc: linux-arm-kernel at lists.infradead.org; Gadiyar, Anand
> Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> 
> On Tue, Nov 09, 2010 at 06:40:39PM +0530, Shilimkar, Santosh wrote:
> > With commit 3d3f78d752bf, reboot seems to broken on ARM
> > machines. CPU dies while doing flush_pmd_entry() as part of
> > setup_mm_for_reboot()
> >
> > I know this is not the fix but intention is to report the
> > issue and also provide temporary fix till it get fixed correctly
> 
> So you're now rebooting with the secondary CPUs still running.  I guess
> that the secondary CPUs end up crashing and don't restart.
> 
This behaviour depends on the reset mechanism implemented. On OMAP,
we have a way to do a reset on all the CPUs with single register bit,
like a global warm/cold reset. 

> I think more the question is why the CP15 cache clean/flush is hanging
> with the other CPUs taken down.  All the other CPUs will be doing is
> sitting in a loop doing nothing.
> 
> Catalin?
