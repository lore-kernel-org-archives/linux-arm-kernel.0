From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 21 Sep 2017 09:52:39 +0200
Subject: [PATCH] arm64: dts: marvell: Enable Armada-8040-DB CPS SPI1
In-Reply-To: <20170921073643.5677-1-miquel.raynal@free-electrons.com>
References: <20170921073643.5677-1-miquel.raynal@free-electrons.com>
Message-ID: <20170921075239.GE3568@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,

On Thu, Sep 21, 2017 at 09:36:43AM +0200, Miquel Raynal wrote:
> From: Christine Gharzuzi <chrisg@marvell.com>
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
> +			partition at d00000 {

The node should be 'partition at f00000'.

> +				label = "Boot_2nd";
> +				reg = <0xf00000 0x100000>;
> +			};
> +		};
> +	};
> +};

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170921/34acc3e4/attachment.sig>
