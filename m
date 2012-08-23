From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Aug 2012 14:44:38 +0200
Subject: [PATCH] atmel-ssc: include linux/io.h for raw io
In-Reply-To: <1344887950-25596-1-git-send-email-joachim.eastwood@jotron.com>
References: <1344887950-25596-1-git-send-email-joachim.eastwood@jotron.com>
Message-ID: <503625B6.1090204@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2012 09:59 PM, Joachim Eastwood :
> Include linux/io.h for raw io operations in atmel-scc header.
> 
> This fixes the following build error:
>   CC [M]  sound/soc/atmel/atmel_ssc_dai.o
> sound/soc/atmel/atmel_ssc_dai.c: In function 'atmel_ssc_interrupt':
> sound/soc/atmel/atmel_ssc_dai.c:171: error: implicit declaration of function '__raw_readl'
> sound/soc/atmel/atmel_ssc_dai.c: In function 'atmel_ssc_shutdown':
> sound/soc/atmel/atmel_ssc_dai.c:249: error: implicit declaration of function '__raw_writel'
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>

Added to at91-fixes for 3.6. Thanks!

Arnd, can I queue this one in my upcoming pull-request to you?

> ---
>  include/linux/atmel-ssc.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/atmel-ssc.h b/include/linux/atmel-ssc.h
> index 0602339..4eb3175 100644
> --- a/include/linux/atmel-ssc.h
> +++ b/include/linux/atmel-ssc.h
> @@ -3,6 +3,7 @@
>  
>  #include <linux/platform_device.h>
>  #include <linux/list.h>
> +#include <linux/io.h>
>  
>  struct ssc_device {
>  	struct list_head	list;
> 


-- 
Nicolas Ferre
