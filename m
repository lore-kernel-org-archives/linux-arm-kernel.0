From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Thu, 17 Dec 2009 14:43:22 -0600
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <20091217191602.GC362@shareable.org>
References: <20091217175416.9317.66257.stgit@e101986-lin>
	<13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
	<20091217191602.GC362@shareable.org>
Message-ID: <13B9B4C6EF24D648824FF11BE896716203A7FA6BF4@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Jamie Lokier [mailto:jamie at shareable.org]
> Sent: Thursday, December 17, 2009 1:16 PM

> Woodruff, Richard wrote:
> > Exclusive operations are more certainly more efficient than the full
> > bus lock behavior of SWP.  Finding and killing SWP where possible
> > seems positive.
>
> Are they really more efficient for cached accesses in L1?  In
> principle, external bus lock is not needed when doing an
> read-modify-write on words in MESI cache, just the ability to
> internally block it's eviction during the sequence.

Performance point was mainly about coordination with non-coherent external masters (outside of cluster).  Blocking all external people for a small range is not optimal.

Within the cluster and in cache as you point out... I'm not sure of implementation reality. The outside world past A9 may or may not export some form of mesi.

Regards,
Richard W.
