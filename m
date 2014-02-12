From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 10:30:07 +0000
Subject: [PATCH] arm64: vdso: clean up vdso_pagelist initialization
In-Reply-To: <1392157722-6372-1-git-send-email-nathan_lynch@mentor.com>
References: <1392157722-6372-1-git-send-email-nathan_lynch@mentor.com>
Message-ID: <20140212103007.GF13441@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 10:28:42PM +0000, Nathan Lynch wrote:
> Remove some unnecessary bits that were apparently carried over from
> another architecture's implementation:
> 
> - No need to get_page() the vdso text/data - these are part of the
>   kernel image.
> - No need for ClearPageReserved on the vdso text.
> - No need to vmap the first text page to check the ELF header - this
>   can be done through &vdso_start.
> 
> Also some minor cleanup:
> - Use kcalloc for vdso_pagelist array allocation.
> - Don't print on allocation failure, slab/slub will do that for us.
> 
> Signed-off-by: Nathan Lynch <nathan_lynch@mentor.com>

Thanks Nathan, this cleans things up a bit.

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
