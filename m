From: jamie@shareable.org (Jamie Lokier)
Date: Thu, 17 Dec 2009 19:16:02 +0000
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors
In-Reply-To: <13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
References: <20091217175416.9317.66257.stgit@e101986-lin>
	<13B9B4C6EF24D648824FF11BE896716203A7FA69CC@dlee02.ent.ti.com>
Message-ID: <20091217191602.GC362@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Woodruff, Richard wrote:
> Exclusive operations are more certainly more efficient than the full
> bus lock behavior of SWP.  Finding and killing SWP where possible
> seems positive.

Are they really more efficient for cached accesses in L1?  In
principle, external bus lock is not needed when doing an
read-modify-write on words in MESI cache, just the ability to
internally block it's eviction during the sequence.

-- Jamie
