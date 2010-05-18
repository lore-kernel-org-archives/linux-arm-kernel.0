From: s.hauer@pengutronix.de (MXC Sascha Hauer)
Date: Tue, 18 May 2010 10:45:39 +0200
Subject: [PATCH 2/2] mx31_3ds: Support the keypad situated in the
	personality board
In-Reply-To: <1274120414.3578.36.camel@realization>
References: <1274120092.3578.34.camel@realization>
	<1274120414.3578.36.camel@realization>
Message-ID: <20100518084539.GC31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alberto,

On Mon, May 17, 2010 at 08:20:14PM +0200, Alberto Panizzo wrote:
> 
> 
> Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
> ---
> 
> this patch is built over the today mxc-master branch 
> 
>  arch/arm/mach-mx3/mach-mx31_3ds.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index 55d6117..745675b 100644
> --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> @@ -28,6 +28,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/regulator/machine.h>
>  #include <linux/fsl_devices.h>
> +#include <linux/input/matrix_keypad.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -82,6 +83,35 @@ static int mx31_3ds_pins[] = {
>  	MX31_PIN_USBOTG_DIR__USBOTG_DIR,
>  	MX31_PIN_USBOTG_NXT__USBOTG_NXT,
>  	MX31_PIN_USBOTG_STP__USBOTG_STP,
> +	/*Keyboard*/
> +	IOMUX_MODE(MX31_PIN_KEY_ROW0, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_ROW1, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_ROW2, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL0, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL1, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL2, IOMUX_CONFIG_FUNC),
> +	IOMUX_MODE(MX31_PIN_KEY_COL3, IOMUX_CONFIG_FUNC),
> +};

Care to add these values to iomux-mx3.h and use them?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
