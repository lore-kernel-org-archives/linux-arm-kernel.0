From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Jun 2016 09:37:30 +0800
Subject: [PATCH v2 01/15] dt-bindings: sunxi: Add CCU binding documentation
In-Reply-To: <20160607204154.31967-2-maxime.ripard@free-electrons.com>
References: <20160607204154.31967-1-maxime.ripard@free-electrons.com>
 <20160607204154.31967-2-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v661ERE7zi9uExMtiEgG68owxT6x4jX3nCsVH8BwohJ53A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 8, 2016 at 4:41 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Introduce a new binding with its documentation for the brand new clock
> sub-framework.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunxi-ccu.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> new file mode 100644
> index 000000000000..2c66046a1342
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -0,0 +1,17 @@
> +Allwinner Clock Control Unit Binding
> +------------------------------------
> +
> +Required properties :
> +- compatible: must contain one of the following compatible:
> +               - "allwinner,sun8i-h3-ccu"
> +
> +- reg: Must contain the registers base address and length
> +- clocks: phandle to the oscillators feeding the SPI controller. Two are

SPI? copy paste error?

> +          needed:
> +  - "hosc": the high frequency oscillator (usually at 24MHz)
> +  - "losc": the low frequency oscillator (usually at 32kHz)
> +- clock-names: Must contain the clock names described just above
> +- #clock-cells : must contain 1
> +- #reset-cells : must contain 1
> +
> +Example:

No example? Maybe just remove this section then.

ChenYu

> --
> 2.8.3
>
