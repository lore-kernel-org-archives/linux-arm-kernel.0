From: michal.simek@xilinx.com (Michal Simek)
Date: Sat, 27 Oct 2012 13:59:12 +0000
Subject: [PATCH v4 4/5] ARM: annotate VMALLOC_END definition with _AC
In-Reply-To: <20121024200431.GE6713@beefymiracle.amer.corp.natinst.com>
References: <20121024200222.GA6713@beefymiracle.amer.corp.natinst.com>
 <20121024200431.GE6713@beefymiracle.amer.corp.natinst.com>
Message-ID: <3c9e591c-a29f-446b-9256-bb23ff6d840d@TX2EHSMHS014.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Josh Cartwright [mailto:josh.cartwright at ni.com]
> Sent: Wednesday, October 24, 2012 10:05 PM
> To: arm at kernel.org; Arnd Bergmann
> Cc: linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; John
> Linn; Nick Bowler; Michal Simek
> Subject: [PATCH v4 4/5] ARM: annotate VMALLOC_END definition with _AC
> 
> This makes the definition of VMALLOC_END suitable for use within assembly
> code.  This is necessary to allow the use of VMALLOC_END in defining where the
> early uart is mapped for use with DEBUG_LL.
> 
> Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/include/asm/pgtable.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 08c1231..72904a2 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -40,7 +40,7 @@
>   */
>  #define VMALLOC_OFFSET		(8*1024*1024)
>  #define VMALLOC_START		(((unsigned long)high_memory +
> VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
> -#define VMALLOC_END		0xff000000UL
> +#define VMALLOC_END		_AC(0xff000000,UL)

This shouldn't be the part of this series but should go to mainline through different tree.
Arnd, Olof: Can you take this patch to your arm-soc tree? 

I don't think it is a good workstyle to propose it to mainline through zynq soc tree.
What do you think?

Thanks,
Michal
