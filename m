From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 16 Jun 2011 11:43:24 +0100
Subject: [RFC PATCH v2 0/5] Add generic macros for declaring various CPU
	structs
In-Reply-To: <20110616101241.GA4028@e102144-lin.cambridge.arm.com>
References: <1308049105-16080-1-git-send-email-dave.martin@linaro.org>
	<20110616101241.GA4028@e102144-lin.cambridge.arm.com>
Message-ID: <20110616104324.GC2460@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 11:12:41AM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Tue, Jun 14, 2011 at 11:58:20AM +0100, Dave Martin wrote:
> > Based on previous discussions, this series provides an alternative
> > macro for defining CPU-specific structures compactly.
> > 
> > I don't get to have so much fun with macros in this version, but
> > it's more straightforward and actually allows the declarations to
> > be collapsed down further by taking advantage of common naming
> > conventions.
> > 
> > In this RFC, only the arch names, processor_functions and
> > cache_functions are turned into macros, to show how this could
> > work.  This could be straightforwardly extended to cover tlb_fns,
> > but proc_info is more complex and may require a bit more thought.
> 
> In general, this looks good to me and I'm happy to rebase my A5/A15 core
> patches on top of this series.
> 
> >  * For consistency, I've renamed the arch/CPU name string labels.
> >    If that is seen as unnecessary churn, it can be undone.
> 
> I don't see the win here, so let's leave the names like they are to avoid
> unnecessary conflicts with other patches dealing with proc_info structs.

Agreed:

Having thought about this, and taking into account Russell's comments
about problems with this approach in proc-*.S files declaring multiple
CPUs, we should revert to not renaming any of those labels.

I'll follow up with updated patches after Russell has given his view,
but assume for now that the proc_info struct contents themselves
won't need to change.

Cheers
---Dave
