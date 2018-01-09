From: sebastian.reichel@collabora.co.uk (Sebastian Reichel)
Date: Tue, 9 Jan 2018 10:19:19 +0100
Subject: [PATCH v7 2/9] arm: omap: timer: Wrap the inline functions under
 OMAP2PLUS define
In-Reply-To: <1515478987-5786-3-git-send-email-j-keerthy@ti.com>
References: <1515478987-5786-1-git-send-email-j-keerthy@ti.com>
 <1515478987-5786-3-git-send-email-j-keerthy@ti.com>
Message-ID: <20180109091919.m4xx6kgs6ad32nvz@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 09, 2018 at 11:53:00AM +0530, Keerthy wrote:
> Wrap the inline functions under OMAP2PLUS/OMAP1 defines.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Tested-by: Ladislav Michl <ladis@linux-mips.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> ---
>  arch/arm/plat-omap/include/plat/dmtimer.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index dd79f30..862ad62 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -276,6 +276,12 @@ struct omap_dm_timer {
>  #define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
>  		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
>  
> +/*
> + * The below are inlined to optimize code size for system timers. Other code
> + * should not need these at all, see
> + * include/linux/platform_data/pwm_omap_dmtimer.h
> + */
> +#if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
>  static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
>  						int posted)
>  {
> @@ -414,5 +420,5 @@ static inline void __omap_dm_timer_write_status(struct omap_dm_timer *timer,
>  {
>  	writel_relaxed(value, timer->irq_stat);
>  }
> -
> +#endif /* CONFIG_ARCH_OMAP1 || CONFIG_ARCH_OMAP2PLUS */
>  #endif /* __ASM_ARCH_DMTIMER_H */
> -- 
> 1.9.1
> 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180109/b23d858f/attachment.sig>
