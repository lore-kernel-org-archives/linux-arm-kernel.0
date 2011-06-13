From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 13 Jun 2011 16:40:33 +0100
Subject: [RFC 0/2] ARM: DMA-mapping & IOMMU integration
In-Reply-To: <BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
References: <1306308920-8602-1-git-send-email-m.szyprowski@samsung.com>
	<BANLkTi=HtrFETnjk1Zu0v9wqa==r0OALvA@mail.gmail.com>
	<201106131707.49217.arnd@arndb.de>
	<BANLkTikR5AE=-wTWzrSJ0TUaks0_rA3mcg@mail.gmail.com>
Message-ID: <20110613154033.GA29185@1n450.cable.virginmedia.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2011 at 12:30:44AM +0900, KyongHo Cho wrote:
> On Tue, Jun 14, 2011 at 12:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > I'm sure that the graphics people will disagree with you on that.
> > Having the frame buffer mapped in write-combine mode is rather
> > important when you want to efficiently output videos from your
> > CPU.
>
> I agree with you.
> But I am discussing about dma_alloc_writecombine() in ARM.
> You can see that only ARM and AVR32 implement it and there are few
> drivers which use it.
> No function in dma_map_ops corresponds to dma_alloc_writecombine().
> That's why Marek tried to add 'alloc_writecombine' to dma_map_ops.

FWIW, on ARMv6 and later hardware, the dma_alloc_coherent() provides
writecombine memory (i.e. Normal Noncacheable), so no need for
dma_alloc_writecombine(). On earlier architectures it is creating
Strongly Ordered mappings (no writecombine).

-- 
Catalin
