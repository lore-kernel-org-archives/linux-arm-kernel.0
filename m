From: mylene.josserand@free-electrons.com (Mylene Josserand)
Date: Wed, 8 Feb 2017 11:10:47 +0100
Subject: [PATCH v4 1/8] ASoC: sun4i-i2s: Update binding documentation to
 include A31
In-Reply-To: <20170202092422.5588-2-mylene.josserand@free-electrons.com>
References: <20170202092422.5588-1-mylene.josserand@free-electrons.com>
 <20170202092422.5588-2-mylene.josserand@free-electrons.com>
Message-ID: <39416532-9020-6e5c-e6ce-4e4264612ac1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark Brown,

Thank you to have applied my patches!

On 02/02/2017 10:24, Myl?ne Josserand wrote:
> Add a new compatible for sun4i-i2s driver to handle some
> SoCs that have a reset line that must be asserted/deasserted.
>
> This new compatible, "allwinner,sun6i-a31-i2s", requires the
> property "resets" which should be a phandle to the reset line.
> Except these differences, the compatible is identical to previous one
> which will not handle a reset line.
>
> Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/sound/sun4i-i2s.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> index 7b526ec64991..f4adc58f82ba 100644
> --- a/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> +++ b/Documentation/devicetree/bindings/sound/sun4i-i2s.txt
> @@ -7,6 +7,7 @@ Required properties:
>
>  - compatible: should be one of the followings
>     - "allwinner,sun4i-a10-i2s"
> +   - "allwinner,sun6i-a31-i2s"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: should contain the I2S interrupt.
> @@ -19,6 +20,10 @@ Required properties:
>     - "mod" : module clock for the I2S controller
>  - #sound-dai-cells : Must be equal to 0
>
> +Required properties for the following compatibles:
> +	- "allwinner,sun6i-a31-i2s"
> +- resets: phandle to the reset line for this codec
> +
>  Example:
>
>  i2s0: i2s at 01c22400 {
>

For all my series, you did not pick-up this patch. I was wondering if 
you have any comment on it? Is there something wrong?

Thank you in advance,

Best regards,

-- 
Myl?ne Josserand, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
