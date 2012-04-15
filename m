From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 15 Apr 2012 08:53:57 +0800
Subject: [PATCH 2/2] ARM: imx6q-arm2:: Pass GPIO for FEC PHY reset
In-Reply-To: <1334171256-18761-2-git-send-email-festevam@gmail.com>
References: <1334171256-18761-1-git-send-email-festevam@gmail.com>
 <1334171256-18761-2-git-send-email-festevam@gmail.com>
Message-ID: <20120415005355.GC24997@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2012 at 04:07:36PM -0300, Fabio Estevam wrote:
> GPIO4_15 is used for FEC PHY reset.
> 
Is this the info you got from schematics?  The schematics on my hand
tells something different.

Regards,
Shawn

> Pass it to the FEC driver.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-arm2.dts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
> index 04501d1..aa230d2 100644
> --- a/arch/arm/boot/dts/imx6q-arm2.dts
> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
> @@ -29,6 +29,7 @@
>  		aips-bus at 02100000 { /* AIPS2 */
>  			enet at 02188000 {
>  				phy-mode = "rgmii";
> +				phy-reset-gpios = <&gpio4 15 0>;
>  				status = "okay";
>  			};
>  
> -- 
> 1.7.1
> 
