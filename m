From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Thu, 25 Feb 2010 12:12:13 +0100
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <48285.22454.qm@web51005.mail.re2.yahoo.com>
References: <48285.22454.qm@web51005.mail.re2.yahoo.com>
Message-ID: <1267096333.2722.44.camel@realization>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On mer, 2010-02-24 at 16:58 -0800, Fabio Estevam wrote:
> Add NAND support to MX31PDK board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx3/mach-mx31_3ds.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index b88c18a..2d78754 100644
> --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> @@ -34,6 +34,7 @@
>  #include <mach/board-mx31pdk.h>
>  #include <mach/imx-uart.h>
>  #include <mach/iomux-mx3.h>
> +#include <mach/mxc_nand.h>
>  #include "devices.h"
>  
>  /*!
> @@ -80,6 +81,11 @@ static struct resource smsc911x_resources[] = {
>  	},
>  };
>  
> +static struct mxc_nand_platform_data mx31pdk_nand_board_info = {
> +	.width = 1,
> +	.hw_ecc = 1,
> +};
> +

Are you sure that this works? Don't you see a lot of Bad blocks reports
in boot messages?


-- 
Alberto!

        Be Persistent!
                - Greg Kroah-Hartman (FOSDEM 2010)
