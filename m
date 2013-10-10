From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 10 Oct 2013 12:43:07 +0200
Subject: [PATCH 2/5] clk: tegra: Add periph regs bank X
In-Reply-To: <1380878014-22088-3-git-send-email-pdeschrijver@nvidia.com>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
 <1380878014-22088-3-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20131010104306.GB6735@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 04, 2013 at 12:12:41PM +0300, Peter De Schrijver wrote:
> Tegra124 has an extra bank of peripheral clock registers. Add it to the
> generic peripheral clock code.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/clk.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index c8c84ce..0240dc3 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -57,6 +57,8 @@
>  #define RST_DEVICES_CLR_V		0x434
>  #define RST_DEVICES_SET_W		0x438
>  #define RST_DEVICES_CLR_W		0x43c
> +#define RST_DEVICES_SET_X		0x290
> +#define RST_DEVICES_CLR_X		0x294

Perhaps sort these numerically rather than alphabetically? Also I don't
see where the CLK_OUT_ENB_X, CLK_OUT_ENB_{SET,CLR}_X or RST_DEVICES_X
registers are defined. Perhaps they were part of some other patch or a
series that this depends on?

>  
>  /* Global data of Tegra CPU CAR ops */
>  static struct tegra_cpu_car_ops dummy_car_ops;
> @@ -109,6 +111,14 @@ static struct tegra_clk_periph_regs periph_regs[] = {
>  		.rst_set_reg = RST_DEVICES_SET_W,
>  		.rst_clr_reg = RST_DEVICES_CLR_W,
>  	},
> +	[5] = {
> +		.enb_reg = CLK_OUT_ENB_X,
> +		.enb_set_reg = CLK_OUT_ENB_SET_X,
> +		.enb_clr_reg = CLK_OUT_ENB_CLR_X,
> +		.rst_reg = RST_DEVICES_X,
> +		.rst_set_reg = RST_DEVICES_SET_X,
> +		.rst_clr_reg = RST_DEVICES_CLR_X,
> +	},
>  };

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131010/6e018d46/attachment.sig>
