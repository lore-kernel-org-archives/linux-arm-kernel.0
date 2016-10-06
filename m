From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 06 Oct 2016 16:54:07 +0200
Subject: [PATCH 1/2] ARM: dts: armada-370-rn104: add pinmuxing for i2c0
In-Reply-To: <1475173326-24673-1-git-send-email-uwe@kleine-koenig.org> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 29 Sep 2016 20:22:05
 +0200")
References: <1475173326-24673-1-git-send-email-uwe@kleine-koenig.org>
Message-ID: <87d1jdwmsw.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On jeu., sept. 29 2016, Uwe Kleine-K?nig <uwe@kleine-koenig.org> wrote:

> Up to now a working i2c bus depended on the bootloader to configure the
> pinmuxing. Make it explicit.
>
> As a side effect this change makes i2c work in barebox.
>
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>

Applied on mvebu/dt-4.10

Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> index 11565752b9f6..d44a850d879c 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> @@ -128,6 +128,10 @@
>  			i2c at 11000 {
>  				compatible = "marvell,mv64xxx-i2c";
>  				clock-frequency = <100000>;
> +
> +				pinctrl-0 = <&i2c0_pins>;
> +				pinctrl-names = "default";
> +
>  				status = "okay";
>  
>  				isl12057: isl12057 at 68 {
> -- 
> 2.8.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
