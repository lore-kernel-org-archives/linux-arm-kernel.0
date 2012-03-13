From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 13 Mar 2012 12:23:14 +0530
Subject: [PATCH 2/5] ARM: OMAP2+: add includes for missing prototypes
In-Reply-To: <20120312224252.4103.75837.stgit@dusk>
References: <20120312224006.4103.29464.stgit@dusk>
 <20120312224252.4103.75837.stgit@dusk>
Message-ID: <CAMQu2gytxATib1HzKNL65jgaNvQ_vf-isKL_RiKDO7ef75u-hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 4:12 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> Several C files in arch/arm/mach-omap2 declare functions that are used
> by other files, but don't include the header file where the prototype is
> declared. ?This results in the following warnings from sparse:
>
> ? ?arch/arm/mach-omap2/irq.c:114:5: warning: symbol 'omap_irq_pending' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:186:13: warning: symbol 'omap2_init_irq' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:191:13: warning: symbol 'omap3_init_irq' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:196:13: warning: symbol 'ti81xx_init_irq' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:233:39: warning: symbol 'omap2_intc_handle_irq' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:242:6: warning: symbol 'omap_intc_save_context' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:265:6: warning: symbol 'omap_intc_restore_context' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:291:6: warning: symbol 'omap3_intc_suspend' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:297:6: warning: symbol 'omap3_intc_prepare_idle' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:306:6: warning: symbol 'omap3_intc_resume_idle' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/irq.c:312:39: warning: symbol 'omap3_intc_handle_irq' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/omap-secure.c:59:12: warning: symbol 'omap_secure_ram_reserve_memblock' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/board-zoom-display.c:133:13: warning: symbol 'zoom_display_init' was not declared. Should it be static?
>
> Fix by including the appropriate header files.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Senthilvadivu Guruswamy <svadivu@ti.com>
> ---
Thanks Paul for the fix.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
