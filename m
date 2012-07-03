From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Jul 2012 11:03:39 +0800
Subject: [PATCH 1/2] ARM: imx6q-sabrelite.dts: Add watchdog support
In-Reply-To: <1341258627-3469-1-git-send-email-festevam@gmail.com>
References: <1341258627-3469-1-git-send-email-festevam@gmail.com>
Message-ID: <20120703030337.GD22106@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2012 at 04:50:26PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add watchdog support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index e0ec929..99581a0 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -42,6 +42,9 @@
>  				};
>  			};
>  
> +			wdog at 020bc000 { /* WDOG1 */
> +				status = "okay";
> +			};

I'm wondering if it makes more sense to have wdog, rtc, such completely
soc internal stuff always enabled in <soc>.dtsi.

>  		};
>  
>  		aips-bus at 02100000 { /* AIPS2 */
> -- 
> 1.7.1
> 

-- 
Regards,
Shawn
