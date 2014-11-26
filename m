From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 26 Nov 2014 03:20:46 -0500
Subject: [PATCH v2 0/3] irqchip: dw-apb-ictl:
 IRQ_GC_MASK_CACHE_PER_TYPE and PM support
In-Reply-To: <1415773374-4629-1-git-send-email-jszhang@marvell.com>
References: <1415773374-4629-1-git-send-email-jszhang@marvell.com>
Message-ID: <20141126082046.GF22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 02:22:51PM +0800, Jisheng Zhang wrote:
> These patches try to improve dw-apb-ictl irqchip driver a bit.
> 
> The first patch improves the performance a bit -- use the relaxed version
> 
> The two dw-apb-ictl's irq_chip_type instances have separate mask registers, so the second patch enables IRQ_GC_MASK_CACHE_PER_TYPE.
> 
> The last patch adds suspend/resume support to the driver.
> 
> Tested on Marvell BG2Q-DMP board.
> 
> Changes in v2:
>   - Add Sebastian's Acks
>   - Update the first commit as Sebastian and Thomas suggested
>   - Add into commit log summary of the discussion why relaxed variants can be used
> 
> Jisheng Zhang (3):
>   irqchip: dw-apb-ictl: always use use {readl|writel}_relaxed
>   irqchip: dw-apb-ictl: enable IRQ_GC_MASK_CACHE_PER_TYPE
>   irqchip: dw-apb-ictl: add PM support
> 
>  drivers/irqchip/irq-dw-apb-ictl.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)

Whole series applied to irqchip/core

thx,

Jason.
