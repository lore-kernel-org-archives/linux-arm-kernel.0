From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 Mar 2015 16:34:12 +0000
Subject: some question about Set bit 22 in the PL310 (cache controller)
 AuxCtlr register
In-Reply-To: <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
References: <CAOVJa8Euj-VC-r0uQdyxqRtU7v23t3UW=wWTbrTCz_6gSp4x6g@mail.gmail.com>
 <20150310163133.GC13687@e104818-lin.cambridge.arm.com>
Message-ID: <20150310163411.GR8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 04:31:34PM +0000, Catalin Marinas wrote:
> It's not entirely safe either. I guess the assumption is that CMA
> allocates from highmem which is not mapped in the kernel linear mapping.
> However, to be able to flush the caches for such highmem pages, they
> need to be mapped (kmap_atomic() in __dma_clear_buffer()) but there is a
> small window between dmac_flush_range() and kunmap_atomic() where
> speculative cache line fills can still happen.

That really ought to be fixed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
