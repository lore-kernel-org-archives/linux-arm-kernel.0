From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 10 Aug 2010 19:42:21 +0400
Subject: [PATCH] lpc32xx/clock: Use && instead of &
In-Reply-To: <1281451732-19294-1-git-send-email-w.sang@pengutronix.de>
References: <1281451732-19294-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <4C61735D.40602@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

Wolfram Sang wrote:

> Because we are connecting two expressions here, not binary values.

> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Kevin Wells <wellsk40@gmail.com>
> ---
>  arch/arm/mach-lpc32xx/clock.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

> diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
> index 32d6379..9ff1438 100644
> --- a/arch/arm/mach-lpc32xx/clock.c
> +++ b/arch/arm/mach-lpc32xx/clock.c
> @@ -397,7 +397,7 @@ static int local_usbpll_enable(struct clk *clk, int enable)
>  		__raw_writel(reg, LPC32XX_CLKPWR_USB_CTRL);
>  
>  		/* Wait for PLL lock */
> -		while ((timeout > jiffies) & (ret == -ENODEV)) {
> +		while ((timeout > jiffies) && (ret == -ENODEV)) {

    Could also kill unnecessary parens, while at it...

WBR, Sergei
