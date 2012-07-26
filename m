From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 26 Jul 2012 17:49:24 +0100
Subject: [PATCH 2/2] ARM: mm: use 5 bits for swapfile type encoding
In-Reply-To: <1343318468-10412-3-git-send-email-will.deacon@arm.com>
References: <1343318468-10412-1-git-send-email-will.deacon@arm.com>
 <1343318468-10412-3-git-send-email-will.deacon@arm.com>
Message-ID: <20120726164924.GD29764@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 05:01:08PM +0100, Will Deacon wrote:
> Page migration encodes the pfn in the offset field of a swp_entry_t.
> For LPAE, we support physical addresses of up to 36 bits (due to
> sparsemem limitations with the size of page flags), requiring 24 bits
> to represent a pfn. A further 3 bits are used to encode a swp_entry into
> a pte, leaving 5 bits for the type field. Furthermore, the core code
> defines MAX_SWAPFILES_SHIFT as 5, so the additional type bit does not
> get used.
> 
> This patch reduces the width of the type field to 5 bits, allowing us
> to create up to 31 swapfiles of 64GB each.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
