From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 19 Sep 2012 10:06:30 -0700
Subject: [PATCH 20/24] input: rpcmouse: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-21-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-21-git-send-email-arnd@arndb.de>
Message-ID: <20120919170630.GC16286@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 11:34:48PM +0200, Arnd Bergmann wrote:
> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input at vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/mouse/rpcmouse.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
> index 272dedd..21c60fe 100644
> --- a/drivers/input/mouse/rpcmouse.c
> +++ b/drivers/input/mouse/rpcmouse.c
> @@ -42,7 +42,7 @@ static irqreturn_t rpcmouse_irq(int irq, void *dev_id)
>  
>  	x = (short) iomd_readl(IOMD_MOUSEX);
>  	y = (short) iomd_readl(IOMD_MOUSEY);
> -	b = (short) (__raw_readl(0xe0310000) ^ 0x70);
> +	b = (short) (__raw_readl(IOMEM(0xe0310000)) ^ 0x70);
>  
>  	dx = x - rpcmouse_lastx;
>  	dy = y - rpcmouse_lasty;
> -- 
> 1.7.10
> 

-- 
Dmitry
