From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 29 Aug 2014 15:08:21 +0200
Subject: [PATCH 2/4] clk: mvebu: armada-370: Fix timer drift caused by
 the SSCG deviation
In-Reply-To: <1409312620-20631-3-git-send-email-gregory.clement@free-electrons.com>
References: <1409312620-20631-1-git-send-email-gregory.clement@free-electrons.com>
 <1409312620-20631-3-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140829150821.66f1d03d@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Fri, 29 Aug 2014 13:43:38 +0200, Gregory CLEMENT wrote:

> +bool a370_is_sscg_enabled(void __iomem *sar)

Minor nit: "static" is missing here.

> +{
> +	return !(readl(sar) & SARL_A370_SSCG_ENABLE);
> +}
> +
>  static const struct coreclk_soc_desc a370_coreclks = {
>  	.get_tclk_freq = a370_get_tclk_freq,
>  	.get_cpu_freq = a370_get_cpu_freq,
>  	.get_clk_ratio = a370_get_clk_ratio,
> +	.is_sscg_enabled = a370_is_sscg_enabled,
>  	.ratios = a370_coreclk_ratios,
>  	.num_ratios = ARRAY_SIZE(a370_coreclk_ratios),
>  };

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
