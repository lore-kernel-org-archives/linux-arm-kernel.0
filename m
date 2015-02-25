From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Feb 2015 11:10:42 +0000
Subject: [PATCH] arm64: mm: remove unused functions and variable protoypes
In-Reply-To: <1424832465-21181-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1424832465-21181-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20150225111041.GA17366@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 02:47:45AM +0000, Yingjoe Chen wrote:
> The functions __cpu_flush_user_tlb_range and __cpu_flush_kern_tlb_range
> were removed in commit fa48e6f780 'arm64: mm: Optimise tlb flush logic
> where we have >4K granule'. Global variable cpu_tlb was never used in
> arm64.
> 
> Remove them.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  arch/arm64/include/asm/tlbflush.h | 5 -----
>  1 file changed, 5 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 73f0ce5..4abe9b9 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -24,11 +24,6 @@
>  #include <linux/sched.h>
>  #include <asm/cputype.h>
>  
> -extern void __cpu_flush_user_tlb_range(unsigned long, unsigned long, struct vm_area_struct *);
> -extern void __cpu_flush_kern_tlb_range(unsigned long, unsigned long);
> -
> -extern struct cpu_tlb_fns cpu_tlb;
> -
>  /*
>   *	TLB Management
>   *	==============
> -- 
> 1.8.1.1.dirty
> 
> 
