From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 31 Aug 2016 12:06:50 -0300
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: add adc081c support
In-Reply-To: <1472646394-23772-1-git-send-email-wente.wang@nxp.com>
References: <1472646394-23772-1-git-send-email-wente.wang@nxp.com>
Message-ID: <CAOMZO5Ce5vOD26dgbExxq9MfMsbXoWZ271JHWy47ogLSmuy6UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Winter,

On Wed, Aug 31, 2016 at 9:26 AM, Winter Wang <wente.wang@nxp.com> wrote:
> enable ADC081C on pico-hobbit
>
> Change-Id: Ib1575b50dcf32b74abe0ab618ddc55999d19ee47

Please remove this line.

> Signed-off-by: Winter Wang <wente.wang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6ul-pico-hobbit.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> index c72ee8b..b400582 100644
> --- a/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> +++ b/arch/arm/boot/dts/imx6ul-pico-hobbit.dts
> @@ -220,6 +220,12 @@
>                         };
>                 };
>         };
> +
> +       adc: adc081c {
> +               compatible = "ti,adc081c";
> +               reg = <0x50>;
> +               vref-supply = <&reg_3p3v>;
> +       };

You missed the @50:

adc: adc081 at 50
