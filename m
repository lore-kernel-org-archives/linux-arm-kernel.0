From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 07 Dec 2016 16:30:02 +0100
Subject: [PATCH] ARM: dts: armada-{370, xp}: drop "marvell,
 orion-spi" from SPI controllers
In-Reply-To: <20161207152109.17545-1-uwe@kleine-koenig.org> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Wed, 7 Dec 2016 16:21:09
 +0100")
References: <20161207152109.17545-1-uwe@kleine-koenig.org>
Message-ID: <87eg1jhi4l.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On mer., d?c. 07 2016, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:

> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> The SPI controllers on Armada 370 and XP differ from the original Orion
> SPI controllers (at least) in the configuration of the baud rate. So
> it's wrong to claim compatibility which results in bogus baud rates.

Until two years ago with the commits
df59fa7f4bca9658b75f0f5fee225b3a057475c5 and
4dacccfac69494ba70248b134352f299171c41b7
we used "marvell,orion-spi" compatible on Armada XP and Armada 370
without any problem.

The new compatible "marvell,armada-xp-spi" and "marvell,armada-xp-spi"
allows to have more choice for the baudrate for a given clock but it is
not true that Armada 370 and Armada XP are not compatible with
"marvell,orion-spi".

Gregory

>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/armada-370.dtsi | 4 ++--
>  arch/arm/boot/dts/armada-xp.dtsi  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index b4258105e91f..b9377c11b379 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -435,13 +435,13 @@
>   * board level if a different configuration is used.
>   */
>  &spi0 {
> -	compatible = "marvell,armada-370-spi", "marvell,orion-spi";
> +	compatible = "marvell,armada-370-spi";
>  	pinctrl-0 = <&spi0_pins1>;
>  	pinctrl-names = "default";
>  };
>  
>  &spi1 {
> -	compatible = "marvell,armada-370-spi", "marvell,orion-spi";
> +	compatible = "marvell,armada-370-spi";
>  	pinctrl-0 = <&spi1_pins>;
>  	pinctrl-names = "default";
>  };
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 4a5f99e65b51..3a416834d80b 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -367,13 +367,13 @@
>  };
>  
>  &spi0 {
> -	compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
> +	compatible = "marvell,armada-xp-spi";
>  	pinctrl-0 = <&spi0_pins>;
>  	pinctrl-names = "default";
>  };
>  
>  &spi1 {
> -	compatible = "marvell,armada-xp-spi", "marvell,orion-spi";
> +	compatible = "marvell,armada-xp-spi";
>  	pinctrl-0 = <&spi1_pins>;
>  	pinctrl-names = "default";
>  };
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
