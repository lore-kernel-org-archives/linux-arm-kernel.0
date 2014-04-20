From: julian.calaby@gmail.com (Julian Calaby)
Date: Sun, 20 Apr 2014 13:15:34 +1000
Subject: [linux-sunxi] [PATCH 2/2] ARM: sun6i: Add ARM PMU in A31 DTSI
In-Reply-To: <1397847149-26501-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1397847149-26501-1-git-send-email-maxime.ripard@free-electrons.com>
 <1397847149-26501-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGRGNgU1hyj0qJMEkQWk7diTfJXKrUHZW_LFoaDZQymbN=569Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime

On Sat, Apr 19, 2014 at 4:52 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Enable the performance monitoring unit found in the A20 SoCs.

Don't you mean A_31_?

> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun6i-a31.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
> index bc46814d2ff0..4b0f1231efc4 100644
> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
> @@ -59,6 +59,14 @@
>                 reg = <0x40000000 0x80000000>;
>         };
>
> +       pmu {
> +               compatible = "arm,cortex-a7-pmu", "arm,cortex-a15-pmu";
> +               interrupts = <0 120 4>,
> +                            <0 121 4>,
> +                            <0 122 4>,
> +                            <0 123 4>;
> +       };
> +
>         clocks {
>                 #address-cells = <1>;
>                 #size-cells = <1>;
> --
> 1.9.1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.



-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
