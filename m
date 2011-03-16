From: will.deacon@arm.com (Will Deacon)
Date: Wed, 16 Mar 2011 16:21:09 -0000
Subject: [PATCH 1/2] ARM: perf: reset counters on all CPUs during
	initialisation
In-Reply-To: <AANLkTim_XwErHv_Brkn5hXn7sAxvkd++C5wbKv9n4VXC@mail.gmail.com>
References: <1300289898-2720-1-git-send-email-will.deacon@arm.com>
	<AANLkTim_XwErHv_Brkn5hXn7sAxvkd++C5wbKv9n4VXC@mail.gmail.com>
Message-ID: <001b01cbe3f6$29365e40$7ba31ac0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean,

> On Wed, Mar 16, 2011 at 4:38 PM, Will Deacon <will.deacon@arm.com> wrote:
> > ARMv7 dictates that the interrupt-enable and count-enable registers for
> > each PMU counter are UNKNOWN following core reset.
> Great! Is this development driven by actual issues or by precaution?

Just precautionary, but it's also a precursor to some power management
work in ARM which might leave the registers in a funny state when they
come out of a low-power state. This code at least gives them an entry
hook for dealing with that.
 
> >
> > This patch adds an arch_initcall to the ARMv7 perf events backend which
> > disables the counters on each CPU prior to setting the Enable bit in the
> > PMCR.
> Also the function rename is a good thing.

Yup.

> >
> > Cc: Jean Pihet <jean.pihet@newoldbits.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Jean Pihet <j-pihet@ti.com>

Thanks for the Ack,

Will
