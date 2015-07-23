From: labbott@redhat.com (Laura Abbott)
Date: Thu, 23 Jul 2015 08:29:14 -0700
Subject: [RFC] arm64:use set_fixmap_offset to make it more clear
In-Reply-To: <A5D61263-B664-469F-9F49-160D6E17F432@gmail.com>
References: <A5D61263-B664-469F-9F49-160D6E17F432@gmail.com>
Message-ID: <55B1084A.5020303@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2015 04:45 AM, yalin wang wrote:
> A little change to patch_map() function,
> use set_fixmap_offset() to make code more clear.
>
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>   arch/arm64/kernel/insn.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index dd9671c..7dafd5a 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -101,9 +101,8 @@ static void __kprobes *patch_map(void *addr, int fixmap)
>   		return addr;
>
>   	BUG_ON(!page);
> -	set_fixmap(fixmap, page_to_phys(page));
> -
> -	return (void *) (__fix_to_virt(fixmap) + (uintaddr & ~PAGE_MASK));
> +	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> +			(addr & ~PAGE_MASK));
>   }
>
>   static void __kprobes patch_unmap(int fixmap)
>

Reviewed-by: Laura Abbott <labbott@redhat.com>
