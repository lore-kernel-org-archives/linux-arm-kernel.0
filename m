From: james.morse@arm.com (James Morse)
Date: Mon, 18 Apr 2016 12:14:59 +0100
Subject: [PATCH v2 2/3] arm64: mm: Show bss segment in kernel memory layout
In-Reply-To: <1460948988-7477-3-git-send-email-wangkefeng.wang@huawei.com>
References: <1460533772-13314-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-1-git-send-email-wangkefeng.wang@huawei.com>
 <1460948988-7477-3-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <5714C1B3.3000005@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/16 04:09, Kefeng Wang wrote:
> Show the bss segment information as with text and data in Virtual
> memory kernel layout.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/arm64/mm/init.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index ce2e400..c96fe51 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -379,6 +379,8 @@ void __init mem_init(void)
>  		MLK_ROUNDUP(__init_begin, __init_end));
>  	pr_cont("      .data : 0x%p" " - 0x%p" "   (%6ld KB)\n",
>  		MLK_ROUNDUP(_sdata, _edata));
> +	pr_cont("       .bss : 0x%p" " - 0x%p" "   (%6ld KB)\n",
> +		MLK_ROUNDUP(__bss_start, __bss_stop));
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
>  	pr_cont("    vmemmap : 0x%16lx - 0x%16lx   (%6ld GB maximum)\n",
>  		MLG(VMEMMAP_START, VMEMMAP_START + VMEMMAP_SIZE));
> 

I think this is useful,

Acked-by: James Morse <james.morse@arm.com>


Thanks,

James
