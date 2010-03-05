From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 05 Mar 2010 15:32:09 +1100
Subject: [RFC PATCH] ARM: Assume new page cache pages have dirty D-cache
In-Reply-To: <20100304214435.GJ13417@n2100.arm.linux.org.uk>
References: <20100302172947.27766.61539.stgit@e102109-lin.cambridge.arm.com>
	<20100304164416.GD13417@n2100.arm.linux.org.uk>
	<1267727802.6526.545.camel@e102109-lin.cambridge.arm.com>
	<20100304214435.GJ13417@n2100.arm.linux.org.uk>
Message-ID: <1267763529.22204.90.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> As I just realised, this is going to subject all pages placed into
> userspace with a D cache flush - even anonymous pages, and those
> which we've been careful to deal with the cache issues already (eg,
> via the COW page copying code.)
> 
> I think all the copypage functions need to set PG_dcache_clean on the
> new pages once their copy has completed.
> 
> I wonder if there's any other anonymous page creating functions which
> could do with a similar treatment...

Do we do anything other than COW and zero page ? clear_user_page() I
suppose could deal with that if you do the cache bits there.

Cheers,
Ben.
