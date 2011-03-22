From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Mar 2011 08:17:46 +0000
Subject: Revert "[ARM] pxa: remove now unnecessary dma_needs_bounce()"
In-Reply-To: <AANLkTinVBCpinGfMkFbb_RpJbdAJiuQ57aWjqj5F=FoB@mail.gmail.com>
References: <AANLkTin0hVKnicRtxLwxwPJZU6tYiuTZnbGUfxt9bLYe@mail.gmail.com>
	<20110321150349.GC4340@n2100.arm.linux.org.uk>
	<AANLkTinVBCpinGfMkFbb_RpJbdAJiuQ57aWjqj5F=FoB@mail.gmail.com>
Message-ID: <20110322081746.GA17264@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 21, 2011 at 07:00:57PM -0700, Barry Song wrote:
> For sa1111, why don't PCB design just connect one sdram to bank0 and
> make software use bank0 as DMA bank if bank0 is not slower than
> bank1/2/3? If bank0 is same with bank1/2/3 in hardware timing, there
> is no reason to make a strange design which uses bank1/2/3 as DMA
> area.

Who knows why board and SoC designers do silly things.  If we could stop
that, the kernel would be *much* simpler.
