From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 11 Dec 2017 12:27:17 +0100
Subject: [PATCH v6 4/6] clk: meson: make the spinlock naming more specific
In-Reply-To: <20171211064853.32111-5-yixun.lan@amlogic.com>
References: <20171211064853.32111-1-yixun.lan@amlogic.com>
 <20171211064853.32111-5-yixun.lan@amlogic.com>
Message-ID: <1512991637.334.28.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-12-11 at 14:48 +0800, Yixun Lan wrote:
>                 .ops = &clk_gate_ops,
> diff --git a/drivers/clk/meson/clkc.h b/drivers/clk/meson/clkc.h
> index 1629da9b4141..87f06a801a4d 100644
> --- a/drivers/clk/meson/clkc.h
> +++ b/drivers/clk/meson/clkc.h
> @@ -134,7 +134,7 @@ struct meson_clk_audio_divider {
>  struct clk_gate _name = {                                              \
>         .reg = (void __iomem *) _reg,                                   \
>         .bit_idx = (_bit),                                              \
> -       .lock = &clk_lock,                                              \
> +       .lock = &meson_clk_lock,                                                \

Something is not right here, line is over 80 characters
Remember to run checkpatch on your series please.

>         .hw.init = &(struct clk_init_data) {                            \
>                 .name = #_name,                                 \
>                 .ops = &clk_gate_ops,                                   \
