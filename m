From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 9 Jun 2017 15:48:59 +0800
Subject: [PATCH v11 07/12] sun4i-codec: Add extra controls to
 sun4i_codec_quirks, sun7i_codec_quirks.
In-Reply-To: <20170609062216.26807-8-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
 <20170609062216.26807-8-dannym@scratchpost.org>
Message-ID: <CAGb2v654SNZcGVx9SXVvLfpz2kHchftyeL2sGOgnvj2T9G7KBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 2:22 PM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
> ---
>  sound/soc/sunxi/sun4i-codec.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
> index b1da14d1..d453af65 100644
> --- a/sound/soc/sunxi/sun4i-codec.c
> +++ b/sound/soc/sunxi/sun4i-codec.c
> @@ -1576,6 +1576,8 @@ static const struct sun4i_codec_quirks sun4i_codec_quirks = {
>         .reg_adc_fifoc  = REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
>         .reg_dac_txdata = SUN4I_CODEC_DAC_TXDATA,
>         .reg_adc_rxdata = SUN4I_CODEC_ADC_RXDATA,
> +       .controls = sun4i_codec_extra_controls,
> +       .num_controls = ARRAY_SIZE(sun4i_codec_extra_controls),

Where did these come from?

>  };
>
>  static const struct sun4i_codec_quirks sun6i_a31_codec_quirks = {
> @@ -1595,6 +1597,8 @@ static const struct sun4i_codec_quirks sun7i_codec_quirks = {
>         .reg_adc_fifoc  = REG_FIELD(SUN4I_CODEC_ADC_FIFOC, 0, 31),
>         .reg_dac_txdata = SUN4I_CODEC_DAC_TXDATA,
>         .reg_adc_rxdata = SUN4I_CODEC_ADC_RXDATA,
> +       .controls = sun7i_codec_extra_controls,
> +       .num_controls = ARRAY_SIZE(sun7i_codec_extra_controls),
>  };
>
>  static const struct sun4i_codec_quirks sun8i_a23_codec_quirks = {
