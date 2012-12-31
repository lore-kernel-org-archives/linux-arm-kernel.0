From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 31 Dec 2012 13:52:14 +0100
Subject: [PATCH] ARM: dts: omap3-igep: Add fixed always-on regulators to
 common dtsi file
In-Reply-To: <1356815084-6943-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1356815084-6943-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CABxcv=mpL6=6AvZCwQfcH+sFQXTLEc7mcsXEK_3e8KqDeNhvHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 29, 2012 at 10:04 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> These regulators are common to igep0020 and igep0030 boards
> and are needed by smsc911x controller.
>
> Cc: Beno?t Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Enric Balletbo i Serra <eballetbo@gmail.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/omap3-igep.dtsi |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-igep.dtsi b/arch/arm/boot/dts/omap3-igep.dtsi
> index dd01c46..91a42ce 100644
> --- a/arch/arm/boot/dts/omap3-igep.dtsi
> +++ b/arch/arm/boot/dts/omap3-igep.dtsi
> @@ -24,6 +24,18 @@
>                 ti,mcbsp = <&mcbsp2>;
>                 ti,codec = <&twl_audio>;
>         };
> +
> +        vddvario: regulator-vddvario {
> +                compatible = "regulator-fixed";
> +                regulator-name = "vddvario";
> +                regulator-always-on;
> +        };
> +
> +        vdd33a: regulator-vdd33a {
> +                compatible = "regulator-fixed";
> +                regulator-name = "vdd33a";
> +                regulator-always-on;
> +        };
>  };
>
>  &omap3_pmx_core {

Hi Ezequiel,

This shouldn't be defined on the generic omap3-igep.dtsi but on
omap3-igep0020.dts since the IGEP COM Module doesn't have the LAN
SMSC9221 chip which is the one using these regulators.

Otherwise, the patch looks good to me and I think it has to be part of
the series that add SMSC9221 support for IGEPv2.

Thanks a lot and best regards,
Javier
