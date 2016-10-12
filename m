From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 12 Oct 2016 10:55:59 +0200
Subject: [PATCH v4 08/10] ARM: dts: sun8i: Enable sun8i-emac on the
 Orange Pi 2
In-Reply-To: <1475828757-926-9-git-send-email-clabbe.montjoie@gmail.com>
References: <1475828757-926-1-git-send-email-clabbe.montjoie@gmail.com>
 <1475828757-926-9-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20161012105559.aaf9122e376fa5969a2e61d9@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  7 Oct 2016 10:25:55 +0200
Corentin Labbe <clabbe.montjoie@gmail.com> wrote:

> The sun8i-emac hardware is present on the Orange PI 2.
> It uses the internal PHY.
> 
> This patch create the needed emac node.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> index f93f5d1..5608eb4 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
> @@ -54,6 +54,7 @@
>  
>  	aliases {
>  		serial0 = &uart0;
> +		ethernet0 = &emac;

As there is no 'of_alias_get_id' in the driver, this alias is useless.

>  	};
>  
>  	chosen {
> @@ -184,3 +185,10 @@
>  	usb1_vbus-supply = <&reg_usb1_vbus>;
>  	status = "okay";
>  };
> +
> +&emac {
> +	phy-handle = <&int_mii_phy>;
> +	phy-mode = "mii";
> +	allwinner,leds-active-low;
> +	status = "okay";
> +};
> -- 
> 2.7.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
