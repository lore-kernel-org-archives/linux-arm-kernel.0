From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Dec 2013 21:58:30 +0800
Subject: [PATCH v3 9/9] ARM: DTS: imx5* imx6*, use imx51-ssi
In-Reply-To: <1387367865-26391-10-git-send-email-mpa@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-10-git-send-email-mpa@pengutronix.de>
Message-ID: <20131218135826.GC7172@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 12:57:45PM +0100, Markus Pargmann wrote:
> imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> reconfiguration and needs this for correct interaction with SDMA. This
> patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx51.dtsi   |  3 ++-
>  arch/arm/boot/dts/imx53.dtsi   | 10 +++++++---
>  arch/arm/boot/dts/imx6qdl.dtsi | 12 +++++++++---
>  arch/arm/boot/dts/imx6sl.dtsi  | 12 +++++++++---
>  4 files changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 4bcdd3a..1496421 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -155,7 +155,8 @@
>  				};
>  
>  				ssi2: ssi at 70014000 {
> -					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> +					compatible = "fsl,imx51-ssi",
> +							"fsl,imx21-ssi";

This is an unnecessary change.

Shawn

>  					reg = <0x70014000 0x4000>;
>  					interrupts = <30>;
>  					clocks = <&clks 49>;
