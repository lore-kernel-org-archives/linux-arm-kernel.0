From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 15 Feb 2011 15:24:06 +0000
Subject: [PATCH v4 16/19] ARM: LPAE: Use generic dma_addr_t type definition
In-Reply-To: <20110215142730.GM4152@n2100.arm.linux.org.uk>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-17-git-send-email-catalin.marinas@arm.com>
	<20110212103413.GD15616@n2100.arm.linux.org.uk>
	<1297688490.31111.38.camel@e102109-lin.cambridge.arm.com>
	<20110215142730.GM4152@n2100.arm.linux.org.uk>
Message-ID: <1297783446.14691.167.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-02-15 at 14:27 +0000, Russell King - ARM Linux wrote:
> On Mon, Feb 14, 2011 at 01:01:30PM +0000, Catalin Marinas wrote:
> > Maybe we could make the dma_addr_t size configurable (and disabled by
> > default) since I expect there'll be platforms capable of >32-bit DMA.
> 
> It would be far better to fix the dma_addr_t abuses.

That's not a simple task, I have no idea how many drivers get used on
ARM systems. We can defer this until people start using Cortex-A15 in
real hardware and only fix the drivers they need.

BTW, can sparse help here (I haven't used it much)?

-- 
Catalin
