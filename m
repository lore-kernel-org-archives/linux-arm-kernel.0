From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Jun 2013 16:59:52 +0800
Subject: [PATCH] ARM: dts: imx51: Make SDMA firmware name same for DT and
 non-DT
In-Reply-To: <1370850040-11177-1-git-send-email-shc_work@mail.ru>
References: <1370850040-11177-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130610085950.GE6381@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 11:40:40AM +0400, Alexander Shiyan wrote:
> This patch will help migrate i.MX51-targets to DT by make SDMA
> firmware name same for DT and non-DT cases.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx51.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index f23636f..643f005 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -645,7 +645,7 @@
>  				interrupts = <6>;
>  				clocks = <&clks 56>, <&clks 56>;
>  				clock-names = "ipg", "ahb";
> -				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
> +				fsl,sdma-ram-script-name = "sdma-imx51.bin";

Though we haven't got SDMA firmware upstreamed anywhere yet, I think
this name pattern has been established for some platforms, since it has
been used on imx51, imx53 and imx6q for quite a while.  If you system
expects a different one, you can overwrite it in your <board>.dts.

Shawn

>  			};
>  
>  			cspi: cspi at 83fc0000 {
> -- 
> 1.8.1.5
> 
