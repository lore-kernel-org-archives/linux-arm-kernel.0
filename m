From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 9 Oct 2018 22:56:14 +0000
Subject: [PATCH v10 4/5] clk: imx: add imx composite clock
In-Reply-To: <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
References: <1539074230-27277-1-git-send-email-abel.vesa@nxp.com>
 <1539074230-27277-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <5c0cc4de8403fca17431a9382f7e34e8003f497b.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-10-09 at 08:37 +0000, Abel Vesa wrote:
> +struct clk *imx_clk_composite_8m_flags(const char *name,
> +					const char **parent_names,
> +					int num_parents, void __iomem *reg,
> +					unsigned long flags);
> +
> +#define __imx_clk_composite_8m(name, parent_names, reg, flags) \
> +	imx_clk_composite_8m_flags(name, parent_names, \
> +		ARRAY_SIZE(parent_names), reg, \
> +		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
> +
> +#define imx_clk_composite_8m(name, parent_names, reg) \
> +	__imx_clk_composite_8m(name, parent_names, reg, 0)
> +
> +#define imx_clk_composite_8m_critical(name, parent_names, reg) \
> +	__imx_clk_composite_8m(name, parent_names, reg, CLK_IS_CRITICAL)

Does anyone else think that the "8m" would be prettier next to imx
rather than as a suffix? Using imx8m_clk_composite* and
imx7ulp_clk_composite* makes more sense to me.

--
Regards,
Leonard
