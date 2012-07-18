From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 18 Jul 2012 12:54:31 +0200
Subject: [PATCH v2 2/2] ARM: dts: imx6q-sabrelite: add usbmisc device
In-Reply-To: <1342607348-8587-3-git-send-email-richard.zhao@freescale.com>
References: <1342607348-8587-1-git-send-email-richard.zhao@freescale.com>
 <1342607348-8587-3-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120718105431.GG30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 18, 2012 at 06:29:07PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts |    4 ++++
>  arch/arm/boot/dts/imx6q.dtsi          |   19 +++++++++++++++----
>  arch/arm/mach-imx/clk-imx6q.c         |    1 +
>  3 files changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index d42e851..c66ff9d 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -62,12 +62,16 @@
>  		aips-bus at 02100000 { /* AIPS2 */
>  			usb at 02184000 { /* USB OTG */
>  				vbus-supply = <&reg_usb_otg_vbus>;
> +				disable-over-current;
>  				status = "okay";
>  			};
>  
>  			usb at 02184200 { /* USB1 */
>  				status = "okay";
>  			};
> +			usbmisc at 02184800 {
> +				status = "okay";
> +			};

Do we need to have this disabled initially in the SoC dtsi?

Also, common style in this file is to add a blank line between nodes.
Please keep it.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
