From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Jun 2015 19:47:09 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: Add HDMI support
In-Reply-To: <1433277693-10767-1-git-send-email-festevam@gmail.com>
References: <1433277693-10767-1-git-send-email-festevam@gmail.com>
Message-ID: <20150629114709.GL10332@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 05:41:33PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add HDMI support. As the DDC I2C pins are not connected due to
> pin conflicts, we do not pass the 'ddc-i2c-bus' property in 
> this case.

HDMI works without 'ddc-i2c-bus' property and I2C pins?  If not, what's
point of this patch.

Shawn

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 46b2fed..48ccfee 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -76,6 +76,10 @@
>  	status = "okay";
>  };
>  
> +&hdmi {
> +	status = "okay";
> +};
> +
>  &i2c2 {
>  	clock-frequency = <100000>;
>  	pinctrl-names = "default";
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
