From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 9 Jul 2012 14:24:40 +0800
Subject: [PATCH] ARM: dts: imx: Always enable the watchdog
In-Reply-To: <1341606630-26905-1-git-send-email-fabio.estevam@freescale.com>
References: <1341606630-26905-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120709062438.GA11635@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 05:30:30PM -0300, Fabio Estevam wrote:
> Instead of enabling the watchdog in each individual dts file, select in 
> the SoC dtsi file instead.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx27.dtsi        |    2 +-
>  arch/arm/boot/dts/imx51-babbage.dts |    4 ----
>  arch/arm/boot/dts/imx51.dtsi        |    2 +-
>  arch/arm/boot/dts/imx53-ard.dts     |    4 ----
>  arch/arm/boot/dts/imx53-evk.dts     |    4 ----
>  arch/arm/boot/dts/imx53-qsb.dts     |    4 ----
>  arch/arm/boot/dts/imx53-smd.dts     |    4 ----
>  arch/arm/boot/dts/imx53.dtsi        |    2 +-
>  arch/arm/boot/dts/imx6q.dtsi        |    2 +-
>  9 files changed, 4 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
> index 386c769..cd1a7b9 100644
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -56,7 +56,7 @@
>  				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
>  				reg = <0x10002000 0x4000>;
>  				interrupts = <27>;
> -				status = "disabled";
> +				status = "okay";
>  			};

So imx27-phytec-phycore.dts needs an update.

Regards,
Shawn
