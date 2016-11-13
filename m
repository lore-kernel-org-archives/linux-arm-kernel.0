From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 13 Nov 2016 12:30:54 +0800
Subject: [PATCH 5/10] clk: sunxi-ng: Implement multiplier maximum
In-Reply-To: <1d12cf2cb0a7364f17691705f3bd018eddc51202.1478625788.git-series.maxime.ripard@free-electrons.com>
References: <cover.326f50aecc25fbe292184527b52a1e3172aba9cf.1478625788.git-series.maxime.ripard@free-electrons.com>
 <1d12cf2cb0a7364f17691705f3bd018eddc51202.1478625788.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67+vqpVJ+nywp_qXaYgyR75apu9OvMZgoGoTgQTztTQwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 1:23 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/ccu_mult.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_mult.h b/drivers/clk/sunxi-ng/ccu_mult.h
> index 84839641dfdf..524acddfcb2e 100644
> --- a/drivers/clk/sunxi-ng/ccu_mult.h
> +++ b/drivers/clk/sunxi-ng/ccu_mult.h
> @@ -10,24 +10,26 @@ struct ccu_mult_internal {
>         u8      shift;
>         u8      width;
>         u8      min;
> +       u8      max;
>  };
>
> -#define _SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, _offset, _min)      \
> +#define _SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, _offset, _min, _max) \
>         {                                                               \
>                 .min    = _min,                                         \
> +               .max    = _max,                                         \
>                 .offset = _offset,                                      \
>                 .shift  = _shift,                                       \
>                 .width  = _width,                                       \
>         }
>
>  #define _SUNXI_CCU_MULT_MIN(_shift, _width, _min)      \
> -       _SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, 1, _min)
> +       _SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, 1, _min, 0)
>
>  #define _SUNXI_CCU_MULT_OFFSET(_shift, _width, _offset)        \
> -       _SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, _offset, 1)
> +       _SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, _offset, 1, 0)
>
>  #define _SUNXI_CCU_MULT(_shift, _width)                \
> -       _SUNXI_CCU_MULT_OFFSET_MIN(_shift, _width, 1, 1)
> +       _SUNXI_CCU_MULT_OFFSET_MIN_MAX(_shift, _width, 1, 1, 0)
>
>  struct ccu_mult {
>         u32                     enable;
> --
> git-series 0.8.11

You're missing the code that actually uses the maximum value.

ChenYu
