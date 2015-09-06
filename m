From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 6 Sep 2015 15:55:18 +0800
Subject: [PATCH V6 3/3] ARM: mxs: enable ocotp for i.MX23 and i.MX28
In-Reply-To: <1439418116-1833-4-git-send-email-stefan.wahren@i2se.com>
References: <1439418116-1833-1-git-send-email-stefan.wahren@i2se.com>
 <1439418116-1833-4-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150906075518.GJ30746@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 10:21:56PM +0000, Stefan Wahren wrote:
> This patch enables On Chip OTP support for i.MX23 and i.MX28 SoCs,
> but keeps the old compatible string.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/imx23.dtsi |    7 +++++--
>  arch/arm/boot/dts/imx28.dtsi |    7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
> index b995333..0541563 100644
> --- a/arch/arm/boot/dts/imx23.dtsi
> +++ b/arch/arm/boot/dts/imx23.dtsi
> @@ -383,9 +383,12 @@
>  			};
>  
>  			ocotp at 8002c000 {
> -				compatible = "fsl,ocotp";
> +				compatible = "fsl,imx23-ocotp", "fsl,ocotp";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				reg = <0x8002c000 0x2000>;
> -				status = "disabled";
> +				clocks = <&clks 15>;
> +				status = "okay";

For devices we want to enable by default, omitting "status" property
will just do the job.

I just dropped the line (imx28.dtsi as well) and applied the patch.

Shawn

>  			};
>  
>  			axi-ahb at 8002e000 {
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index 4e073e8..648d790 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -936,9 +936,12 @@
>  			};
>  
>  			ocotp: ocotp at 8002c000 {
> -				compatible = "fsl,ocotp";
> +				compatible = "fsl,imx28-ocotp", "fsl,ocotp";
> +				#address-cells = <1>;
> +				#size-cells = <1>;
>  				reg = <0x8002c000 0x2000>;
> -				status = "disabled";
> +				clocks = <&clks 25>;
> +				status = "okay";
>  			};
>  
>  			axi-ahb at 8002e000 {
> -- 
> 1.7.9.5
> 
