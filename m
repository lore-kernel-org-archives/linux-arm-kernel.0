From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 19 Jun 2012 09:42:20 +0800
Subject: [PATCH] ARM: imx28.dtsi: Add pinmux for additional AUART ports
In-Reply-To: <1340054922-16092-1-git-send-email-festevam@gmail.com>
References: <1340054922-16092-1-git-send-email-festevam@gmail.com>
Message-ID: <20120619014218.GB21951@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 06:28:42PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add pinmux for additional AUART ports.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx28.dtsi |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> index ee3778a..c98d17a 100644
> --- a/arch/arm/boot/dts/imx28.dtsi
> +++ b/arch/arm/boot/dts/imx28.dtsi
> @@ -197,6 +197,21 @@
>  					fsl,pull-up = <0>;
>  				};
>  
> +				auart1_pins_a: auart1 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x3040 0x3050 0x3060 0x3070>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};
> +
> +				auart2_pins_a: auart2 at 0 {
> +					reg = <0>;
> +					fsl,pinmux-ids = <0x3080 0x3090 0x30a0 0x30b0>;
> +					fsl,drive-strength = <0>;
> +					fsl,voltage = <1>;
> +					fsl,pull-up = <0>;
> +				};

I would rather have these pin settings added along with the users to
ensure the pad configuration works for the boards or proper pad fix-up
for the boards are added together.

>  				auart3_pins_a: auart3 at 0 {
>  					reg = <0>;
>  					fsl,pinmux-ids = <0x30c0 0x30d0 0x30e0 0x30f0>;
> -- 
> 1.7.1
> 

-- 
Regards,
Shawn
