From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 23 Aug 2012 18:46:22 +0200
Subject: [PATCH] ASoC: atmel-ssc: include linux/io.h for raw io
In-Reply-To: <1345738494-4014-1-git-send-email-nicolas.ferre@atmel.com>
References: <20120823152324.GI7995@opensource.wolfsonmicro.com>
 <1345738494-4014-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20120823164622.GA7629@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:14 Thu 23 Aug     , Nicolas Ferre wrote:
> From: Joachim Eastwood <manabian@gmail.com>
> 
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
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> ---
> Mark,
> 
> Here is a copy of the original patch by Joachim. Can you please take a look and
> give your acknowledgement so that I can queue it in arm-soc tree.
> 
> Thanks, bye,
> 
>  include/linux/atmel-ssc.h |    1 +
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
> -- 
> 1.7.10
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
