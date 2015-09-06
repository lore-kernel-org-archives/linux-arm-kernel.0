From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 20:08:30 +0800
Subject: [PATCH v2] ARM: dts: imx6sl: Complete the dcp node
In-Reply-To: <1441209321-28331-1-git-send-email-festevam@gmail.com>
References: <1441209321-28331-1-git-send-email-festevam@gmail.com>
Message-ID: <20150906120830.GQ30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 12:55:21PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> The DCP block present on MX6SL is compatible with the one on MX28,
> so add the compatible string and also complete the interrupt entries.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Use compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp"; as suggested by
> Lucas Stach
> 
>  arch/arm/boot/dts/imx6sl.dtsi | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
> index 320a27f..b105735 100644
> --- a/arch/arm/boot/dts/imx6sl.dtsi
> +++ b/arch/arm/boot/dts/imx6sl.dtsi
> @@ -670,8 +670,12 @@
>  			};
>  
>  			dcp: dcp at 020fc000 {
> +				compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";
>  				reg = <0x020fc000 0x4000>;
> -				interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupts = <0 99 IRQ_TYPE_LEVEL_HIGH>,
> +					     <0 100 IRQ_TYPE_LEVEL_HIGH>,
> +					     <0 101 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "okay";

For devices we want to enable by default, omitting 'status' property
will just do the job.  Drop the line and applied the patch.

Shawn

>  			};
>  		};
>  
> -- 
> 1.9.1
> 
