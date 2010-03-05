From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 05 Mar 2010 15:46:19 +1100
Subject: [RFC PATCH] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <20100305012823.GD26618@linux-sh.org>
References: <20100302172947.27766.61539.stgit@e102109-lin.cambridge.arm.com>
	<20100304164416.GD13417@n2100.arm.linux.org.uk>
	<1267727802.6526.545.camel@e102109-lin.cambridge.arm.com>
	<20100304214435.GJ13417@n2100.arm.linux.org.uk>
	<20100305012823.GD26618@linux-sh.org>
Message-ID: <1267764379.22204.103.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-03-05 at 10:28 +0900, Paul Mundt wrote:
> In the anonymous page case, flush_anon_page() is always called prior to
> flush_dcache_page(), so flush_anon_page() could just set PG_dcache_clean
> to work around that. That would handle get_user_pages(), too. 

Well, currently, we clear PG_arch_1 in flush_dcache_page(), at least on
ppc.

Now, I have a nagging feeling that we might not need to... I'll have to
give it a closer look when I'm back from this extended week-end :-)

Cheers,
Ben.
