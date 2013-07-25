From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Jul 2013 17:02:08 +0100
Subject: [PATCH] ARM: kdgb: use .inst for data to be assembled as
 intruction
In-Reply-To: <1374763778-5305-2-git-send-email-ben.dooks@codethink.co.uk>
References: <1374763778-5305-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374763778-5305-2-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20130725160208.GD12827@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 03:49:38PM +0100, Ben Dooks wrote:
> The arch_kgdb_breakpoint() function uses an inline assembly directive
> to assemble a specific instruction using .word. This means the linker
> will not treat is as an instruction, and therefore incorrectly swap
> the endian-ness if running BE8.
> 
> Note, not tested, please comment if this is wrong.

Can't you just look at the vmlinux disassembly to confirm this is working
correctly?

Will

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/arm/include/asm/kgdb.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/asm/kgdb.h b/arch/arm/include/asm/kgdb.h
> index 48066ce..76227c8 100644
> --- a/arch/arm/include/asm/kgdb.h
> +++ b/arch/arm/include/asm/kgdb.h
> @@ -41,7 +41,7 @@
>  
>  static inline void arch_kgdb_breakpoint(void)
>  {
> -	asm(".word 0xe7ffdeff");
> +	asm(".inst 0xe7ffdeff");
>  }
>  
>  extern void kgdb_handle_bus_error(void);
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
