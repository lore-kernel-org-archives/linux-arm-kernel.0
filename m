From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 21 Feb 2012 20:25:05 +0900
Subject: [PATCH v3] DMA: PL330: Merge PL330 driver into drivers/dma/
In-Reply-To: <1329341243-14314-1-git-send-email-kgene.kim@samsung.com>
References: <1329341243-14314-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <00b401ccf08b$75b35870$611a0950$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kukjin Kim wrote:
> 
> From: Boojin Kim <boojin.kim@samsung.com>
> 
> Currently there were two part of DMAC PL330 driver for
> support old styled s3c-pl330 which has been merged into
> drivers/dma/pl330.c driver. Actually, there is no reason
> to separate them now.
> 
> Basically this patch merges arch/arm/common/pl330.c into
> drivers/dma/pl330.c driver and removes useless exported
> symbol, externed function and so on.
> 
> The newer pl330 driver tested on SMDKV310 and SMDK4212 boards
> 
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>

Hi Russell,

This addressed comments from you about moving 'asm/hardware/pl330.h' into
'drivers/dma/', there is nowhere it is used except drivers/dma/.

If you have any objection on this, please let me know.

As we talked last time, if you're ok on this let me send 'pull request' this
series to you and Vinod. I think this should be sent to rmk tree and dma
tree together.

As a note, this is in 'v3.4-for-vkoul-v2' of linux-samsung.git now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> Changes since v2:
> - Address comments from Russell King
>   the 'asm/hardware/pl330.h' is moved to 'drivers/dma/pl330.h'
>   which is used only in drivers/dma/
> 
>  arch/arm/common/Kconfig               |    3 -
>  arch/arm/common/Makefile              |    1 -
>  arch/arm/common/pl330.c               | 1959
--------------------------------
> -
>  arch/arm/include/asm/hardware/pl330.h |  217 ----
>  drivers/dma/Kconfig                   |    1 -
>  drivers/dma/pl330.c                   | 1892
+++++++++++++++++++++++++++++++-
>  drivers/dma/pl330.h                   |  251 +++++
>  include/linux/amba/pl330.h            |    1 -
>  8 files changed, 2142 insertions(+), 2183 deletions(-)
>  delete mode 100644 arch/arm/common/pl330.c
>  delete mode 100644 arch/arm/include/asm/hardware/pl330.h
>  create mode 100644 drivers/dma/pl330.h
