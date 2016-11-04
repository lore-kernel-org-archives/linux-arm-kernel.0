From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 04 Nov 2016 13:33:17 +0100
Subject: [PATCH] ARM: dts: armada-370-rn102: add pinmuxing for i2c0
In-Reply-To: <20161020191942.30616-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 20 Oct 2016 21:19:42
 +0200")
References: <20161020191942.30616-1-u.kleine-koenig@pengutronix.de>
Message-ID: <878tszo25u.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On jeu., oct. 20 2016, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> Up to now a working i2c bus depended on the bootloader to configure the
> pinmuxing. Make it explicit.
>
> As a side effect this change makes i2c work in barebox.
>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>


Applied on mvebu/dt

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index 3ca6330a1752..a9e3810aea65 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -121,6 +121,10 @@
>  
>  			i2c at 11000 {
>  				clock-frequency = <100000>;
> +
> +				pinctrl-0 = <&i2c0_pins>;
> +				pinctrl-names = "default";
> +
>  				status = "okay";
>  
>  				isl12057: isl12057 at 68 {
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
