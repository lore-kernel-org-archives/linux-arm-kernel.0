From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 16 May 2013 14:52:34 +0100
Subject: [RFC PATCH v2 06/11] ARM64: mm: Restore memblock limit when
 map_mem finished.
In-Reply-To: <1368006763-30774-7-git-send-email-steve.capper@linaro.org>
References: <1368006763-30774-1-git-send-email-steve.capper@linaro.org>
 <1368006763-30774-7-git-send-email-steve.capper@linaro.org>
Message-ID: <20130516135233.GB18308@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 08, 2013 at 10:52:38AM +0100, Steve Capper wrote:
> In paging_init the memblock limit is set to restrict any addresses
> returned by early_alloc to fit within the initial direct kernel
> mapping in swapper_pg_dir. This allows map_mem to allocate puds,
> pmds and ptes from the initial direct kernel mapping.
> 
> The limit stays low after paging_init() though, meaning any
> bootmem allocations will be from a restricted subset of memory.
> Gigabyte huge pages, for instance, are normally allocated from
> bootmem as their order (18) is too large for the default buddy
> allocator (MAX_ORDER = 11).
> 
> This patch restores the memblock limit when map_mem has finished,
> allowing gigabyte huge pages (and other objects) to be allocated
> from all of bootmem.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
