From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 May 2014 16:49:47 +0100
Subject: [PATCH] arm64: Fix linker script entry point
In-Reply-To: <1400261161.12756.15.camel@smoke>
References: <1400195191.12756.9.camel@smoke> <20140516090116.GB12341@arm.com>
 <1400261161.12756.15.camel@smoke>
Message-ID: <20140519154947.GJ15130@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 06:26:01PM +0100, Geoff Levand wrote:
> Change the arm64 linker script ENTRY() command to define _text as the
> kernel entry point.
> 
> The arm64 boot protocol specifies that the kernel must be entered at the
> beginning of the kernel image.  The existing ENTRY() command defined the
> symbol stext as the entry point, which emitted an incorrect entry point,
> but would not cause a runtime error because the existing entry code
> immediately jumps to stext.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
> Hi Will,
> 
> As requested, here is a fix for the linker script.  There are a lot of ways
> we can define the entry point.  Let me know if you want to do it differently.

Looks good to me, thanks:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

>  arch/arm64/kernel/vmlinux.lds.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 4ba7a55..f1e6d5c 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -13,7 +13,7 @@
>  #define ARM_EXIT_DISCARD(x)	x
>  
>  OUTPUT_ARCH(aarch64)
> -ENTRY(stext)
> +ENTRY(_text)
>  
>  jiffies = jiffies_64;
>  
> -- 
> 1.9.1
> 
> 
> 
> 
