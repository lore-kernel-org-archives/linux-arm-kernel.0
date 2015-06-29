From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 29 Jun 2015 14:46:58 +0200
Subject: [PATCH 1/3] ARM: mvebu: fix description of pwr-sata0 regulator
 on Armada 388 GP
In-Reply-To: <1434631121-32014-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434631121-32014-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1434631121-32014-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <55913E42.3070102@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 18/06/2015 14:38, Thomas Petazzoni wrote:
> This regulator was lacking the reference to the GPIO that controls it,
> and the regulator-min-microvolt and regulator-max-microvolt
> properties. Thanks to this commit, the pwr-sata0 regulator now looks
> more like the other pwr-sata{1,2,3} regulators in the same Device
> Tree, with of course the exception of a different GPIO reference.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-388-gp.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
> index 78514ab..5164b9a 100644
> --- a/arch/arm/boot/dts/armada-388-gp.dts
> +++ b/arch/arm/boot/dts/armada-388-gp.dts
> @@ -301,9 +301,11 @@
>  	reg_sata0: pwr-sata0 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "pwr_en_sata0";
> +		regulator-min-microvolt = <12000000>;
> +		regulator-max-microvolt = <12000000>;
>  		enable-active-high;
>  		regulator-always-on;
> -
> +		gpio = <&expander0 2 GPIO_ACTIVE_HIGH>;
>  	};
>  
>  	reg_5v_sata0: v5-sata0 {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
