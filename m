From: olof@lixom.net (Olof Johansson)
Date: Mon, 1 Feb 2016 12:18:16 -0800
Subject: [PATCH] ARM: tango: use const and __initconst for smp_operations
In-Reply-To: <1453721622-15437-1-git-send-email-yamada.masahiro@socionext.com>
References: <1453721622-15437-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20160201201816.GC13508@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 08:33:42PM +0900, Masahiro Yamada wrote:
> This newly added code missed the global fixup by commit 75305275a721
> ("ARM: use const and __initconst for smp_operations").  So fix it now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to fixes, thanks.


-Olof
> ---
> 
>  arch/arm/mach-tango/platsmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-tango/platsmp.c b/arch/arm/mach-tango/platsmp.c
> index a18d5a3..a21f55e 100644
> --- a/arch/arm/mach-tango/platsmp.c
> +++ b/arch/arm/mach-tango/platsmp.c
> @@ -9,7 +9,7 @@ static int tango_boot_secondary(unsigned int cpu, struct task_struct *idle)
>  	return 0;
>  }
>  
> -static struct smp_operations tango_smp_ops __initdata = {
> +static const struct smp_operations tango_smp_ops __initconst = {
>  	.smp_boot_secondary	= tango_boot_secondary,
>  };
>  
> -- 
> 1.9.1
> 
