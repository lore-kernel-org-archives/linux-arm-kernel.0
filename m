From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 10 Oct 2015 23:02:15 +0200
Subject: [PATCH 5/5] arm: add missing of_node_put
In-Reply-To: <1444480254-14399-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1444480254-14399-1-git-send-email-Julia.Lawall@lip6.fr>
 <1444480254-14399-6-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <8655275.vMqHQfLN9g@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 10 October 2015 14:30:54 Julia Lawall wrote:
> diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
> index 11c54de..432ff34 100644
> --- a/arch/arm/kernel/devtree.c
> +++ b/arch/arm/kernel/devtree.c
> @@ -143,6 +143,7 @@ void __init arm_dt_init_cpu_maps(void)
>                                                "max cores %u, capping them\n",
>                                                cpuidx, nr_cpu_ids)) {
>                         cpuidx = nr_cpu_ids;
> +                       of_node_put(cpu);
>                         break;
>                 }
> 

The same for_each_child_of_node() loop has three 'return' statements'
aside from the 'break' statement here. I think you should change your
semantic patch to cover both cases.

	Arnd
