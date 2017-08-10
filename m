From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Aug 2017 18:14:34 +0100
Subject: [PATCH] arm64: fix pmem interface definition
In-Reply-To: <20170810145253.2124019-1-arnd@arndb.de>
References: <20170810145253.2124019-1-arnd@arndb.de>
Message-ID: <20170810171433.obchokljs43rmgk4@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 10, 2017 at 04:52:31PM +0200, Arnd Bergmann wrote:
> Defining the two functions as 'static inline' and exporting them
> leads to the interesting case where we can use the interface
> from loadable modules, but not from built-in drivers, as shown
> in this link failure:
> 
> vers/nvdimm/claim.o: In function `nsio_rw_bytes':
> claim.c:(.text+0x1b8): undefined reference to `arch_invalidate_pmem'
> drivers/nvdimm/pmem.o: In function `pmem_dax_flush':
> pmem.c:(.text+0x11c): undefined reference to `arch_wb_cache_pmem'
> drivers/nvdimm/pmem.o: In function `pmem_make_request':
> pmem.c:(.text+0x5a4): undefined reference to `arch_invalidate_pmem'
> pmem.c:(.text+0x650): undefined reference to `arch_invalidate_pmem'
> pmem.c:(.text+0x6d4): undefined reference to `arch_invalidate_pmem'
> 
> This removes the bogus 'static inline'.
> 
> Fixes: d50e071fdaa3 ("arm64: Implement pmem API support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied. Thanks.

-- 
Catalin
