From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 12 Oct 2017 15:56:20 +0200
Subject: [PATCH] arm64: dts: marvell: 7040-db: Add the carrier detect pin
 for SD card on CP
In-Reply-To: <20171005160549.23741-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Thu, 5 Oct 2017 18:05:49 +0200")
References: <20171005160549.23741-1-gregory.clement@free-electrons.com>
Message-ID: <878tggbhbv.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
 
 On jeu., oct. 05 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> The SD card slot connected to the SD controller of the CP part has a
> carrier detect pin connected the gpio expander. This patch enables it
> allowing supporting the hotplug event for the SD card.


Applied on mvebu/dt64

Gregory


>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm64/boot/dts/marvell/armada-7040-db.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> index 18a75fad1e8d..d339ad5c8c27 100644
> --- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
> @@ -239,7 +239,7 @@
>  	status = "okay";
>  	bus-width = <4>;
>  	no-1-8-v;
> -	non-removable;
> +	cd-gpios = <&expander0 12 GPIO_ACTIVE_LOW>;
>  };
>  
>  &cpm_mdio {
> -- 
> 2.14.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
