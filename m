From: davem@davemloft.net (David Miller)
Date: Mon, 12 Oct 2009 03:16:28 -0700 (PDT)
Subject: [PATCH] [ARM] force dcache flush if dcache_dirty bit set
In-Reply-To: <20091012100023.GC29310@n2100.arm.linux.org.uk>
References: <20091012090710.GA29310@n2100.arm.linux.org.uk>
	<20091012.023744.157085851.davem@davemloft.net>
	<20091012100023.GC29310@n2100.arm.linux.org.uk>
Message-ID: <20091012.031628.98420072.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 12 Oct 2009 11:00:23 +0100

> The problem which has been identified is that when flush_dcache_page() is
> called, there is a mapping, and so the page is marked for lazy flushing.
> However, by the time update_mmu_cache() gets called, the mapping has gone
> and so update_mmu_cache() does nothing.

Now I understand, thanks.

Ok, I'll remove the mapping check from the sparc64 flush_dcache()
function, seems the right thing to do.
