From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 19:33:16 +0000
Subject: [PATCH 5/5] arm: dts: Convert mvebu device tree files to 64 bits
In-Reply-To: <20130322174300.GA10230@obsidianresearch.com>
References: <1363883179-1361-1-git-send-email-gregory.clement@free-electrons.com>
 <20130322062854.GS21478@lunn.ch>
 <20130322174300.GA10230@obsidianresearch.com>
Message-ID: <201303221933.16426.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Jason Gunthorpe wrote:
> At a certain point low mem exhaustion becomes a serious issue for
> Linux, a system that can't DMA to 85% of its memory is incredibly
> broken, IMHO.

A lot of workloads will also suffer from lowmem exhaustion even without
the DMA zone problem. If course the combination is particularly nasty
because now the kernel has a to kmap() a user page in order to copy the
dma data in and out of lowmem.

I'm sure there are even workloads that perform well with more than
16GB, but I can't think of any right now. I would expect that 4 or 8 GB
is where it gets quite silly for most workloads, but troubles start as
soon as you go beyond 1GB.

	Arnd
