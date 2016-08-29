From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 14:23:26 +0800
Subject: [PATCH] ARM: dts: imx6ul: set GINT to enable IOMUXC irq
In-Reply-To: <1471969101-12455-1-git-send-email-Anson.Huang@nxp.com>
References: <1471969101-12455-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20160829062326.GH30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 12:18:21AM +0800, Anson Huang wrote:
> Add "fsl,imx6q-iomuxc-gpr" for IOMUXC-GPR to enable
> IOMUXC irq which is required for ERR007265 software
> workaround.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

The patch subject is confusing.  It doesn't match commit log and code
change.

Shawn

> ---
>  arch/arm/boot/dts/imx6ul.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
> index 33b95d7..acc9486 100644
> --- a/arch/arm/boot/dts/imx6ul.dtsi
> +++ b/arch/arm/boot/dts/imx6ul.dtsi
> @@ -644,7 +644,8 @@
>  			};
>  
>  			gpr: iomuxc-gpr at 020e4000 {
> -				compatible = "fsl,imx6ul-iomuxc-gpr", "syscon";
> +				compatible = "fsl,imx6ul-iomuxc-gpr",
> +					     "fsl,imx6q-iomuxc-gpr", "syscon";
>  				reg = <0x020e4000 0x4000>;
>  			};
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
