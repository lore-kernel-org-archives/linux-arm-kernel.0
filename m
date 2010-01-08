From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Fri, 8 Jan 2010 17:20:24 -0600
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <20091218203154.GE1205@shareable.org>
References: <20091217175416.9317.66257.stgit@e101986-lin>
	<13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
	<20091217191602.GC362@shareable.org>
	<13B9B4C6EF24D648824FF11BE896716203A7FA6BF4@dlee02.ent.ti.com>
	<20091218203154.GE1205@shareable.org>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203A85EB6B1@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Jamie Lokier [mailto:jamie at shareable.org]
> Sent: Friday, December 18, 2009 2:32 PM
> To: Woodruff, Richard

> > Performance point was mainly about coordination with non-coherent
> > external masters (outside of cluster).  Blocking all external people
> > for a small range is not optimal.
>
> Sure, but doesn't your patch break any program which tries to do
> that, due to the lack of LDREX/STREX global monitor reaching to
> external masters, so that case isn't relevant?

I didn't submit patch, just commented on how it might change out of cluster behavior and suggested a comment added to documentation.

A swp out of cluster is atomic as the bus makes it so. A bus-bridge translated-neutered lwrex/strex will not necessary be atomic.

> So (correct me if I'm wrong) the interesting case is only about
> accesses within the cluster.  Is that really slower with SWP/SWPB?

I think I've lost context over holidays to answer.  I have not looked at implementation details in cluster to know which sequence is faster. Inside the cluster many things which are normally slower as perceived by the ARM core can be optimized away in lower hardware layers (misaligned access as an example).

Regards,
Richard W.
