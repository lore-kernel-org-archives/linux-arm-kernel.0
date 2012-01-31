From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 31 Jan 2012 11:26:58 +0100
Subject: [PATCH v2 5/7] LPC32xx: clock.c: warning fix
In-Reply-To: <1327939327-7799-5-git-send-email-stigge@antcom.de>
References: <1327939327-7799-1-git-send-email-stigge@antcom.de>
 <1327939327-7799-5-git-send-email-stigge@antcom.de>
Message-ID: <20120131102658.GH2471@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:02:04PM +0100, Roland Stigge wrote:
> This patch removes the debug warning on local_clk_disable() as done in Kevin
> Wells' driver update
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

Maybe this can be folded with 7/7? Otherwise

Acked-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Wolfram Sang <w.sang@pengutronix.de>

> 
> diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
> index 229bec5..01e9aba 100644
> --- a/arch/arm/mach-lpc32xx/clock.c
> +++ b/arch/arm/mach-lpc32xx/clock.c
> @@ -903,8 +903,6 @@ static inline void clk_unlock(void)
>  
>  static void local_clk_disable(struct clk *clk)
>  {
> -	WARN_ON(clk->usecount == 0);
> -
>  	/* Don't attempt to disable clock if it has no users */
>  	if (clk->usecount > 0) {
>  		clk->usecount--;

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120131/321eaa5d/attachment-0001.sig>
