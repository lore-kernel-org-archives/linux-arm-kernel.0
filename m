From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Sep 2018 12:13:25 +0100
Subject: [PATCH] arm64: Kconfig: Remove ARCH_HAS_HOLES_MEMORYMODEL
In-Reply-To: <20180831151943.9281-1-james.morse@arm.com>
References: <20180831151943.9281-1-james.morse@arm.com>
Message-ID: <20180921111324.GB238853@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 04:19:43PM +0100, James Morse wrote:
> include/linux/mmzone.h describes ARCH_HAS_HOLES_MEMORYMODEL as
> relevant when parts the memmap have been free()d. This would
> happen on systems where memory is smaller than a sparsemem-section,
> and the extra struct pages are expensive. pfn_valid() on these
> systems returns true for the whole sparsemem-section, so an extra
> memmap_valid_within() check is needed.
> 
> On arm64 we have nomap memory, so always provide pfn_valid() to test
> for nomap pages. This means ARCH_HAS_HOLES_MEMORYMODEL's extra checks
> are already rolled up into pfn_valid().
> 
> Remove it.
> 
> Signed-off-by: James Morse <james.morse@arm.com>

Queued for 4.20. Thanks.

-- 
Catalin
