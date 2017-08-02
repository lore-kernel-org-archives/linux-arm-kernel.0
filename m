From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 2 Aug 2017 11:32:11 +0800
Subject: [linux-sunxi] [PATCH v3 09/12] ASoC: sun4i-i2s: Add regmap field
 to set format
In-Reply-To: <20170729141753.20174-10-codekipper@gmail.com>
References: <20170729141753.20174-1-codekipper@gmail.com>
 <20170729141753.20174-10-codekipper@gmail.com>
Message-ID: <CAGb2v666z_Oj2mmDGRMYHvRwkEBr5sctWrFvSydBDyeZPp60iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 29, 2017 at 10:17 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the newer SoCs the bits to configure the operational mode are

The subject says "format". Which is it? And please be clear what
"mode" or "format" this configures. Is it the DAI controller's
overall mode (PCM/I2S/Left-Justified/Right-Justified/TDM)? or the
PCM mode (linear/u-law/a-law)?

> located in a different register. Add a regmap field so that this
> location can be configured.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 6d8d2c4a675b..9e060d1b73d5 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -106,6 +106,7 @@
>   * @field_fmt_set_sr: regmap field to set sample resolution.
>   * @field_fmt_set_bclk_polarity: regmap field to set clk polarity.
>   * @field_fmt_set_lrclk_polarity: regmap field to set frame polarity.
> + * @field_fmt_set_mode: regmap field to set the operational mode.

Drop the "_set_" part.

ChenYu
