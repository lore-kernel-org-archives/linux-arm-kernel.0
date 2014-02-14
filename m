From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 14 Feb 2014 15:54:40 +0200
Subject: [PATCH 7/8] ARM: dts: set 'ti,set-rate-parent' for dpll4_m4 path
In-Reply-To: <1392285846-13199-8-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
 <1392285846-13199-8-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <52FE2020.2010601@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/13/2014 12:04 PM, Tomi Valkeinen wrote:
> Set 'ti,set-rate-parent' property for clocks in the dpll4_m4 clock
> path, which is used for DSS functional clock. This fixes DSS driver's
> clock rate configuration, which needs the rate to be propagated properly
> to the divider node (dpll4_m4_ck).


... squash to #6?

-Tero

>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm/boot/dts/omap3xxx-clocks.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3xxx-clocks.dtsi b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> index df3c699a1893..12be2b35dae9 100644
> --- a/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> +++ b/arch/arm/boot/dts/omap3xxx-clocks.dtsi
> @@ -429,6 +429,7 @@
>   		clocks = <&dpll4_m4_ck>;
>   		ti,clock-mult = <2>;
>   		ti,clock-div = <1>;
> +		ti,set-rate-parent;
>   	};
>
>   	dpll4_m4x2_ck: dpll4_m4x2_ck {
> @@ -438,6 +439,7 @@
>   		ti,bit-shift = <0x1d>;
>   		reg = <0x0d00>;
>   		ti,set-bit-to-disable;
> +		ti,set-rate-parent;
>   	};
>
>   	dpll4_m5_ck: dpll4_m5_ck {
>
