From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Nov 2016 15:43:52 +0800
Subject: [PATCH V2 2/2] ARM: dts: add new compatible stream for i.MX6QP
 mmdc
In-Reply-To: <1478109604-18323-2-git-send-email-Frank.Li@nxp.com>
References: <1478109604-18323-1-git-send-email-Frank.Li@nxp.com>
 <1478109604-18323-2-git-send-email-Frank.Li@nxp.com>
Message-ID: <20161105074350.GD5597@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2016 at 01:00:04PM -0500, Frank Li wrote:
> mmdc of i.MX6QP are little difference with i.MX6Q.
> added new compatible stream fsl,imx6qp-mmdc

s/stream/string

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> No change for this patch.
> suspend resume code need fsl,imx6q-mmdc

You should probably add such info into commit log, e.g. although
MMDC has a slightly different programming model between imx6q and imx6qp
in terms of perf support, it's exactly same for suspend support, so we
have fsl,imx6q-mmdc here to save patching suspend driver with the new
compatible.

> 
>  arch/arm/boot/dts/imx6qp.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
> index 886dbf2..e0fdd0f 100644
> --- a/arch/arm/boot/dts/imx6qp.dtsi
> +++ b/arch/arm/boot/dts/imx6qp.dtsi
> @@ -85,5 +85,12 @@
>  		pcie: pcie at 0x01000000 {
>  			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
>  		};
> +
> +		aips-bus at 02100000 {
> +			mmdc0: mmdc at 021b0000 { /* MMDC0 */
> +				compatible = "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
> +				reg = <0x021b0000 0x4000>;
> +			};
> +		};

It seems that pcie already went wrong, but please still try to add
devices in order of unit-address.

Shawn

>  	};
>  };
> -- 
> 2.5.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
