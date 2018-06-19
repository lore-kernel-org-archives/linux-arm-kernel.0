From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 19 Jun 2018 17:49:10 +0200
Subject: [PATCH 1/3] ARM: dts: imx53: Add 'ARM platform' node
In-Reply-To: <1529329939-14117-1-git-send-email-festevam@gmail.com>
References: <1529329939-14117-1-git-send-email-festevam@gmail.com>
Message-ID: <20180619154910.5v2lezckl5eymljr@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 18, 2018 at 10:52:17AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> As per the i.MX53 Reference Manual add an entry for the
> 'ARM platform' region in the device tree.
> 
> This is needed for accessing the ARM_GPC register to set the
> DBGEN bit, so that the debug clocks can be turned on.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Tested-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  arch/arm/boot/dts/imx53.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
> index 1a7a7bb..a70fbf4 100644
> --- a/arch/arm/boot/dts/imx53.dtsi
> +++ b/arch/arm/boot/dts/imx53.dtsi
> @@ -672,6 +672,11 @@
>  				status = "disabled";
>  			};
>  
> +			arm_platform: arm-platform at 63fa0000 {
> +				compatible = "fsl,imx53-arm-plat", "fsl,imx51-arm-plat";
> +				reg = <0x63fa0000 0x28>;
> +			};
> +
>  			owire: owire at 63fa4000 {
>  				compatible = "fsl,imx53-owire", "fsl,imx21-owire";
>  				reg = <0x63fa4000 0x4000>;
> -- 
> 2.7.4
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/35578c63/attachment.sig>
