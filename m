From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 08 Feb 2016 17:31:20 +0100
Subject: [PATCH] ARM: mvebu: add missing of_node_put()
In-Reply-To: <1454912232-13169-1-git-send-email-yamada.masahiro@socionext.com>
 (Masahiro Yamada's message of "Mon, 8 Feb 2016 15:17:12 +0900")
References: <1454912232-13169-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <8760xz17vr.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Masahiro,
 
 On lun., f?vr. 08 2016, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This node pointer is returned by of_find_compatible_node() in this
> function.  It should be put before exitting this function.
>

Applied on mvebu/cleanup

Thanks,

Gregory

> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-mvebu/platsmp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
> index f9597b7..46c742d 100644
> --- a/arch/arm/mach-mvebu/platsmp.c
> +++ b/arch/arm/mach-mvebu/platsmp.c
> @@ -140,6 +140,7 @@ static void __init armada_xp_smp_prepare_cpus(unsigned int max_cpus)
>  		panic("Cannot find 'marvell,bootrom' compatible node");
>  
>  	err = of_address_to_resource(node, 0, &res);
> +	of_node_put(node);
>  	if (err < 0)
>  		panic("Cannot get 'bootrom' node address");
>  
> -- 
> 1.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
