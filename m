From: tony@atomide.com (Tony Lindgren)
Date: Mon, 7 Jul 2014 01:14:56 -0700
Subject: [PATCH] mach-omap1: Fix call to omap_cfg_reg
In-Reply-To: <1404493320-5606-1-git-send-email-xerofoify@gmail.com>
References: <1404493320-5606-1-git-send-email-xerofoify@gmail.com>
Message-ID: <20140707081456.GH28884@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicholas Krause <xerofoify@gmail.com> [140704 10:03]:
> This patch fixes the call to ompa_cfg_reg(USB2_SPEED) in the case
> that the cpu is a omap16xx and the nwires are not equal to 3.

This is most likely unsafe to do as the pin is probably
shared with some other device and we have to rely for
the bootloader to do the right thing for the board.

Regards,

Tony
 
> Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
> ---
>  arch/arm/mach-omap1/usb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/usb.c b/arch/arm/mach-omap1/usb.c
> index 4118db5..17e3139 100644
> --- a/arch/arm/mach-omap1/usb.c
> +++ b/arch/arm/mach-omap1/usb.c
> @@ -504,8 +504,7 @@ static u32 __init omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
>  		omap_cfg_reg(W9_USB2_TXEN);
>  		omap_cfg_reg(W5_USB2_SE0);
>  		if (nwires != 3)
> -			omap_cfg_reg(Y5_USB2_RCV);
> -		// FIXME omap_cfg_reg(USB2_SPEED);
> +			omap_cfg_reg(USB2_SPEED)
>  	} else {
>  		pr_debug("usb%d cpu unrecognized\n", 1);
>  		return 0;
> -- 
> 1.9.1
> 
