From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 18 Nov 2016 11:55:59 +0100
Subject: [RFC 5/6] ARM: dts: dra7: add vivante for bb2d module
In-Reply-To: <20161118024436.13447-5-robertcnelson@gmail.com>
References: <20161118024436.13447-1-robertcnelson@gmail.com>
 <20161118024436.13447-5-robertcnelson@gmail.com>
Message-ID: <1479466559.20533.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, den 17.11.2016, 20:44 -0600 schrieb Robert Nelson:
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Julien <jboulnois@gmail.com>
> CC: Nishanth Menon <nm@ti.com>
> CC: Tomi Valkeinen <tomi.valkeinen@ti.com>
> CC: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 43488b6..22bd0a5 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -960,7 +960,7 @@
>  		};
>  
>  		bb2d: bb2d at 59000000 {
> -			compatible = "ti,dra7-bb2d";
> +			compatible = "ti,dra7-bb2d","vivante,gc";

This is what the driver expects as a compatible, but it's not consistent
with the DT documentation patch you sent. As the driver can work out the
HW version from the identification registers I would say fix your DT
binding to only require "vivante,gc"

Regards,
Lucas
