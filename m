From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:50:31 +0800
Subject: [PATCH 31/77] ARM: dts: sun6i: Change pinctrl nodes to avoid
 warning
In-Reply-To: <288a28fa42f816b4f255a316569e7f750c3e73ac.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <288a28fa42f816b4f255a316569e7f750c3e73ac.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v65taoS1H9PmJBtUvkq13Rdn4WdZr7+pTGNM-UDfgg8DWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> All our pinctrl nodes were using a node name convention with a unit-address
> to differentiate the different muxing options. However, since those nodes
> didn't have a reg property, they were generating warnings in DTC.
>
> In order to accomodate for this, convert the old nodes to the syntax we've
> been using for the new SoCs, including removing the letter suffix of the
> node labels to the bank of those pins to make things more readable.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

[...]

> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index c5fd97b88b90..596ab854da2c 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi

[...]

> @@ -712,12 +712,12 @@
>                                 bias-pull-up;
>                         };
>
> -                       spdif_pins_a: spdif at 0 {
> +                       spdif_tx_pin: spdif-pin {

Node name should be spdif-tx-pin, since this SoC also has
SPDIF input.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
