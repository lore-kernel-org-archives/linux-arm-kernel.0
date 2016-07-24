From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sun, 24 Jul 2016 11:09:02 +0200
Subject: [PATCH v3 2/7] clk: rockchip: add new clock-type for the ddrclk
In-Reply-To: <1469178440-4668-3-git-send-email-hl@rock-chips.com>
References: <1469178440-4668-1-git-send-email-hl@rock-chips.com>
 <1469178440-4668-3-git-send-email-hl@rock-chips.com>
Message-ID: <1619904.zXvqDRdkgD@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 22. Juli 2016, 17:07:15 schrieb Lin Huang:
> @@ -488,6 +496,25 @@ struct rockchip_clk_branch {
>  		.child		= ch,				\
>  	}
> 
> +#define COMPOSITE_DDRC(_id, cname, pnames, f, mo, ms, mw, mf,	\
> +			 ds, dw, df)				\
> +	{							\
> +		.id		= _id,				\
> +		.branch_type	= branch_ddrc,			\
> +		.name		= cname,			\
> +		.parent_names	= pnames,			\
> +		.num_parents	= ARRAY_SIZE(pnames),		\
> +		.flags		= f,				\
> +		.muxdiv_offset	= mo,				\
> +		.mux_shift	= ms,				\
> +		.mux_width	= mw,				\
> +		.mux_flags	= mf,				\
> +		.div_shift	= ds,				\
> +		.div_width	= dw,				\
> +		.div_flags	= df,				\
> +		.gate_offset	= -1,				\
> +	}
> +

the mux and div-flags are not used in your clock type. Instead I think we could 
go a similar way as the inverter-type, having one flag type, which could for 
example encode the interface type ROCKCHIP_DDRCLK_SIP, etc.

Because right now there exist 3 types on how to set the ddr clk, SIP, an SCPI-
variant and through code in SRAM (rk3288), while the core clock type on the 
side of the CRU is pretty much the same.

And while it is definitly not necessary to do that now, I think the ddrclk-type 
can hold the other interfaces as well in the future.


Heiko
