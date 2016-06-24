From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 24 Jun 2016 17:14:03 +0800
Subject: [PATCH 10/14] ARM: dts: sun8i: Add sy8106a regulator to Orange Pi
 PC
In-Reply-To: <20160623192104.18720-11-megous@megous.com>
References: <20160623192104.18720-1-megous@megous.com>
 <20160623192104.18720-11-megous@megous.com>
Message-ID: <CAGb2v67UH8d5CiH9OkeJmVjXhPEhXursppEgh65QRuTpXC0ZPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2016 at 3:21 AM,  <megous@megous.com> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> Add sy8106a regulator to r_twi bus on Orange Pi PC. This
> regulator controls the CPUX voltage.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> index e5991da..7e04017 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
> @@ -92,6 +92,16 @@
>
>  &r_twi {
>         status = "okay";
> +
> +       vdd_cpu: regulator at 65 {
> +               compatible = "sy8106a";
> +               reg = <0x65>;
> +               regulator-min-microvolt = <1000000>;
> +               regulator-max-microvolt = <1400000>;
> +               regulator-ramp-delay = <200>;
> +               regulator-boot-on;
> +               regulator-always-on;
> +       };

This should be merged with the previous "enable r_twi" patch.

ChenYu

>  };
>
>  &ehci1 {
> --
> 2.9.0
>
