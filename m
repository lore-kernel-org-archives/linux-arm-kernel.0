From: khilman@ti.com (Kevin Hilman)
Date: Wed, 20 Apr 2011 17:26:55 -0700
Subject: [PATCH 3/7] OMAP4: GPIO: Save/restore context
In-Reply-To: <1303139217-10285-4-git-send-email-charu@ti.com> (Charulatha
	Varadarajan's message of "Mon, 18 Apr 2011 20:36:53 +0530")
References: <1303139217-10285-4-git-send-email-charu@ti.com>
Message-ID: <87hb9s4fg0.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Varadarajan, Charulatha" <charu@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Modify the omap_gpio_save/restore_context to support OMAP4
> architecture so that the OMAP GPIO driver need not be modified
> when OMAP4 off mode support is available.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |  131 +++++++++++++++++++++++++++++---------------
>  1 files changed, 86 insertions(+), 45 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 74085b5..e68da08 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -2022,43 +2022,62 @@ void omap2_gpio_resume_after_idle(void)
>  
>  #endif
>  
> -#ifdef CONFIG_ARCH_OMAP3
> -/* save the registers of bank 2-6 */
>  void omap_gpio_save_context(void)
>  {
>  	int i;
>  
> -	/* saving banks from 2-6 only since GPIO1 is in WKUP */

Minor: these comment removals belong in the previous patch.

Kevin
