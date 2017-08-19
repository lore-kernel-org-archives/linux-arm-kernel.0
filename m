From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 23:11:20 +0800
Subject: [linux-sunxi] [PATCH v5 1/8] ASoC: sun4i-i2s: Add regmap fields
 for channels
In-Reply-To: <20170819124839.4034-2-codekipper@gmail.com>
References: <20170819124839.4034-1-codekipper@gmail.com>
 <20170819124839.4034-2-codekipper@gmail.com>
Message-ID: <CAGb2v67jSkBZtB7y6nCG+Bhkcc-qzr5yz=7_CTeiB0Z3CRtVHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 19, 2017 at 8:48 PM,  <codekipper@gmail.com> wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> On the original i2s block the channel mapping and selection were
> configured for stereo audio by default: This is not the case with
> the newer SoCs and they are also located at different offsets.
>
> To support the newer SoC then regmap fields have been added to the
> quirks and these are initialised to their correct settings during
> probing.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by still stands.

> ---
>  sound/soc/sunxi/sun4i-i2s.c | 77 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 69 insertions(+), 8 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c

[...]

> +static int sun4i_i2s_init_regmap_fields(struct device *dev,
> +                                       struct sun4i_i2s *i2s)
> +{
> +       i2s->field_txchanmap =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_txchanmap);
> +       if (IS_ERR(i2s->field_txchanmap))
> +               return PTR_ERR(i2s->field_txchanmap);
> +
> +       i2s->field_rxchanmap =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_rxchanmap);
> +       if (IS_ERR(i2s->field_rxchanmap))
> +               return PTR_ERR(i2s->field_rxchanmap);
> +
> +       i2s->field_txchansel =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_txchansel);
> +       if (IS_ERR(i2s->field_txchansel))
> +               return PTR_ERR(i2s->field_txchansel);
> +
> +       i2s->field_rxchansel =
> +                       devm_regmap_field_alloc(dev, i2s->regmap,
> +                                               i2s->variant->field_rxchansel);
> +       return PTR_ERR_OR_ZERO(i2s->field_rxchansel);
> +}
> +

That's much better. Thanks!

ChenYu
