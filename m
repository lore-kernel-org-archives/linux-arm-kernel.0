From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Feb 2015 11:24:18 +0100
Subject: [PATCH] ARM: dma-mapping: support non-consistent DMA attribute
In-Reply-To: <1424810703-20382-1-git-send-email-drake@endlessm.com>
References: <1424810703-20382-1-git-send-email-drake@endlessm.com>
Message-ID: <16874142.jSTJ8OZePS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 14:45:03 Daniel Drake wrote:
> Currently when arm_dma_mmap() is called, vm_page_prot is reset
> according to DMA attributes. Currently, writecombine is the
> only attribute supported; any other configuration will map uncached
> memory.
> 
> Add support for the non-consistent attribute so that cachable memory
> can be mapped into userspace via the dma_mmap_attrs() API.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>
> 

How does the user process enforce consistency then?

	Arnd
