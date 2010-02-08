From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Feb 2010 10:19:44 +0000
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <20100208073334.GB7171@rhlx01.hs-esslingen.de>
References: <20100208073334.GB7171@rhlx01.hs-esslingen.de>
Message-ID: <1265624384.4020.25.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2010-02-08 at 07:33 +0000, Andreas Mohr wrote:
> On Mon, Feb 08, 2010 at 07:55:19AM +0100, Pavel Machek wrote:
> > Plus it does unneccessary flushes on x86, etc...
> 
> Noticed that as well, there should be an arch-obeying helper for this.
> 
> 
> On my MIPSEL, I had urb->transfer_buffer NULL ptr crashes
> (I think that was expected in case of a certain DMA setup, Alan said).
> 
> However, even with NULL check added I still had:
> 
> hub 2-1.1:1.0: state 7 ports 7 chg 0000 evt 0010
> Unhandled kernel unaligned access[#1]:

Just to avoid confusion - that's a similar patch applied to a different
driver. The ISP1760 HCD driver works fine with my patch (transfer_buffer
never seems to be NULL with latest mainline). I can't comment on the
ehci-q.c driver (it looks like it has some support for DMA while my
patch only applies to PIO drivers where transfer_buffer should be set).

-- 
Catalin
