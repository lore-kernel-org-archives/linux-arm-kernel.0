From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 20 Nov 2013 14:11:36 +0800
Subject: [PATCH] ARM: cfa10036: Add dr_mode and phy_type properties to
 the DT
In-Reply-To: <1384786322-17168-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1384786322-17168-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20131120061135.GB19680@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 03:52:02PM +0100, Maxime Ripard wrote:
> This USB port is only used as peripheral. Set it accordingly in its DT
> node.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Changed the patch prefix to "ARM: dts: cfa10036: ..." 

> ---
>  arch/arm/boot/dts/imx28-cfa10036.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx28-cfa10036.dts b/arch/arm/boot/dts/imx28-cfa10036.dts
> index 1ec8c94bbac9..94e73e2cd4f8 100644
> --- a/arch/arm/boot/dts/imx28-cfa10036.dts
> +++ b/arch/arm/boot/dts/imx28-cfa10036.dts
> @@ -101,6 +101,8 @@
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&usb0_otg_cfa10036>;
>  			status = "okay";
> +			dr_mode = "peripheral";
> +			phy_type = "utmi";

I prefer to keep 'status' being the last one in the property list.
Fixed it up.

Patch applied, thanks.

Shawn

>  		};
>  	};
>  
> -- 
> 1.8.4.2
> 
