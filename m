From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 12 May 2013 22:21:44 +0800
Subject: [PATCH 5/5] ARM: dts: add SPI/NOR for mx6q{dl}-sabreauto boards
In-Reply-To: <1368070143-1655-6-git-send-email-b32955@freescale.com>
References: <1368070143-1655-1-git-send-email-b32955@freescale.com>
 <1368070143-1655-6-git-send-email-b32955@freescale.com>
Message-ID: <20130512142142.GA4648@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 09, 2013 at 11:29:03AM +0800, Huang Shijie wrote:
> Since the SPI/NOR has pin conflict with the WEIM NOR,
> we disable the spi/nor by default.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |   32 ++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 7b561fb..b6b9e56 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -16,6 +16,38 @@
>  	};
>  };
>  
> +&ecspi1 {
> +	fsl,spi-num-chipselects = <1>;
> +	cs-gpios = <&gpio3 19 0>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_ecspi1_1>;
> +	status = "disabled";

I added a comment to it as below, and applied patch #2~5.

	status = "disabled"; /* pin conflict with WEIM NOR */

Shawn
