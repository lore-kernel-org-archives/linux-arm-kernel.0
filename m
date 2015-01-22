From: tony@atomide.com (Tony Lindgren)
Date: Thu, 22 Jan 2015 13:37:48 -0800
Subject: [PATCH 06/13] ARM: dts: omap3-gta04: Enable power-off using
 twl4030
In-Reply-To: <1421959099-28319-7-git-send-email-marek@goldelico.com>
References: <1421959099-28319-1-git-send-email-marek@goldelico.com>
 <1421959099-28319-7-git-send-email-marek@goldelico.com>
Message-ID: <20150122213748.GX7718@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [150122 12:42]:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
> 
> Enabled poweroff through PMIC on GTA04.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 0265474..b56c85b 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -209,6 +209,11 @@
>  			codec {
>  			};
>  		};
> +
> +		twl_power: power {
> +			compatible = "ti,twl4030-power";
> +			ti,use_poweroff;
> +		};
>  	};
>  };
>  

No need to change this patch, but you may want to get things working
with ti,twl4030-power-idle-osc-off for PM if you're running it on
batteries :)

Regards,

Tony
