From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Aug 2016 17:41:31 -0700
Subject: [PATCH v9 03/10] clk: mediatek: Refine the makefile to support
 multiple clock drivers
In-Reply-To: <1466581229-2342-4-git-send-email-erin.lo@mediatek.com>
References: <1466581229-2342-1-git-send-email-erin.lo@mediatek.com>
 <1466581229-2342-4-git-send-email-erin.lo@mediatek.com>
Message-ID: <20160813004131.GB361@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22, Erin Lo wrote:
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> new file mode 100644
> index 0000000..dc224e6
> --- /dev/null
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -0,0 +1,23 @@
> +#
> +# MediaTek SoC drivers
> +#
> +config COMMON_CLK_MEDIATEK
> +	bool
> +	---help---
> +	  Mediatek SoCs' clock support.
> +
> +config COMMON_CLK_MT8135
> +	bool "Clock driver for Mediatek MT8135"
> +	depends on COMMON_CLK

These depends on COMMON_CLK are just noise because this Kconfig
file is only included if common clk is enabled. Please remove
them.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
