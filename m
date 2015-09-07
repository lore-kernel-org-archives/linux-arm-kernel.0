From: jungseoklee85@gmail.com (Jungseok Lee)
Date: Mon, 7 Sep 2015 23:03:35 +0900
Subject: [PATCH V2] arm64: add kc_offset_to_vaddr and kc_vaddr_to_offset
 macro
In-Reply-To: <1441512250-9667-1-git-send-email-yalin.wang2010@gmail.com>
References: <1441512250-9667-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <6F07C7AF-779B-439D-B820-E11816664406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sep 6, 2015, at 1:04 PM, yalin wang wrote:

Hello Yalin,

> This patch add kc_offset_to_vaddr() and kc_vaddr_to_offset(),
> the default version doesn't work on arm64, because arm64 kernel address
> is below the PAGE_OFFSET, like module address and vmemmap address are
> all below PAGE_OFFSET address.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
> arch/arm64/include/asm/memory.h  | 1 +
> arch/arm64/include/asm/pgtable.h | 2 ++
> 2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
> index f800d45..2d09fe8 100644
> --- a/arch/arm64/include/asm/memory.h
> +++ b/arch/arm64/include/asm/memory.h
> @@ -55,6 +55,7 @@
> #define PCI_IO_START		(PCI_IO_END - PCI_IO_SIZE)
> #define FIXADDR_TOP		(PCI_IO_START - SZ_2M)
> #define TASK_SIZE_64		(UL(1) << VA_BITS)
> +#define __VIRTUAL_MASK		((1UL << VA_BITS) - 1)

According to Catalin's comment, [1], it might need to be rewritten using VA_START
in the KASan patches, [2], after this merge window.

[1] https://lkml.org/lkml/2015/9/4/529
[2] git://github.com/aryabinin/linux.git kasan/arm64v5

Best Regards
Jungseok Lee
