From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Oct 2016 16:56:39 +0200
Subject: [PATCH] ARM: dts: armada-xp-rn2120: add pinmuxing for ethernet
In-Reply-To: <20160929190010.11753-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 29 Sep 2016 21:00:10
 +0200")
References: <20160929190010.11753-1-u.kleine-koenig@pengutronix.de>
Message-ID: <87zimhv848.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On jeu., sept. 29 2016, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> Up to now working ethernet depended on the bootloader to configure the
> pinmuxing. Make it explicit.
>
> As a side effect this change makes ethernet work in barebox.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied on mvebu/dt-4.10

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/armada-xp-netgear-rn2120.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> index 3e930fdbaabc..b6bf5344fbbe 100644
> --- a/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> +++ b/arch/arm/boot/dts/armada-xp-netgear-rn2120.dts
> @@ -164,12 +164,18 @@
>  			};
>  
>  			ethernet at 70000 {
> +				pinctrl-0 = <&ge0_rgmii_pins>;
> +				pinctrl-names = "default";
> +
>  				status = "okay";
>  				phy = <&phy0>;
>  				phy-mode = "rgmii-id";
>  			};
>  
>  			ethernet at 74000 {
> +				pinctrl-0 = <&ge1_rgmii_pins>;
> +				pinctrl-names = "default";
> +
>  				status = "okay";
>  				phy = <&phy1>;
>  				phy-mode = "rgmii-id";
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
