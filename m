From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Fri, 26 Feb 2010 17:34:56 -0800 (PST)
Subject: [PATCH] mx31pdk: Add NAND support
In-Reply-To: <48285.22454.qm@web51005.mail.re2.yahoo.com>
Message-ID: <744195.72820.qm@web51002.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

--- On Wed, 2/24/10, Fabio Estevam <fabioestevam@yahoo.com> wrote:

> From: Fabio Estevam <fabioestevam@yahoo.com>
> Subject: [PATCH] mx31pdk: Add NAND support
> To: linux-arm-kernel at lists.infradead.org
> Cc: s.hauer at pengutronix.de
> Date: Wednesday, February 24, 2010, 10:58 PM
> Add NAND support to MX31PDK board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx3/mach-mx31_3ds.c |? ? 7
> +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c
> b/arch/arm/mach-mx3/mach-mx31_3ds.c
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
> @@ -80,6 +81,11 @@ static struct resource
> smsc911x_resources[] = {
>  ??? },
>  };
>  
> +static struct mxc_nand_platform_data
> mx31pdk_nand_board_info = {
> +??? .width = 1,
> +??? .hw_ecc = 1,
> +};
> +
>  static struct platform_device smsc911x_device = {
>  ??? .name???
> ??? = "smsc911x",
>  ??? .id???
> ??? = -1,
> @@ -236,6 +242,7 @@ static void __init
> mxc_board_init(void)
>  ??? ??? ???
> ??? ? ? ? "mx31pdk");
>  
>  ???
> mxc_register_device(&mxc_uart_device0,
> &uart_pdata);
> +???
> mxc_register_device(&mxc_nand_device,
> &mx31pdk_nand_board_info);
>  
>  ??? if (!mx31pdk_init_expio())
>  ??? ???
> platform_device_register(&smsc911x_device);
> -- 
> 1.6.0.4

Do you think this patch is OK?

Regards,

Fabio Estevam


      
