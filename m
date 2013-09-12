From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Sep 2013 18:35:54 +0100
Subject: [PATCH] dma: use %pa to print dma_addr_t
In-Reply-To: <CAOesGMi2VkBzvXtK9eftViaWBRFGdv6TgzYZ6NCKQfhKWZGVWA@mail.gmail.com>
References: <1378960710-15648-1-git-send-email-olof@lixom.net>
 <5231F45C.3020500@infradead.org>
 <CAOesGMi2VkBzvXtK9eftViaWBRFGdv6TgzYZ6NCKQfhKWZGVWA@mail.gmail.com>
Message-ID: <20130912173554.GQ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 10:11:44AM -0700, Olof Johansson wrote:
> Any >32bit-addressable machine will likely want 64-bit dma_addr_t as
> well. The only architecture that doesn't seem to set
> ARCH_DMA_ADDR_T_64BIT based on PHYS_ADDR_T size is ARM, and I think
> that should just be changed there as well.

Do we actually have any 64-bit DMA controllers out there?  As far as
I'm aware, all our DMA controllers are all 32-bit address only.  That
makes a 64-bit dma_addr_t rather silly.

Remember that dma_addr_t is the value you program into the DMA
controller, and _not_ the actual physical address.
