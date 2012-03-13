From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 13 Mar 2012 12:42:59 +0530
Subject: [PATCH 1/5] ARM: OMAP2+: declare file-local functions as static
In-Reply-To: <20120312224251.4103.76124.stgit@dusk>
References: <20120312224006.4103.29464.stgit@dusk>
 <20120312224251.4103.76124.stgit@dusk>
Message-ID: <CAMQu2gwJGGL8VKuNxUmH5BbCYhTQCBDW7TbsE4RjCziE9TWCVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2012 at 4:12 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Several function declarations used only in the files in which they're
> declared should include the static keyboard, but don't:
>
> ? ?arch/arm/mach-omap2/serial.c:248:6: warning: symbol 'cmdline_find_option' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/omap-wakeupgen.c:259:6: warning: symbol 'irq_sar_clear' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/board-rx51-peripherals.c:878:27: warning: symbol 'rx51_vibra_data' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/board-rx51-peripherals.c:882:27: warning: symbol 'rx51_audio_data' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/board-omap4panda.c:201:29: warning: symbol 'omap_panda_wlan_data' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/board-omap4panda.c:393:24: warning: symbol 'omap4_panda_dvi_device' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/board-omap4panda.c:403:12: warning: symbol 'omap4_panda_dvi_init' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/board-omap4panda.c:464:6: warning: symbol 'omap4_panda_display_init' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/hsmmc.c:434:6: warning: symbol 'omap_init_hsmmc' was not declared. Should it be static?
> ? ?arch/arm/mach-omap2/hwspinlock.c:31:12: warning: symbol 'hwspinlocks_init' was not declared. Should it be static?
>
> Mark all of these as static.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Govindraj R <govindraj.raja@ti.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: David Anders <x0132446@ti.com>
> Cc: Simon Que <sque@ti.com>
> ---
For the wakeupgen change,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
