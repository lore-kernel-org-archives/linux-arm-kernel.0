From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 Jul 2015 05:24:42 -0700
Subject: [PATCH] ARM: dts: am4372.dtsi: disable rfbi
In-Reply-To: <1435665894-28491-1-git-send-email-tomi.valkeinen@ti.com>
References: <1435665894-28491-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <20150706122442.GF10705@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [150630 05:07]:
> When DSS nodes were added to am4372.dtsi, the rfbi node was not marked
> as disabled. This should have been done, as the rule of thumb is to
> disable all DSS nodes that are not used, and especially rfbi, as we
> don't have a driver for rfbi.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Applying into omap-for-v4.2/fixes thanks.

Tony

> ---
>  arch/arm/boot/dts/am4372.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index c80a3e233792..75831e556741 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -941,6 +941,7 @@
>  				ti,hwmods = "dss_rfbi";
>  				clocks = <&disp_clk>;
>  				clock-names = "fck";
> +				status = "disabled";
>  			};
>  		};
>  
> -- 
> 2.1.4
> 
