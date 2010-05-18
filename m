From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 18 May 2010 05:57:03 +0100
Subject: [PATCH 01/15] ARM: Samsung: fix broken timer irq base
In-Reply-To: <1273817946-29404-2-git-send-email-m.szyprowski@samsung.com>
References: <1273817946-29404-1-git-send-email-m.szyprowski@samsung.com>
	<1273817946-29404-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20100518045703.GA26401@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 14, 2010 at 08:18:52AM +0200, Marek Szyprowski wrote:
> Timer interrupts range was defined as 43-47, what overlaps with VIC0 range
> (32-64). This was caused probably by a typo while the common interrupts
> definition was refactored. This patch moves timer interrupt range to safe
> area of 11-15 (just before uart range).

I've put this on for-2635/s5p-general as it is a reasonably important
bugfix for s5p. Have updated the comment to reference the commit that
caused the problem in the first place.
 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/plat-s5p/include/plat/irqs.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-s5p/include/plat/irqs.h b/arch/arm/plat-s5p/include/plat/irqs.h
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
> 1.6.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
