From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 17 May 2010 20:52:51 +0900
Subject: [PATCH 01/15] ARM: Samsung: fix broken timer irq base
In-Reply-To: <1273817946-29404-2-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
	<1273817946-29404-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <003e01caf5b7$7d5a9870$780fc950$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Timer interrupts range was defined as 43-47, what overlaps with VIC0 range
> (32-64). This was caused probably by a typo while the common interrupts
> definition was refactored. This patch moves timer interrupt range to safe
> area of 11-15 (just before uart range).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/include/plat/irqs.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-
> s5p/include/plat/irqs.h
> index 42e757f..9ff3d71 100644
> --- a/arch/arm/plat-s5p/include/plat/irqs.h
> +++ b/arch/arm/plat-s5p/include/plat/irqs.h
> @@ -79,7 +79,7 @@
>  #define S5P_IRQ_VIC2(x)		(S5P_VIC2_BASE + (x))
>  #define S5P_IRQ_VIC3(x)		(S5P_VIC3_BASE + (x))
> 
> -#define S5P_TIMER_IRQ(x)	S5P_IRQ(11 + (x))
> +#define S5P_TIMER_IRQ(x)	(11 + (x))
> 
>  #define IRQ_TIMER0		S5P_TIMER_IRQ(0)
>  #define IRQ_TIMER1		S5P_TIMER_IRQ(1)
> --

Ok, you're right.

Had to move to ISA IRQ space not VIC area for avoid conflicting.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
