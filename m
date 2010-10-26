From: jason77.wang@gmail.com (Jason Wang)
Date: Tue, 26 Oct 2010 10:14:02 +0800
Subject: [PATCH 2/4] mx31_3ds: Fix the logic for detecting the debug board
In-Reply-To: <AANLkTikg5rM+cp6oJXmW=DE5=FV=drycqvhz0xWAf1by@mail.gmail.com>
References: <AANLkTikg5rM+cp6oJXmW=DE5=FV=drycqvhz0xWAf1by@mail.gmail.com>
Message-ID: <4CC6396A.20208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Jason Wang <jason77.wang@gmail.com>

Rogerio Pimentel wrote:
> The function mxc_expio_init returns 0 on success, so fix the logic for
> printing the error case.
> Also fixed the wording on the error message.
>
>  Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>  Signed-off-by: Rogerio Pimentel <rogerio.pimentel@freescale.com>
>
> ---
>  arch/arm/mach-mx3/mach-mx31_3ds.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-mx3/mach-mx31_3ds.c
> b/arch/arm/mach-mx3/mach-mx31_3ds.c
> index bc21efc..005c0b2 100644
> --- a/arch/arm/mach-mx3/mach-mx31_3ds.c
> +++ b/arch/arm/mach-mx3/mach-mx31_3ds.c
> @@ -251,9 +251,9 @@ static void __init mxc_board_init(void)
>  	mx31_3ds_usbotg_init();
>  	mxc_register_device(&mxc_otg_udc_device, &usbotg_pdata);
>
> -	if (!mxc_expio_init(CS5_BASE_ADDR, EXPIO_PARENT_INT))
> -		printk(KERN_WARNING "Init of the debugboard failed, all "
> -				    "devices on the board are unusable.\n");
> +	if (mxc_expio_init(CS5_BASE_ADDR, EXPIO_PARENT_INT))
> +		printk(KERN_WARNING "Init of the debug board failed, all "
> +				    "devices on the debug board are unusable.\n");
>  }
>
>  static void __init mx31_3ds_timer_init(void)
>   
