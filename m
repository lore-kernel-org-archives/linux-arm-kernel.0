From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 31 Jan 2012 09:14:18 -0700
Subject: [PATCH] LPC32XX build fix
In-Reply-To: <1327669485-15322-1-git-send-email-stigge@antcom.de>
References: <1327669485-15322-1-git-send-email-stigge@antcom.de>
Message-ID: <CACxGe6sDyz5n=eDmDnUJjtiaYCN409pA=34pJKhM7FvcKvAqaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 6:04 AM, Roland Stigge <stigge@antcom.de> wrote:
> This patch fixes a GCC compile error ("static declaration follows non-static
> declaration") for LPC32XX's watchdog, removing the extern declaration since
> it's not called externally.
>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
>
> diff --git a/arch/arm/mach-lpc32xx/common.h b/arch/arm/mach-lpc32xx/common.h
> index 4b4e700..75640bfb 100644
> --- a/arch/arm/mach-lpc32xx/common.h
> +++ b/arch/arm/mach-lpc32xx/common.h

No need to CC me on patches like this.  I'm not in any way involved
with lpc32xx maintainership.

g.

> @@ -65,7 +65,6 @@ extern u32 clk_get_pclk_div(void);
> ?*/
> ?extern void lpc32xx_get_uid(u32 devid[4]);
>
> -extern void lpc32xx_watchdog_reset(void);
> ?extern u32 lpc32xx_return_iram_size(void);
>
> ?/*



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
