From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Nov 2016 22:11:45 +0800
Subject: [PATCH 3/3] ARM: gr8: evb: Add i2s codec
In-Reply-To: <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
References: <cover.9296840e0b7438e0ae63b4ec0d64957640b64a78.1478524066.git-series.maxime.ripard@free-electrons.com>
 <4d99da31af41b26d9109113e19223ee8b88f76ae.1478524066.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65bzWJpEnmwk89Qkn+_QawcPtpCJdA+90Dgc68FLRNQqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2016 at 9:08 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The GR8-EVB comes with a wm8978 codec connected to the i2s bus.
>
> Add a card in order to have it working
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/ntc-gr8-evb.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/ntc-gr8-evb.dts b/arch/arm/boot/dts/ntc-gr8-evb.dts
> index 12b4317a4383..5291e425caf9 100644
> --- a/arch/arm/boot/dts/ntc-gr8-evb.dts
> +++ b/arch/arm/boot/dts/ntc-gr8-evb.dts
> @@ -76,6 +76,20 @@
>                 default-brightness-level = <8>;
>         };
>
> +       i2s {

"sound" might be a better node name? The I2S controllers are also named "i2s".

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>

> +               compatible = "simple-audio-card";
> +               simple-audio-card,name = "gr8-evb-wm8978";
> +               simple-audio-card,format = "i2s";
> +               simple-audio-card,mclk-fs = <512>;
> +
> +               simple-audio-card,cpu {
> +                       sound-dai = <&i2s0>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai = <&wm8978>;
> +               };
> +       };
>
>         panel {
>                 compatible = "allwinner,sun4i-a10-sub-evb-5-lcd";
> --
> git-series 0.8.11
