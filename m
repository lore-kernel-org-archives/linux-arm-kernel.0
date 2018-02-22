From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Feb 2018 11:40:22 +0800
Subject: [PATCH] ARM: dts: imx6qdl-udoo: Disable usbh1 to avoid kernel hang
In-Reply-To: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
References: <1516278858-15464-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20180222034021.GE3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 18, 2018 at 10:34:18AM -0200, Fabio Estevam wrote:
> Currently the kernel hangs when USB Host1 is enabled due to the lack of
> support for controlling the USB hub clock and GPIO reset line.
> 
> Peter Chen has made several attempts to fix this problem, but his series
> has not been applied yet, so better disable USB host1 for now to avoid
> the kernel hang.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

The commit log is not clear enough to tell why it works for v4.12 and
doesn't for 4.13 and later ones.

Shawn

> ---
>  arch/arm/boot/dts/imx6qdl-udoo.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-udoo.dtsi b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> index 4161b7d..1f0b9f6 100644
> --- a/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-udoo.dtsi
> @@ -274,7 +274,8 @@
>  	pinctrl-0 = <&pinctrl_usbh>;
>  	vbus-supply = <&reg_usb_h1_vbus>;
>  	clocks = <&clks IMX6QDL_CLK_CKO>;
> -	status = "okay";
> +	/* currently USB support causes a kernel hang. Disable it for now */
> +	status = "disabled";
>  };
>  
>  &usdhc3 {
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
