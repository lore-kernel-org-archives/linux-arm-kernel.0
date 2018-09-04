From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 4 Sep 2018 16:59:02 +0800
Subject: [PATCH 07/27] dt-bindings: clock: sun8i-de2: Add H6 DE3 clock
 description
In-Reply-To: <20180902072643.4917-8-jernej.skrabec@siol.net>
References: <20180902072643.4917-1-jernej.skrabec@siol.net>
 <20180902072643.4917-8-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65AsKzEH3AgmQi+RRvVa6AO-cpAckGnNkvWwONsCCsoxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> This commit adds necessary description and dt includes for H6 DE3 clock.
> It is very similar to others, but memory region has some additional
> registers not found in DE2.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/clock/sun8i-de2.txt | 5 +++--
>  include/dt-bindings/clock/sun8i-de2.h                 | 3 +++
>  include/dt-bindings/reset/sun8i-de2.h                 | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/sun8i-de2.txt b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> index e94582e8b8a9..41a52c2acffd 100644
> --- a/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> +++ b/Documentation/devicetree/bindings/clock/sun8i-de2.txt
> @@ -1,5 +1,5 @@
> -Allwinner Display Engine 2.0 Clock Control Binding
> ---------------------------------------------------
> +Allwinner Display Engine 2.0/3.0 Clock Control Binding
> +------------------------------------------------------
>
>  Required properties :
>  - compatible: must contain one of the following compatibles:
> @@ -8,6 +8,7 @@ Required properties :
>                 - "allwinner,sun8i-v3s-de2-clk"
>                 - "allwinner,sun50i-a64-de2-clk"
>                 - "allwinner,sun50i-h5-de2-clk"
> +               - "allwinner,sun50i-h6-de3-clk"
>
>  - reg: Must contain the registers base address and length
>  - clocks: phandle to the clocks feeding the display engine subsystem.
> diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
> index 3bed63b524aa..7768f73b051e 100644
> --- a/include/dt-bindings/clock/sun8i-de2.h
> +++ b/include/dt-bindings/clock/sun8i-de2.h
> @@ -15,4 +15,7 @@
>  #define CLK_MIXER1             7
>  #define CLK_WB                 8
>
> +#define CLK_BUS_ROT            9
> +#define CLK_ROT                        10
> +
>  #endif /* _DT_BINDINGS_CLOCK_SUN8I_DE2_H_ */
> diff --git a/include/dt-bindings/reset/sun8i-de2.h b/include/dt-bindings/reset/sun8i-de2.h
> index 9526017432f0..1c36a6ac86d6 100644
> --- a/include/dt-bindings/reset/sun8i-de2.h
> +++ b/include/dt-bindings/reset/sun8i-de2.h
> @@ -10,5 +10,6 @@
>  #define RST_MIXER0     0
>  #define RST_MIXER1     1
>  #define RST_WB         2
> +#define RST_ROT                3

Looking at the DE 2.0 register guide, the "Rotate" related fields are also
found on the A83T. So this is not DE 3.0 specific. And you could also have
the H6 DE3 compatible fall back to the A83T for the common parts.

ChenYu

>
>  #endif /* _DT_BINDINGS_RESET_SUN8I_DE2_H_ */
> --
> 2.18.0
>
