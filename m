From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 25 Apr 2014 18:53:05 -0700
Subject: [PATCH v2] clk: qcom: Add support for IPQ8064's global clock
 controller (GCC)
In-Reply-To: <1396642749-12979-1-git-send-email-galak@codeaurora.org>
References: <1396642749-12979-1-git-send-email-galak@codeaurora.org>
Message-ID: <535B1181.4010209@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/14 13:19, Kumar Gala wrote:
> +
> +#define P_PXO	0
> +#define P_PLL8	1
> +#define P_CXO	2
> +#define P_PLL3	3

This #define needs to be 1. Unfortunately the way we do this mapping
requires that they match the parents string array. If you have a better
idea I'm all for it.

> +
> +static const u8 gcc_pxo_pll8_map[] = {
> +	[P_PXO]		= 0,
> +	[P_PLL8]	= 3,
> +};
> +
> +static const char *gcc_pxo_pll8[] = {
> +	"pxo",
> +	"pll8_vote",
> +};
> +
> +static const u8 gcc_pxo_pll8_cxo_map[] = {
> +	[P_PXO]		= 0,
> +	[P_PLL8]	= 3,
> +	[P_CXO]		= 5,
> +};
> +
> +static const char *gcc_pxo_pll8_cxo[] = {
> +	"pxo",
> +	"pll8_vote",
> +	"cxo",
> +};
> +
> +static const u8 gcc_pxo_pll3_map[] = {
> +	[P_PXO]		= 0,
> +	[P_PLL3]	= 1,
> +};
> +
> +static const char *gcc_pxo_pll3[] = {
> +	"pxo",
> +	"pll3",
> +};
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
