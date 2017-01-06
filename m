From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Jan 2017 12:26:41 +0000
Subject: [PATCH] ARM: hw_breakpoint: blacklist Scorpion CPUs
In-Reply-To: <20170106112125.GB15333@arm.com>
References: <1483637556-3974-1-git-send-email-mark.rutland@arm.com>
 <20170106112125.GB15333@arm.com>
Message-ID: <20170106122312.GA17642@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 06, 2017 at 11:21:25AM +0000, Will Deacon wrote:
> On Thu, Jan 05, 2017 at 05:32:36PM +0000, Mark Rutland wrote:
> > +	if (read_cpuid_part() == ARM_CPU_PART_SCORPION) {
> > +		pr_info("Scorpion CPU detected. Breakpoints and watchpoints disabled\n");
> 
> nit: we're disabling *hardware* breakpoints and watchpoints, so it's worth
> mentioning that in the print.

True. I've fixed up the message.

> With that:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Please put this into Russell's patch system.

Cheers.

I've dropped this in the patch system as 8634/1.

Thanks,
Mark.
