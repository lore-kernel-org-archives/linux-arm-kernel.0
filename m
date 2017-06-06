From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Jun 2017 10:57:30 +0800
Subject: [PATCH 4/5] ARM: sun8i: a83t: Add dt node for the syscon control
 module
In-Reply-To: <20170605192130.25320-5-clabbe.montjoie@gmail.com>
References: <20170605192130.25320-1-clabbe.montjoie@gmail.com>
 <20170605192130.25320-5-clabbe.montjoie@gmail.com>
Message-ID: <CAGb2v64Z0oQazFZ27sFtgp_YtEnj01bTfj5yLZHai3fhHQ-49w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 3:21 AM, Corentin Labbe
<clabbe.montjoie@gmail.com> wrote:
> This patch add the dt node for the syscon register present on the
> Allwinner A83T
>
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 1dc4cfe81534..ae559dc42caa 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -163,6 +163,12 @@
>                 #size-cells = <1>;
>                 ranges;
>
> +               syscon: syscon at 1c00000 {
> +                       compatible = "syscon",
> +                               "allwinner,sun8i-a83t-system-controller";

syscon is the most generic compatible string here.
It should be the last one in the list.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> +                       reg = <0x01c00000 0x1000>;
> +               };
> +
>                 dma: dma-controller at 1c02000 {
>                         compatible = "allwinner,sun8i-a83t-dma";
>                         reg = <0x01c02000 0x1000>;
> --
> 2.13.0
>
