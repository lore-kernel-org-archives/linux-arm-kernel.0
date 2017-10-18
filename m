From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Oct 2017 09:17:54 +0530
Subject: [PATCH 2/2] CLK: SPEAr: make aux_clk_masks structures const
In-Reply-To: <1508251114-7042-3-git-send-email-bhumirks@gmail.com>
References: <1508251114-7042-1-git-send-email-bhumirks@gmail.com>
 <1508251114-7042-3-git-send-email-bhumirks@gmail.com>
Message-ID: <20171018034754.GD27082@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17-10-17, 16:38, Bhumika Goyal wrote:
> Make these const as they are either stored in the masks 'const' field
> of a clk_aux structure or passed to the function clk_register_aux 
> having the argument as const.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
>  drivers/clk/spear/clk-aux-synth.c   | 2 +-
>  drivers/clk/spear/spear1310_clock.c | 2 +-
>  drivers/clk/spear/spear1340_clock.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/spear/clk-aux-synth.c b/drivers/clk/spear/clk-aux-synth.c
> index 8bea5df..2f145e3 100644
> --- a/drivers/clk/spear/clk-aux-synth.c
> +++ b/drivers/clk/spear/clk-aux-synth.c
> @@ -29,7 +29,7 @@
>  
>  #define to_clk_aux(_hw) container_of(_hw, struct clk_aux, hw)
>  
> -static struct aux_clk_masks default_aux_masks = {
> +static const  struct aux_clk_masks default_aux_masks = {
>  	.eq_sel_mask = AUX_EQ_SEL_MASK,
>  	.eq_sel_shift = AUX_EQ_SEL_SHIFT,
>  	.eq1_mask = AUX_EQ1_SEL,
> diff --git a/drivers/clk/spear/spear1310_clock.c b/drivers/clk/spear/spear1310_clock.c
> index 2f86e3f..591248c 100644
> --- a/drivers/clk/spear/spear1310_clock.c
> +++ b/drivers/clk/spear/spear1310_clock.c
> @@ -284,7 +284,7 @@
>  };
>  
>  /* i2s prescaler1 masks */
> -static struct aux_clk_masks i2s_prs1_masks = {
> +static const struct aux_clk_masks i2s_prs1_masks = {
>  	.eq_sel_mask = AUX_EQ_SEL_MASK,
>  	.eq_sel_shift = SPEAR1310_I2S_PRS1_EQ_SEL_SHIFT,
>  	.eq1_mask = AUX_EQ1_SEL,
> diff --git a/drivers/clk/spear/spear1340_clock.c b/drivers/clk/spear/spear1340_clock.c
> index cbb19a9..e5bc8c8 100644
> --- a/drivers/clk/spear/spear1340_clock.c
> +++ b/drivers/clk/spear/spear1340_clock.c
> @@ -323,7 +323,7 @@
>  };
>  
>  /* i2s prescaler1 masks */
> -static struct aux_clk_masks i2s_prs1_masks = {
> +static const struct aux_clk_masks i2s_prs1_masks = {
>  	.eq_sel_mask = AUX_EQ_SEL_MASK,
>  	.eq_sel_shift = SPEAR1340_I2S_PRS1_EQ_SEL_SHIFT,
>  	.eq1_mask = AUX_EQ1_SEL,

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
