From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 5 Nov 2016 16:31:46 +0800
Subject: [PATCH 1/2] ARM: dts: imx6sx-sdb: update TX D_CAL for USBPHY
In-Reply-To: <1477882709-2518-1-git-send-email-peter.chen@nxp.com>
References: <1477882709-2518-1-git-send-email-peter.chen@nxp.com>
Message-ID: <20161105083145.GF5597@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2016 at 10:58:28AM +0800, Peter Chen wrote:
> We need to change trimming value (as a percentage) of the 17.78mA TX
> reference current for better signal quality. With this change, we
> can patch the eye-diagram test on this board.

s/patch/pass?  I just want to confirm this is a typo, and can fix it up
when applying.

Shawn

> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-sdb.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> index 85f56a5..4933c56 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
> @@ -317,6 +317,14 @@
>  	status = "okay";
>  };
>  
> +&usbphy1 {
> +	fsl,tx-d-cal = <106>;
> +};
> +
> +&usbphy2 {
> +	fsl,tx-d-cal = <106>;
> +};
> +
>  &usdhc2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc2>;
> -- 
> 2.7.4
> 
