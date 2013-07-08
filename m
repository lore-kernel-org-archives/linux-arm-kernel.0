From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Jul 2013 10:33:06 +0800
Subject: [PATCH] ARM: dts: i.MX51: Add WEIM node
In-Reply-To: <1373094142-24173-1-git-send-email-shc_work@mail.ru>
References: <1373094142-24173-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130708023304.GA22636@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 06, 2013 at 11:02:22AM +0400, Alexander Shiyan wrote:
> This patch adds the missing (Wireless External Interface Module) WEIM
> devicetree node for i.MX51 CPUs.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 0ca62be..e71976e4 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -745,6 +745,23 @@
>  				status = "disabled";
>  			};
>  
> +			weim: weim at 83fda000 {
> +				#address-cells = <2>;
> +				#size-cells = <1>;
> +				compatible = "fsl,imx51-weim";
> +				reg = <0x83fda000 0x1000>;
> +				clocks = <&clks 0>;

Is it correct?  I think there should be a physical clock for weim.

Shawn

> +				ranges = <
> +					0 0 0xb0000000 0x08000000
> +					1 0 0xb8000000 0x08000000
> +					2 0 0xc0000000 0x08000000
> +					3 0 0xc8000000 0x04000000
> +					4 0 0xcc000000 0x02000000
> +					5 0 0xce000000 0x02000000
> +				>;
> +				status = "disabled";
> +			};
> +
>  			nfc: nand at 83fdb000 {
>  				compatible = "fsl,imx51-nand";
>  				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
> -- 
> 1.8.1.5
> 
