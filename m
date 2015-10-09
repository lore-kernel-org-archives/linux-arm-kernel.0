From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 9 Oct 2015 00:03:57 -0700
Subject: [PATCH 05/10] clk: iproc: Add PLL base write function
In-Reply-To: <1443826665-17570-6-git-send-email-jonmason@broadcom.com>
References: <1443826665-17570-1-git-send-email-jonmason@broadcom.com>
 <1443826665-17570-6-git-send-email-jonmason@broadcom.com>
Message-ID: <20151009070357.GN26883@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02, Jon Mason wrote:
> diff --git a/drivers/clk/bcm/clk-iproc-pll.c b/drivers/clk/bcm/clk-iproc-pll.c
> index e029ab3..a4602aa 100644
> --- a/drivers/clk/bcm/clk-iproc-pll.c
> +++ b/drivers/clk/bcm/clk-iproc-pll.c
> @@ -137,6 +137,18 @@ static int pll_wait_for_lock(struct iproc_pll *pll)
>  	return -EIO;
>  }
>  
> +static void iproc_pll_write(struct iproc_pll *pll, void __iomem *base,

Seems that pll could be const too?

> +			    u32 offset, u32 val)
> +{
> +	const struct iproc_pll_ctrl *ctrl = pll->ctrl;
> +

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
