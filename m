From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 16:05:18 +0800
Subject: [linux-sunxi] [PATCH v2 20/20] ARM: sun5i: a10s-olinuxino: Enable
 HDMI
In-Reply-To: <c7ac6faa0568e6418291255af537c4b070bdea63.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <c7ac6faa0568e6418291255af537c4b070bdea63.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65S2pw3z8NZ+tkPkF=A=5z2toRkC+26pAs6La6CNyeXoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A10s Olinuxino has an HDMI connector. Make sure we can use it.
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 29 +++++++++++++++++-
>  1 file changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> index 894f874a5beb..1d13b6407222 100644
> --- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
> @@ -63,6 +63,17 @@
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       connector {
> +               compatible = "hdmi-connector";
> +               type = "a";

Just curious, should we take this into consideration when creating
drm_connector?

ChenYu

> +
> +               port {
> +                       hdmi_con_in: endpoint {
> +                               remote-endpoint = <&hdmi_out_con>;
> +                       };
> +               };
> +       };
> +
>         leds {
>                 compatible = "gpio-leds";
>                 pinctrl-names = "default";
> @@ -76,6 +87,10 @@
>         };
>  };
>
> +&be0 {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> @@ -91,6 +106,16 @@
>         status = "okay";
>  };
>
> +&hdmi {
> +       status = "okay";
> +};
> +
> +&hdmi_out {
> +       hdmi_out_con: endpoint {
> +               remote-endpoint = <&hdmi_con_in>;
> +       };
> +};
> +
>  &i2c0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c0_pins_a>;
> @@ -248,6 +273,10 @@
>         status = "okay";
>  };
>
> +&tcon0 {
> +       status = "okay";
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pins_a>;
> --
> git-series 0.8.11
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
