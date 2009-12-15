From: jamie.iles@picochip.com (Jamie Iles)
Date: Tue, 15 Dec 2009 14:36:52 +0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve performance
	counters
In-Reply-To: <000001ca7d90$c4a15330$4de3f990$@deacon@arm.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<000001ca7d90$c4a15330$4de3f990$@deacon@arm.com>
Message-ID: <20091215143652.GN4141@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Many thanks for the review again!

On Tue, Dec 15, 2009 at 02:13:25PM -0000, Will Deacon wrote:
[snip]
> > +/**
> > + * reserve_pmu() - reserve the hardware performance counters
> > + *
> > + * Reserve the hardware performance counters in the system for exclusive use.
> > + * The 'struct pmu_irqs' for the system is returned on success, ERR_PTR()
> > + * encoded error on failure.
> > + */
> > +extern const struct pmu_irqs *
> > +reserve_pmu(void);
> 
> I think it's standard Kernel coding style to put the declaration of a function
> all on one line if it fits. The same goes elsewhere in the patch.
I couldn't find anything that has this written down and there are plenty of
other places in the perf code that do this. I personally like it because you
can grep for "^foo" to find the definition. Unless people have strong
objections to this I'll leave it as is.

> > +config CPU_HAS_PMU
> > +	depends on CPU_V6 || CPU_V7 || CPU_XSCALE
> > +	default y
> > +	bool
> 
> I think you should use XSCALE_PMU instead of CPU_XSCALE. Also, this should
> probably be in the top-level ARM Kconfig instead of the mm/ one.
Ok, I agree with you about using XSCALE_PMU, but why isn't mm/Kconfig the
correct one? It's describing what features the CPU has and the PMU *is* a
feature.

Cheers,

Jamie
