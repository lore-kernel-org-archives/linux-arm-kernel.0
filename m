From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 May 2014 20:40:08 -0400
Subject: [PATCH v6 02/15] irq: gic: use mask field in GICC_IAR
In-Reply-To: <1399795571-17231-3-git-send-email-haojian.zhuang@linaro.org>
References: <1399795571-17231-1-git-send-email-haojian.zhuang@linaro.org>
 <1399795571-17231-3-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140519004008.GC27822@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 11, 2014 at 04:05:58PM +0800, Haojian Zhuang wrote:
> Bit[9:0] is interrupt ID field in GICC_IAR. Bit[12:10] is CPU ID field,
> and others are reserved.
> 
> So we should use GICC_IAR_INT_ID_MASK to get interrupt ID. It's not a good way
> to use ~0x1c00 (CPU ID field) to get interrupt ID.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> ---
>  drivers/irqchip/irq-gic.c       | 2 +-
>  include/linux/irqchip/arm-gic.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Applied to irqchip/core.

Amended subject line to "irqchip: gic: Use mask field in GICC_IAR"

thx,

Jason.
