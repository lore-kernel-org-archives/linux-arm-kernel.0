From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 25 Sep 2017 18:04:08 +0200
Subject: [PATCH RESEND v2] arm64: dts: marvell: Enable Armada-8040-DB CPS
 SPI1
In-Reply-To: <20170922130834.7096-1-miquel.raynal@free-electrons.com> (Miquel
 Raynal's message of "Fri, 22 Sep 2017 15:08:34 +0200")
References: <20170922130834.7096-1-miquel.raynal@free-electrons.com>
Message-ID: <87vak6ix3b.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On ven., sept. 22 2017, Miquel Raynal <miquel.raynal@free-electrons.com> wrote:

> From: Christine Gharzuzi <chrisg@marvell.com>
>
> Add the DT node enabling Armada-8040-DB CPS SPI controller driver.
>
> Add the SPI NAND flash device connected on the bus. Fill the MTD
> partitions layout.
>
> Signed-off-by: Christine Gharzuzi <chrisg@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>
> Hello,
>
> Made a mistake resending the v1 prefixed by v2.
> This is the real v2.
>
> It fixes the third partition address from 0xd00000 to 0xf00000.
>
> Thanks,
> Miqu?l
>
>  arch/arm64/boot/dts/marvell/armada-8040-db.dts | 31 ++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> index 0d7b2ae46610..85c72f835184 100644
> --- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
> @@ -216,6 +216,37 @@
>  	clock-frequency = <100000>;
>  };
>  
> +&cps_spi1 {
> +	status = "okay";
> +
> +	spi-flash at 0 {
> +		#address-cells = <0x1>;
> +		#size-cells = <0x1>;
> +		compatible = "jedec,spi-nor";
> +		reg = <0x0>;
> +		spi-max-frequency = <20000000>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition at 0 {
> +				label = "Boot";
> +				reg = <0x0 0x200000>;
> +			};
> +			partition at 200000 {
> +				label = "Filesystem";
> +				reg = <0x200000 0xd00000>;
> +			};
> +			partition at f00000 {
> +				label = "Boot_2nd";
> +				reg = <0xf00000 0x100000>;
> +			};
> +		};
> +	};
> +};
> +
>  /* CON4 on CP1 expansion */
>  &cps_sata0 {
>  	status = "okay";
> -- 
> 2.11.0
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
