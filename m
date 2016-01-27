From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 27 Jan 2016 18:16:48 +0100
Subject: [PATCH v2 2/2] ARM: mvebu: add NAND description to Armada 370 DB
 and Armada XP DB
In-Reply-To: <1453908287-29557-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1453908287-29557-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1453908287-29557-3-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20160127171648.GG20194@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 04:24:47PM +0100, Thomas Petazzoni wrote:
> This commit adds the Device Tree description for the 1GB NAND flash
> present in the Armada 370 DB and Armada XP DB evaluation boards from
> Marvell.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-db.dts | 21 +++++++++++++++++++++
>  arch/arm/boot/dts/armada-xp-db.dts  | 21 +++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
> index bb280de..e7763b6 100644
> --- a/arch/arm/boot/dts/armada-370-db.dts
> +++ b/arch/arm/boot/dts/armada-370-db.dts
> @@ -168,6 +168,27 @@
>  					spi-max-frequency = <50000000>;
>  				};
>  			};
> +
> +			nand at d0000 {
> +				status = "okay";
> +				num-cs = <1>;
> +				marvell,nand-keep-config;
> +				marvell,nand-enable-arbiter;
> +				nand-on-flash-bbt;
> +
> +				partition at 0 {
> +					label = "U-Boot";
> +					reg = <0 0x800000>;
> +				};

Hi Thomas

Documentation/devicetree/bindings/mtd/partition.txt:

The partition table should be a subnode of the mtd node and should be named
'partitions'. This node should have the following property:
- compatible : (required) must be "fixed-partitions"
Partitions are then defined in subnodes of the partitions node.

For backwards compatibility partitions as direct subnodes of the mtd device are
supported. This use is discouraged.

We should try to get this right when adding new DT nodes.

   Andrew
