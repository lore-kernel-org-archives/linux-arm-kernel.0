From: jpihet@mvista.com (Jean Pihet)
Date: Mon, 21 Dec 2009 12:32:32 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <20091219105343.GA1515@elte.hu>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<20091219102905.GA26526@wear.picochip.com>
	<20091219105343.GA1515@elte.hu>
Message-ID: <200912211232.33319.jpihet@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 19 December 2009 11:53:43 Ingo Molnar wrote:
> * Jamie Iles <jamie@jamieiles.com> wrote:
> > [snip]
> >
> > > I had a question about the events mapping to user space. Although most
> > > of the events are mapped in the kernel code, some of the exotic events
> > > are not mapped (e.g. NEON or PMU related events). How to use those
> > > events from user space? Is it done using the raw mappings?
> >
> > Yes, the raw events should do the trick. 'perf stat -a -e rff -- sleep 1'
> > will do cycle counting on v6 using the raw event number.
>
> Sidenote: if some of the more exotic events turn out to be useful and are
> worth generalizing, then we can add them to the generic enumeration and add
> tooling support (symbols, aliases, listing, etc.) for it.
>
> The current set of generic events are intended to be a 'seed' set, to be
> extended on an as-needed basis - not cast into stone in any way.
>
> The current generic (hardware) events are (from 'perf list' output):
>
>   cpu-cycles OR cycles                       [Hardware event]
>   instructions                               [Hardware event]
>   cache-references                           [Hardware event]
>   cache-misses                               [Hardware event]
>   branch-instructions OR branches            [Hardware event]
>   branch-misses                              [Hardware event]
>   bus-cycles                                 [Hardware event]
>   L1-dcache-loads                            [Hardware cache event]
>   L1-dcache-load-misses                      [Hardware cache event]
>   L1-dcache-stores                           [Hardware cache event]
>   L1-dcache-store-misses                     [Hardware cache event]
>   L1-dcache-prefetches                       [Hardware cache event]
>   L1-dcache-prefetch-misses                  [Hardware cache event]
>   L1-icache-loads                            [Hardware cache event]
>   L1-icache-load-misses                      [Hardware cache event]
>   L1-icache-prefetches                       [Hardware cache event]
>   L1-icache-prefetch-misses                  [Hardware cache event]
>   LLC-loads                                  [Hardware cache event]
>   LLC-load-misses                            [Hardware cache event]
>   LLC-stores                                 [Hardware cache event]
>   LLC-store-misses                           [Hardware cache event]
>   LLC-prefetches                             [Hardware cache event]
>   LLC-prefetch-misses                        [Hardware cache event]
>   dTLB-loads                                 [Hardware cache event]
>   dTLB-load-misses                           [Hardware cache event]
>   dTLB-stores                                [Hardware cache event]
>   dTLB-store-misses                          [Hardware cache event]
>   dTLB-prefetches                            [Hardware cache event]
>   dTLB-prefetch-misses                       [Hardware cache event]
>   iTLB-loads                                 [Hardware cache event]
>   iTLB-load-misses                           [Hardware cache event]
>   branch-loads                               [Hardware cache event]
>   branch-load-misses                         [Hardware cache event]
>   rNNN                                       [raw hardware event
> descriptor] mem:<addr>[:access]                        [hardware
> breakpoint]
>
> But i think we might want to capture FPU-alike instructions as well on CPUs
> that can count/sample them - etc.
>
Ok, thanks for the information!
We might need to generalize the ARMv7 CPUs for the moment the processors are 
Cortex-A8 (supported by the proposed patch) and Cortex-A9 (not yet supported 
but should come soon).


> 	Ingo

Jean
