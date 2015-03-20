From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 20 Mar 2015 17:20:41 +0000
Subject: ERRATA work-arounds in the kernel
In-Reply-To: <550C4B12.1030608@free.fr>
References: <550C4B12.1030608@free.fr>
Message-ID: <20150320172041.GI3421@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 20, 2015 at 05:30:10PM +0100, Mason wrote:
> I also looked at ARM's "Errata Summary Table" for the Cortex A9. There are
> roughly 90 errata documented there. (This document is 2 years old.)
> 
> I assume that some (most?) of these do not apply to Linux, but it seems
> likely that some do?
> 
> I'm wondering why there are not more work-arounds available in Kconfig?

There are a few reasons:

- erratum cannot be triggered in Linux
- erratum cannot be worked around in Linux (e.g. it requires some
  undocumented control bits to be set by firmware or even hw workaround
  like the system errata)
- cat A erratum with no feasible workaround (and partners usually take
  an ECO fix)
- erratum does not affect any CPU revision in production (not all rxpy
  revisions are in the field; I would include here early CPU revisions
  that were licensed as development chips but not widely used)
- we simply missed them. So if you think there is any that needs to be
  upstreamed, let us know or submit a patch

> I'm wondering if it is possible to trigger some of these with a "normal"
> work-load on a "normal" kernel? Has anyone (perhaps ARM employees) looked
> at that? (I suppose they have.)

Define "normal". It's really hard to quantify as the workloads can vary
widely between different use cases (e.g. mobile vs server).

> For example, errata #782772
> "Speculative execution of a Load-Exclusive or Store-Exclusive instruction
> after a write to Strongly Ordered memory might deadlock the processor."
> (The recommended work-around is a strategically-placed DMB.)
> 
> Since ldrex is used in low-level code, it seems possible to hit that one?
> Or perhaps Linux does not support "Strongly Ordered" memory regions?

It support SO memory and it's used in some cases.

-- 
Catalin
