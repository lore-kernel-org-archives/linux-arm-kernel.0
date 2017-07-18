From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 18 Jul 2017 22:48:21 +0300
Subject: [PATCH v6 1/3] clk: nxp: clk-lpc32xx: rename clk_gate_is_enabled()
In-Reply-To: <1500364414-10021-2-git-send-email-gabriel.fernandez@st.com>
References: <1500364414-10021-1-git-send-email-gabriel.fernandez@st.com>
 <1500364414-10021-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20f6a994-26b4-578c-d641-395639ebac0f@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gabriel,

On 07/18/2017 10:53 AM, gabriel.fernandez at st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> We need to export clk_gate_is_enabled() from clk framework, then

first of all let's clarify if you really need to export clk_gate_is_enabled()
from the CCF.

> to avoid compilation issue we have to rename clk_gate_is_enabled()
> in NXP LPC32xx clock driver.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/clk/nxp/clk-lpc32xx.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/nxp/clk-lpc32xx.c b/drivers/clk/nxp/clk-lpc32xx.c
> index 5b98ff9..1cc71ad 100644
> --- a/drivers/clk/nxp/clk-lpc32xx.c
> +++ b/drivers/clk/nxp/clk-lpc32xx.c
> @@ -903,7 +903,7 @@ static void clk_gate_disable(struct clk_hw *hw)
>  	regmap_update_bits(clk_regmap, clk->reg, mask, val);
>  }
>  
> -static int clk_gate_is_enabled(struct clk_hw *hw)
> +static int __clk_gate_is_enabled(struct clk_hw *hw)
>  {
>  	struct lpc32xx_clk_gate *clk = to_lpc32xx_gate(hw);
>  	u32 val;
> @@ -918,7 +918,7 @@ static int clk_gate_is_enabled(struct clk_hw *hw)
>  static const struct clk_ops lpc32xx_clk_gate_ops = {
>  	.enable = clk_gate_enable,
>  	.disable = clk_gate_disable,
> -	.is_enabled = clk_gate_is_enabled,
> +	.is_enabled = __clk_gate_is_enabled,

In case if this change gets continuation, here I want to see the same
prefixes for all functions and no underscores, namely it shall be
* lpc32xx_clk_gate_enable(),
* lpc32xx_clk_gate_disable(),
* lpc32xx_clk_gate_is_enabled().

>  };
>  
>  #define div_mask(width)	((1 << (width)) - 1)
> 

--
With best wishes,
Vladimir
