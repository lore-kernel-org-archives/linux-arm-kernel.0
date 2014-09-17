From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Sep 2014 17:28:23 +0100
Subject: [PATCH] arm64:free_initrd_mem should also free the memblock
In-Reply-To: <35FD53F367049845BC99AC72306C23D103D6DB49160C@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103CDBFBFB029@CNBJMBX05.corpusers.net>
 <20140915183334.GA30737@arm.com>
 <20140915184023.GF12361@n2100.arm.linux.org.uk>
 <20140915185027.GC30737@arm.com>
 <35FD53F367049845BC99AC72306C23D103D6DB49160C@CNBJMBX05.corpusers.net>
Message-ID: <20140917162822.GB15261@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 02:53:55AM +0100, Wang, Yalin wrote:
> The reason that a want merge this patch is that
> It confuse me when I debug memory issue by 
> /sys/kernel/debug/memblock/reserved  debug file,
> It show lots of un-correct reserved memory.
> In fact, I also send a patch to cma driver part
> For this issue too:
> http://ozlabs.org/~akpm/mmots/broken-out/free-the-reserved-memblock-when-free-cma-pages.patch
> 
> I want to remove these un-correct memblock parts as much as possible,
> so that I can see more correct info from /sys/kernel/debug/memblock/reserved
> debug file .

Could we not always call memblock_free() from free_reserved_area() (with
a dummy definition when !CONFIG_HAVE_MEMBLOCK)?

-- 
Catalin
