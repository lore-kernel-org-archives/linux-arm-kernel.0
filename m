From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jul 2012 09:48:49 +0800
Subject: [PATCH v2] ARM: dts: imx: Always enable the watchdog
In-Reply-To: <1343504610-2417-1-git-send-email-festevam@gmail.com>
References: <1343504610-2417-1-git-send-email-festevam@gmail.com>
Message-ID: <20120730014847.GD30774@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 28, 2012 at 04:43:30PM -0300, Fabio Estevam wrote:
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -56,7 +56,7 @@
>  				compatible = "fsl,imx27-wdt", "fsl,imx21-wdt";
>  				reg = <0x10002000 0x4000>;
>  				interrupts = <27>;
> -				status = "disabled";
> +				status = "okay";

"okay" is generally used by <board>.dts to overwrite "disabled" set in
<soc>.dtsi.  If we want to have the block enabled in <soc>.dtsi, simply
do not leave status property there, and "okay" will be the default.

>  			};

-- 
Regards,
Shawn
