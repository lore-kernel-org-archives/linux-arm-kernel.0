From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 12 Jan 2011 11:21:12 +0900
Subject: [PATCH 08/16] ARM: samsung: serial: don't treat NULL clk as an
	error
In-Reply-To: <1294749833-32019-9-git-send-email-jamie@jamieiles.com>
References: <1294749833-32019-1-git-send-email-jamie@jamieiles.com>
	<1294749833-32019-9-git-send-email-jamie@jamieiles.com>
Message-ID: <017601cbb1ff$63e80d00$2bb82700$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote:
> 
> clk_get() returns a struct clk cookie to the driver and some platforms
> may return NULL if they only support a single clock.  clk_get() has only
> failed if it returns a ERR_PTR() encoded pointer.
> 
> Cc: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> ---
>  drivers/serial/samsung.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/serial/samsung.c b/drivers/serial/samsung.c
> index 7ac2bf5..be93d2f 100644
> --- a/drivers/serial/samsung.c
> +++ b/drivers/serial/samsung.c
> @@ -42,6 +42,7 @@
>  #include <linux/serial.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
> +#include <linux/err.h>
>  #include <linux/cpufreq.h>
> 
>  #include <asm/irq.h>
> @@ -522,7 +523,7 @@ static int s3c24xx_serial_calcbaud(struct baud_calc
*calc,
>  	unsigned long rate;
> 
>  	calc->src = clk_get(port->dev, clksrc->name);
> -	if (calc->src == NULL || IS_ERR(calc->src))
> +	if (IS_ERR(calc->src))
>  		return 0;
> 
>  	rate = clk_get_rate(calc->src);
> --
1.7.3.4
