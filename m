From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 10 Oct 2016 14:37:55 +0200
Subject: [PATCH 1/2] mmc: block: add missing header dependencies
In-Reply-To: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
References: <1475199459-4775-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <CAPDyKFpTB-YM3J3dB7Us0Q_AF2fojm369eZmHw7M2v1ZiWJu2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2016 at 03:37, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> We get 1 warning when building kernel with W=1:
> drivers/mmc/card/block.c:2147:5: warning: no previous prototype for 'mmc_blk_issue_rq' [-Wmissing-prototypes]
>
> In fact, this function is declared in drivers/mmc/card/block.h,
> so this patch adds missing header dependencies.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Thanks, applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/card/block.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
> index c333511..0f2cc9f2 100644
> --- a/drivers/mmc/card/block.c
> +++ b/drivers/mmc/card/block.c
> @@ -46,6 +46,7 @@
>  #include <asm/uaccess.h>
>
>  #include "queue.h"
> +#include "block.h"
>
>  MODULE_ALIAS("mmc:block");
>  #ifdef MODULE_PARAM_PREFIX
> --
> 2.7.4
>
