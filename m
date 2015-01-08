From: wens213@gmail.com (wens Tsai)
Date: Thu, 8 Jan 2015 11:54:21 +0800
Subject: ARM: dts: sunxi: A20-OlinuXino-Lime2 raise dcdc2 lower voltage
 limit
In-Reply-To: <54ADB179.9000209@gmail.com>
References: <54ADB179.9000209@gmail.com>
Message-ID: <CAGb2v64xsLpQ63GuxDRj+X454f-FaHHqS+2QpEWEnvgVO2NFQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 8, 2015 at 6:21 AM, Iain Paton <ipaton0@gmail.com> wrote:
> The Lime2 is not stable if the cpu core voltage is reduced below 1v. To
> prevent any problems when operating points are enabled, raise the pmic dcdc2
> lower voltage limit to 1v.
>
> Signed-off-by: Iain Paton <ipaton0@gmail.com>
> ---
>
> Maxime, I realise the axp209 nodes will probably end up abstracted somewhat
> differently once all of the patches Chen-Yu posted are reviewed and picked
> up and I can redo the lime2 dts to fit once that's done.
> For now, the lime2 dts defines the full axp209 node itself including all of
> the regulators, so if the lowest opp with the 0.9v setting is enabled this
> will cause problems.
>
> Up to you if you want to take this patch now or we wait until the axp209.dtsi
> lands and refactor the lime2 dts appropriately then.
>
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index ed364d5..910318a 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -159,7 +159,7 @@
>                                         };
>
>                                         vdd_cpu: dcdc2 {
> -                                               regulator-min-microvolt = <700000>;
> +                                               regulator-min-microvolt = <1000000>;
>                                                 regulator-max-microvolt = <2275000>;

You should lower the maximum voltage as well, either in this patch
or when you redo all the regulators. AFAIK the SoC certainly cannot
take up to 2.275V. The regulator nodes are supposed to say what
the board can handle.

ChenYu

>                                                 regulator-always-on;
>                                         };
> --
> 2.1.3
>
