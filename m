From: nm@ti.com (Nishanth Menon)
Date: Wed, 19 Jun 2013 08:30:23 -0500
Subject: [PATCHv2 10/11] ARM: dts: omap4 clock data
In-Reply-To: <1371647942-4811-11-git-send-email-t-kristo@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-11-git-send-email-t-kristo@ti.com>
Message-ID: <20130619133022.GA30364@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:19-20130619, Tero Kristo wrote:
<snip>
> diff --git a/arch/arm/boot/dts/omap4-clocks.dtsi b/arch/arm/boot/dts/omap4-clocks.dtsi
> new file mode 100644
> index 0000000..b420d8a
> --- /dev/null
> +++ b/arch/arm/boot/dts/omap4-clocks.dtsi
[...]
> +/* XXX Missing round_rate, set_rate in ops */
could be dropped?
> +dpll_core_m3x2_div_ck: dpll_core_m3x2_div_ck at 4a004134 {
> +	compatible = "divider-clock";
> +	clocks = <&dpll_core_x2_ck>;
> +	#clock-cells = <0>;
> +	reg = <0x4a004134 0x4>;
> +	bit-mask = <0x1f>;
> +	index-starts-at-one;
> +};
[..]
> +
> +/* XXX Missing round_rate, set_rate in ops */
could be dropped?
> +dpll_per_m3x2_div_ck: dpll_per_m3x2_div_ck at 4a008154 {
> +	compatible = "divider-clock";
> +	clocks = <&dpll_per_x2_ck>;
> +	#clock-cells = <0>;
> +	reg = <0x4a008154 0x4>;
> +	bit-mask = <0x1f>;
> +	index-starts-at-one;
> +};
> +
[...]
> +
> +/*
> + * clocks specific to omap4460
> + */
> +/*
> + * clocks specific to omap4430
> + */
> +/*
> + * clocks common to omap44xx
> + */
could be dropped?

btw, are we differentiating 4430 and 4460?A
Example:
bandgap_fclk in 4430
Vs
div_ts_ck, bandgap_ts_fclk in 4460?


-- 
Regards,
Nishanth Menon
