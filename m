From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 06 Apr 2018 11:42:19 +0200
Subject: [PATCH] arm64: dts: armada-3720-espressobin: wire up spi flash
In-Reply-To: <20180325195736.19782-1-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Sun, 25 Mar 2018 21:57:36
 +0200")
References: <20180325195736.19782-1-u.kleine-koenig@pengutronix.de>
Message-ID: <87d0zcisck.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,
 
 On dim., mars 25 2018, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> From: Ellie Reeves <ellierevves@gmail.com>
>
> This is the storage the machine boots from by default. The partitioning
> is taken from the U-Boot that is shipped with the board. There is some
> more space on the flash that isn't used.

I tested this patch and was able to read the uboot environement from
Linux.

>
> Signed-off-by: Ellie Reeves <ellierevves@gmail.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>


Applied on mvebu/dt64-for-4.18

Thanks,

Gregory

> ---
>  .../boot/dts/marvell/armada-3720-espressobin.dts   | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> index 882d6e4a04e4..5f98c2fecca4 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> @@ -108,6 +108,33 @@
>  	status = "okay";
>  };
>  
> +&spi0 {
> +	status = "okay";
> +
> +	flash at 0 {
> +		reg = <0>;
> +		compatible = "winbond,w25q32dw", "jedec,spi-flash";
> +		spi-max-frequency = <104000000>;
> +		m25p,fast-read;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition at 0 {
> +				label = "uboot";
> +				reg = <0 0x180000>;
> +			};
> +
> +			partition at 180000 {
> +				label = "ubootenv";
> +				reg = <0x180000 0x10000>;
> +			};
> +		};
> +	};
> +};
> +
>  /* Exported on the micro USB connector J5 through an FTDI */
>  &uart0 {
>  	pinctrl-names = "default";
> -- 
> 2.16.2
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
