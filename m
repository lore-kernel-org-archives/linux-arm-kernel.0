From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 15 Feb 2011 15:46:33 +0000
Subject: [RFC] ARM: dma-mapping: outer cache is invalidated twice
In-Reply-To: <AANLkTinpcYoHKKDhqy9mKpqOEGtMpNc1BSukNWH-GVBX@mail.gmail.com>
References: <AANLkTi=rZJq0CPQD0Q1HMgih7UP0Tqoh9sPEYb2NEV_X@mail.gmail.com>
	<20110215133232.GI4152@n2100.arm.linux.org.uk>
	<20110215134134.GA17208@n2100.arm.linux.org.uk>
	<AANLkTi=Fs5+3yG-_4u0oU8WK4K4FU_8zN38H=RNcgRNU@mail.gmail.com>
	<20110215141253.GJ4152@n2100.arm.linux.org.uk>
	<AANLkTinpcYoHKKDhqy9mKpqOEGtMpNc1BSukNWH-GVBX@mail.gmail.com>
Message-ID: <20110215154633.GN4152@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 15, 2011 at 04:11:09PM +0100, Per Forlin wrote:
> True. In my case write back is disable but read back is enable, that's
> why I didn't consider it.

What do you mean "write back is disable" ?  You can only prevent
writebacks by using a write-through cache.

Any writeback cache, whether in read-allocate or read-write-allocate
mode will have writebacks.

> Do you think it is feasible to let dma-mapping detect the cache
> configurations in runtime in order to prevent "unnecessary" cache
> operations?

Let's first straighten out your cache understanding above, because I
don't think you understand properly yet.
