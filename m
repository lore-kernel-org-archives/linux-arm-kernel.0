From: yoshihiro.shimoda.uh@renesas.com (Shimoda, Yoshihiro)
Date: Tue, 29 Oct 2013 18:47:26 +0900
Subject: [PATCH 10/12] usb: r8a66597-hcd: Convert to clk_prepare/unprepare
In-Reply-To: <1383000569-8916-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383000569-8916-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <526F842E.1010607@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent-san,

(2013/10/29 7:49), Laurent Pinchart wrote:
> Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> clk_disable_unprepare() to get ready for the migration to the common
> clock framework.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Cc: linux-usb at vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thank you for the patch.

Acked-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihro Shimoda

> ---
>  drivers/usb/host/r8a66597-hcd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/host/r8a66597-hcd.c b/drivers/usb/host/r8a66597-hcd.c
> index 2ad004a..a2fdd85 100644
> --- a/drivers/usb/host/r8a66597-hcd.c
> +++ b/drivers/usb/host/r8a66597-hcd.c
> @@ -95,7 +95,7 @@ static int r8a66597_clock_enable(struct r8a66597 *r8a66597)
>  	int i = 0;
>  
>  	if (r8a66597->pdata->on_chip) {
> -		clk_enable(r8a66597->clk);
> +		clk_prepare_enable(r8a66597->clk);
>  		do {
>  			r8a66597_write(r8a66597, SCKE, SYSCFG0);
>  			tmp = r8a66597_read(r8a66597, SYSCFG0);
> @@ -139,7 +139,7 @@ static void r8a66597_clock_disable(struct r8a66597 *r8a66597)
>  	udelay(1);
>  
>  	if (r8a66597->pdata->on_chip) {
> -		clk_disable(r8a66597->clk);
> +		clk_disable_unprepare(r8a66597->clk);
>  	} else {
>  		r8a66597_bclr(r8a66597, PLLC, SYSCFG0);
>  		r8a66597_bclr(r8a66597, XCKE, SYSCFG0);
> 

-- 
Yoshihiro Shimoda
EC No.
