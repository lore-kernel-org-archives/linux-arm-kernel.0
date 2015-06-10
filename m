From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 10 Jun 2015 13:59:52 +0200
Subject: [PATCH v5 3/7] mmc: mediatek: Add PM support for MMC driver
In-Reply-To: <1433903088-14407-4-git-send-email-chaotian.jing@mediatek.com>
References: <1433903088-14407-1-git-send-email-chaotian.jing@mediatek.com>
 <1433903088-14407-4-git-send-email-chaotian.jing@mediatek.com>
Message-ID: <CAPDyKFrdw6m8C6oXRRC1cxmOPda8WqrFwwuP87rDBqEehdTaTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 June 2015 at 04:24, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
> Add PM support for Mediatek MMC driver
> Save/restore registers when PM
>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 88 +++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 85 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 8de3299..62e966f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -22,6 +22,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>

Add pm.h as well.

> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/spinlock.h>
>

[...]

Kind regards
Uffe
