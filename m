From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 13:50:19 +0800
Subject: [PATCH 2/2] arm64: dts: ls2080a: fsl-mc dt node updates
In-Reply-To: <1459544080-28598-1-git-send-email-stuart.yoder@nxp.com>
References: <1459544080-28598-1-git-send-email-stuart.yoder@nxp.com>
Message-ID: <20160413055019.GK28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 03:54:40PM -0500, Stuart Yoder wrote:
> From: Stuart Yoder <stuart.yoder@nxp.com>
> 
> updates to the fsl-mc node for full functionality:
>    -msi-parent is needed for interrupt support
>    -ranges is needed to enable the bus driver to translate bus addresses
>    -dpmac nodes provide a basis for relating dpmac objects to PHYs
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi |   87 ++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index 9d746c6..449c635 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -265,6 +265,93 @@
>  			compatible = "fsl,qoriq-mc";
>  			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
>  			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
> +			msi-parent = <&its>;
> +			#address-cells = <3>;
> +			#size-cells = <1>;
> +
> +			/*
> +			 * Region type 0x0 - MC portals
> +			 * Region type 0x1 - QBMAN portals
> +			 */
> +			ranges = <0x0 0x0 0x0 0x8 0x0c000000 0x4000000
> +				  0x1 0x0 0x0 0x8 0x18000000 0x8000000>;
> +
> +			/*
> +			 * Define the maximum number of MACs present on the SoC.
> +			 * They won't necessarily be all probed, since the
> +			 * Data Path Layout file and the MC firmware can put
> +			 * fewer actual DPMAC objects on the MC bus.
> +			 */
> +			dpmacs {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				dpmac1: dpmac at 1 {
> +					compatible = "fsl,qoriq-mc-dpmac";

I did not see how this compatible is used by kernel driver.

> +					reg = <1>;
> +				};

Please have a newline between nodes.

Shawn

> +				dpmac2: dpmac at 2 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <2>;
> +				};
> +				dpmac3: dpmac at 3 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <3>;
> +				};
> +				dpmac4: dpmac at 4 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <4>;
> +				};
> +				dpmac5: dpmac at 5 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <5>;
> +				};
> +				dpmac6: dpmac at 6 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <6>;
> +				};
> +				dpmac7: dpmac at 7 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <7>;
> +				};
> +				dpmac8: dpmac at 8 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <8>;
> +				};
> +				dpmac9: dpmac at 9 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <9>;
> +				};
> +				dpmac10: dpmac at 10 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <0xa>;
> +				};
> +				dpmac11: dpmac at 11 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <0xb>;
> +				};
> +				dpmac12: dpmac at 12 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <0xc>;
> +				};
> +				dpmac13: dpmac at 13 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <0xd>;
> +				};
> +				dpmac14: dpmac at 14 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <0xe>;
> +				};
> +				dpmac15: dpmac at 15 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <0xf>;
> +				};
> +				dpmac16: dpmac at 16 {
> +					compatible = "fsl,qoriq-mc-dpmac";
> +					reg = <0x10>;
> +				};
> +			};
> +
>  		};
>  
>  		smmu: iommu at 5000000 {
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
