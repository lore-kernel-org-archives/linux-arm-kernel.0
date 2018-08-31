From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 31 Aug 2018 09:37:24 +0200
Subject: [PATCH v4 12/13] ARM: dts: sun4i: a10: add sata-port/sata-phy
 nodes
In-Reply-To: <20180830190120.722-13-clabbe.montjoie@gmail.com>
References: <20180830190120.722-1-clabbe.montjoie@gmail.com>
 <20180830190120.722-13-clabbe.montjoie@gmail.com>
Message-ID: <20180831073724.kuw5tb6yypb4pmkp@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 09:01:19PM +0200, Corentin Labbe wrote:
> This patch convert sun4i-a10 sata to the new binding which use a sata
> phy node.
> 
> Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 3d62a8950720..52d5c2e79499 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -556,7 +556,20 @@
>  			reg = <0x01c18000 0x1000>;
>  			interrupts = <56>;
>  			clocks = <&ccu CLK_AHB_SATA>, <&ccu CLK_SATA>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
>  			status = "disabled";
> +
> +			sata_port: sata-port at 0 {
> +				reg = <0>;
> +				phys = <&sata_phy>;
> +			};
> +		};
> +
> +		sata_phy: sata_phy at 1c180c0 {
> +			compatible = "allwinner,sun4i-a10-sata-phy";
> +			reg = <0x01c180c0 0x200>;
> +			#phy-cells = <0>;
>  		};

This patch, together with the following one, breaks the DT ABI, this
isn't something we can do anymore.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180831/82065222/attachment.sig>
