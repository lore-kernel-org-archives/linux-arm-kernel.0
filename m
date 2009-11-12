From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Thu, 12 Nov 2009 04:43:59 -0800 (PST)
Subject: [PATCH 5/9] pcm043: Add NAND support
In-Reply-To: <1258022525-21078-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <22546.72684.qm@web51004.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

--- On Thu, 11/12/09, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From: Sascha Hauer <s.hauer@pengutronix.de>
> Subject: [PATCH 5/9] pcm043: Add NAND support
> To: linux-arm-kernel at lists.infradead.org
> Cc: "Sascha Hauer" <s.hauer@pengutronix.de>
> Date: Thursday, November 12, 2009, 8:42 AM
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/pcm043.c |? ? 7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/pcm043.c
> b/arch/arm/mach-mx3/pcm043.c
> index e18a224..e3aa829 100644
> --- a/arch/arm/mach-mx3/pcm043.c
> +++ b/arch/arm/mach-mx3/pcm043.c
> @@ -43,6 +43,7 @@
>  #include <mach/iomux-mx35.h>
>  #include <mach/ipu.h>
>  #include <mach/mx3fb.h>
> +#include <mach/mxc_nand.h>
>  
>  #include "devices.h"
>  
> @@ -206,6 +207,11 @@ static struct pad_desc pcm043_pads[] =
> {
>  ??? MX35_PAD_ATA_CS0__GPIO2_6,
>  };
>  
> +static struct mxc_nand_platform_data
> pcm037_nand_board_info = {
> +??? .width = 1,
> +??? .hw_ecc = 1,
> +};
> +
>  /*
> ? * Board specific initialization.
> ? */
> @@ -216,6 +222,7 @@ static void __init
> mxc_board_init(void)
>  ??? platform_add_devices(devices,
> ARRAY_SIZE(devices));
>  
>  ???
> mxc_register_device(&mxc_uart_device0,
> &uart_pdata);
> +???
> mxc_register_device(&mxc_nand_device,
> &pcm037_nand_board_info);
>  
>  ???
> mxc_register_device(&mxc_uart_device1,
> &uart_pdata);
>  
> -- 
> 1.6.5.2

Have you managed to load a root file system via JFFS2 on this board?

Thanks,

Fabio Estevam


      
