From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 11:09:25 +0800
Subject: [linux-sunxi] [PATCH v3 07/12] ASoC: sun4i-i2s: bclk and lrclk
 polarity tidyup
In-Reply-To: <20170729141753.20174-8-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-8-codekipper@gmail.com>
Message-ID: <CAGb2v64LyQ+Ba9YWvQzpE0B9MFqsotNpEXkQ5RVhAo2z5QpvGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On newer SoCs the bit fields for the blck and lrclk polarity are in
> a different locations. Use regmap fields to set the polarity bits
> as intended.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 171df99a267e..90daa974bd27 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -50,6 +50,8 @@
>  #define SUN4I_I2S_FMT0_FMT_RIGHT_J                     (2 << 0)
>  #define SUN4I_I2S_FMT0_FMT_LEFT_J                      (1 << 0)
>  #define SUN4I_I2S_FMT0_FMT_I2S                         (0 << 0)
> +#define SUN4I_I2S_FMT0_POLARITY_INVERTED               (1)
> +#define SUN4I_I2S_FMT0_POLARITY_NORMAL                 (0)
>
>  #define SUN4I_I2S_FMT1_REG             0x08
>  #define SUN4I_I2S_FIFO_TX_REG          0x0c
> @@ -101,6 +103,8 @@
>   * @fmt_offset: Value by which wss and sr needs to be adjusted.
>   * @field_fmt_set_wss: regmap field to set word select size.
>   * @field_fmt_set_sr: regmap field to set sample resolution.
> + * @field_fmt_set_bclk_polarity: regmap field to set clk polarity.
> + * @field_fmt_set_lrclk_polarity: regmap field to set frame polarity.

You can cut these down to "field_fmt_{b,lr}clk_pol".
It still makes sense in this context, and you can make the lines fit
under 80 characters in the last hunk.

ChenYu
