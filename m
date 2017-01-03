From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 03 Jan 2017 16:14:52 +0100
Subject: [PATCH v4 4/4] arm64: dts: marvell: Enable spi0 on the board
 Armada-3720-db
In-Reply-To: <20161208145847.7794-5-romain.perier@free-electrons.com> (Romain
 Perier's message of "Thu, 8 Dec 2016 15:58:47 +0100")
References: <20161208145847.7794-1-romain.perier@free-electrons.com>
 <20161208145847.7794-5-romain.perier@free-electrons.com>
Message-ID: <87a8b8gopf.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain,
 
 On jeu., d?c. 08 2016, Romain Perier <romain.perier@free-electrons.com> wrote:

> This commit enables the device node spi0 on the official development
> board for the Marvell Armada 3700. It also adds sub-node for the 128Mb
> SPI-NOR present on the board.
>
> Signed-off-by: Romain Perier <romain.perier@free-electrons.com>
> Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>
> Changes in v3:
>  - Added tag "Tested-by" by Gregory
>
>  arch/arm64/boot/dts/marvell/armada-3720-db.dts | 30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-db.dts b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> index 1372e9a6..0c4eb98 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> @@ -67,6 +67,36 @@
>  	status = "okay";
>  };
>  
> +&spi0 {
> +	status = "okay";
> +
> +	m25p80 at 0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <108000000>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			partition at 0 {
> +				label = "bootloader";
> +				reg = <0x0 0x200000>;
> +			};
> +			partition at 200000 {
> +				label = "U-boot Env";
> +				reg = <0x200000 0x10000>;
> +			};
> +			partition at 210000 {
> +				label = "Linux";
> +				reg = <0x210000 0xDF0000>;
> +			};
> +		};
> +	};
> +};
> +
>  /* Exported on the micro USB connector CON32 through an FTDI */
>  &uart0 {
>  	status = "okay";
> -- 
> 2.9.3
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
