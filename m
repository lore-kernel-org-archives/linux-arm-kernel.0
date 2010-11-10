From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Nov 2010 15:46:04 +0000
Subject: [PATCH] ARM: Temporary fix for broken arch reboot
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB030D58A400@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FAB9E@dbde02.ent.ti.com>
	<20101109131838.GF2869@n2100.arm.linux.org.uk>
	<1289320692.11461.21.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D4FAE5C@dbde02.ent.ti.com>
	<20101110100617.GA23244@n2100.arm.linux.org.uk>
	<1289397874.4513.54.camel@e102109-lin.cambridge.arm.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB030D58A400@dbde02.ent.ti.com>
Message-ID: <20101110154604.GA27571@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 10, 2010 at 09:13:21PM +0530, Shilimkar, Santosh wrote:
> 
> 
> > -----Original Message-----
> > From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> > Sent: Wednesday, November 10, 2010 7:35 PM
> > To: Russell King - ARM Linux
> > Cc: Shilimkar, Santosh; linux-arm-kernel at lists.infradead.org; Gadiyar,
> > Anand
> > Subject: Re: [PATCH] ARM: Temporary fix for broken arch reboot
> > 
> > The printing only happens for SYSTEM_BOOTING or SYSTEM_RUNNING. I
> > suspect in this case we have SYSTEM_RESTARTING and the condition in
> > ipi_cpu_stop() is false, therefore no printing. It may be worth putting
> > some printks outside the 'if' to see whether the secondary CPUs get
> > there.
> > 
> While doing some experiments on this issue, one interesting
> observation I made. Looks like there is race between two
> Cores which makes system behave badly in reboot path.
> 
> Just adding a delay in the ipi_cpu_stop() makes the reboot work
> as well

That could just be that it's taking longer than 500us for the reboot CPU
to get through setup_mm_for_reboot().
