From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Dec 2009 17:06:55 -0000
Subject: [PATCH 1/5] arm: provide a mechanism to reserve
	performance	counters
In-Reply-To: <20091215143652.GN4141@wear.picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<1260875712-29712-2-git-send-email-jamie.iles@picochip.com>
	<000001ca7d90$c4a15330$4de3f990$@deacon@arm.com>
	<20091215143652.GN4141@wear.picochip.com>
Message-ID: <000401ca7da9$0142cae0$03c860a0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jamie Iles wrote:

> > I think it's standard Kernel coding style to put the declaration of a function
> > all on one line if it fits. The same goes elsewhere in the patch.
> I couldn't find anything that has this written down and there are plenty of
> other places in the perf code that do this. I personally like it because you
> can grep for "^foo" to find the definition. Unless people have strong
> objections to this I'll leave it as is.

I'm just going by the examples in Documentation/CodingStyle.

> > > +config CPU_HAS_PMU
> > > +	depends on CPU_V6 || CPU_V7 || CPU_XSCALE
> > > +	default y
> > > +	bool
> >
> > I think you should use XSCALE_PMU instead of CPU_XSCALE. Also, this should
> > probably be in the top-level ARM Kconfig instead of the mm/ one.
> Ok, I agree with you about using XSCALE_PMU, but why isn't mm/Kconfig the
> correct one? It's describing what features the CPU has and the PMU *is* a
> feature.

I'd say move it out of mm/Kconfig because the PMU is not related to memory
management and almost everything under mm/ is. oprofile may also want to use
these bools and that is based in the top-level ARM Kconfig.

Will
