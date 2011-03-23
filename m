From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Mar 2011 13:39:22 -0000
Subject: [PATCH 1/2] ARM: perf: reset counters on all CPUs during
	initialisation
In-Reply-To: <AANLkTim_XwErHv_Brkn5hXn7sAxvkd++C5wbKv9n4VXC@mail.gmail.com>
References: <1300289898-2720-1-git-send-email-will.deacon@arm.com>
	<AANLkTim_XwErHv_Brkn5hXn7sAxvkd++C5wbKv9n4VXC@mail.gmail.com>
Message-ID: <002f01cbe95f$b7c929d0$275b7d70$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> On Wed, Mar 16, 2011 at 4:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> > ARMv7 dictates that the interrupt-enable and count-enable registers for
> > each PMU counter are UNKNOWN following core reset.
> Great! Is this development driven by actual issues or by precaution?
> 
> >
> > This patch adds an arch_initcall to the ARMv7 perf events backend which
> > disables the counters on each CPU prior to setting the Enable bit in the
> > PMCR.
> Also the function rename is a good thing.
> 
> >
> > Cc: Jean Pihet <jean.pihet@newoldbits.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Jean Pihet <j-pihet@ti.com>

I don't think this patch is safe for combined v6/v7 kernels because the
arch_initcall will try to poke the v7 PMU regardless of whether or not
it exists. I'll try and rework something and send another version to the
list.

I've removed it from the patch system but left the isb patch there
because that is fine as it is.

Stay tuned...

Will
