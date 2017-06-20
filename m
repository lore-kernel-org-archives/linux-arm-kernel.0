From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 19:00:13 -0700
Subject: [PATCH 6/9] clk: imx: add composite clk support
In-Reply-To: <1494856763-6543-7-git-send-email-aisheng.dong@nxp.com>
References: <1494856763-6543-1-git-send-email-aisheng.dong@nxp.com>
 <1494856763-6543-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170620020013.GP4493@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/15, Dong Aisheng wrote:
> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
> index 51b84e4..665777e 100644
> --- a/drivers/clk/imx/clk.h
> +++ b/drivers/clk/imx/clk.h
> @@ -69,6 +69,12 @@ struct clk *imx_clk_busy_mux(const char *name, void __iomem *reg, u8 shift,
>  			     u8 width, void __iomem *busy_reg, u8 busy_shift,
>  			     const char **parent_names, int num_parents);
>  
> +struct clk *imx_clk_composite(const char *name,
> +			      const char * const *parent_names,
> +			      int num_parents, bool mux_present,
> +			      bool rate_present, bool gate_present,
> +			      void __iomem *reg);
> +
>  struct clk *imx_clk_fixup_divider(const char *name, const char *parent,
>  				  void __iomem *reg, u8 shift, u8 width,
>  				  void (*fixup)(u32 *val));
> @@ -209,5 +215,4 @@ static inline struct clk *imx_clk_mux_flags(const char *name,
>  struct clk *imx_clk_cpu(const char *name, const char *parent_name,
>  		struct clk *div, struct clk *mux, struct clk *pll,
>  		struct clk *step);
> -

Noise?

>  #endif
> -- 
> 2.7.4
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
