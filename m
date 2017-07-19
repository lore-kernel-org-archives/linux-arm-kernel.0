From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 19 Jul 2017 10:02:20 +0200
Subject: [PATCH] ARM: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-1-robh@kernel.org>
References: <20170718214339.7774-1-robh@kernel.org>
Message-ID: <3802101.Kq7DfALjfy@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 18. Juli 2017, 16:42:41 CEST schrieb Rob Herring:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

for the Rockchip part
Acked-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/arch/arm/mach-rockchip/platsmp.c b/arch/arm/mach-rockchip/platsmp.c
> index 3abafdbdd7f4..2b5b0e43d657 100644
> --- a/arch/arm/mach-rockchip/platsmp.c
> +++ b/arch/arm/mach-rockchip/platsmp.c
> @@ -182,8 +182,8 @@ static int __init rockchip_smp_prepare_sram(struct device_node *node)
> 
>  	ret = of_address_to_resource(node, 0, &res);
>  	if (ret < 0) {
> -		pr_err("%s: could not get address for node %s\n",
> -		       __func__, node->full_name);
> +		pr_err("%s: could not get address for node %pOF\n",
> +		       __func__, node);
>  		return ret;
>  	}
> 
