From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 11:10:07 +0100
Subject: [PATCH] LPC32XX build fix
In-Reply-To: <1327669485-15322-1-git-send-email-stigge@antcom.de>
References: <1327669485-15322-1-git-send-email-stigge@antcom.de>
Message-ID: <20120131101007.GD2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 02:04:45PM +0100, Roland Stigge wrote:
> This patch fixes a GCC compile error ("static declaration follows non-static
> declaration") for LPC32XX's watchdog, removing the extern declaration since
> it's not called externally.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Subject header should contain "arm: lpc32xx" and describe the fix like
"remove broken non-static declaration" or so

Other than that:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

> 
> diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
> index 4b4e700..75640bfb 100644
> --- a/arch/arm/mach-lpc32xx/common.h
> +++ b/arch/arm/mach-lpc32xx/common.h
> @@ -65,7 +65,6 @@ extern u32 clk_get_pclk_div(void);
>   */
>  extern void lpc32xx_get_uid(u32 devid[4]);
>  
> -extern void lpc32xx_watchdog_reset(void);
>  extern u32 lpc32xx_return_iram_size(void);
>  
>  /*

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/14f9ff59/attachment.sig>
