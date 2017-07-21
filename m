From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 21 Jul 2017 09:19:48 +0200
Subject: [PATCH v2 02/10] clk: sunxi-ng: Add MP_MMC clocks that support
 MMC timing modes switching
In-Reply-To: <20170720034452.15920-3-wens@csie.org>
References: <20170720034452.15920-1-wens@csie.org>
 <20170720034452.15920-3-wens@csie.org>
Message-ID: <20170721071948.jofji4lwbq6s4ims@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 11:44:44AM +0800, Chen-Yu Tsai wrote:
> +/* Special class of M-P clock that supports MMC timing modes */
> +
> +#define SUNXI_CCU_MP_MMC_WITH_MUX_GATE(_struct, _name, _parents, _reg,	\
> +				       _mshift, _mwidth,		\
> +				       _pshift, _pwidth,		\
> +				       _muxshift, _muxwidth,		\
> +				       _gate, _flags)			\
> +	struct ccu_mp _struct = {					\
> +		.enable	= _gate,					\
> +		.m	= _SUNXI_CCU_DIV(_mshift, _mwidth),		\
> +		.p	= _SUNXI_CCU_DIV(_pshift, _pwidth),		\
> +		.mux	= _SUNXI_CCU_MUX(_muxshift, _muxwidth),		\
> +		.common	= {						\
> +			.reg		= _reg,				\
> +			.features	= CCU_FEATURE_MMC_TIMING_SWITCH, \
> +			.hw.init	= CLK_HW_INIT_PARENTS(_name,	\
> +							      _parents, \
> +							      &ccu_mp_mmc_ops, \
> +							      _flags),	\
> +		}							\
> +	}
> +
> +extern const struct clk_ops ccu_mp_mmc_ops;
> +

I guess we can simplify a lot that macro, all the new-timings MMC
clocks have the same register layout.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170721/2c7a8bc6/attachment.sig>
