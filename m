From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jun 2016 11:48:23 +0800
Subject: [PATCH 06/14] ARM: dts: sun8i: Add cpu0 label to sun8i-h3.dtsi
In-Reply-To: <20160623192104.18720-7-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-7-megous@megous.com>
Message-ID: <CAGb2v66eskVAxdz8VtjBJBCO7VV9WL4bdFDVrPWrSmxk4RASCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 3:20 AM,  <megous@megous.com> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Add label to the first cpu so that it can be referenced
> from derived dts files.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index 9938972..82faefc 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -52,7 +52,7 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> -               cpu at 0 {
> +               cpu0: cpu at 0 {
>                         compatible = "arm,cortex-a7";
>                         device_type = "cpu";
>                         reg = <0>;

Can you also set the cpu clock here? It is part of the SoC
and does not belong in the board DTS files.

Otherwise this one looks good.

ChenYu

> --
> 2.9.0
>
