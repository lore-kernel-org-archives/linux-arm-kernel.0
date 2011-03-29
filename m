From: srinidhikasagar@gmail.com (Srinidhi Kasagar)
Date: Tue, 29 Mar 2011 11:05:02 +0530
Subject: [patch 06/29] arm: nomadik: Remove non existing cpu id check
In-Reply-To: <20110328170651.389834600@linutronix.de>
References: <20110328170219.059141076@linutronix.de>
	<20110328170651.389834600@linutronix.de>
Message-ID: <AANLkTik+j6KhYDpMdjU55uMpJZSBOs0RU0Pck2Pmoeyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 10:42 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> ?arch/arm/plat-nomadik/gpio.c | ? ?7 -------
> ?1 file changed, 7 deletions(-)
>
> Index: linux-2.6-tip/arch/arm/plat-nomadik/gpio.c
> ===================================================================
> --- linux-2.6-tip.orig/arch/arm/plat-nomadik/gpio.c
> +++ linux-2.6-tip/arch/arm/plat-nomadik/gpio.c
> @@ -541,13 +541,6 @@ static void __nmk_gpio_irq_modify(struct
> ?static void __nmk_gpio_set_wake(struct nmk_gpio_chip *nmk_chip,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?int gpio, bool on)
> ?{
> -#ifdef CONFIG_ARCH_U8500

This architecture does exist.

> - ? ? ? if (cpu_is_u8500v2()) {
> - ? ? ? ? ? ? ? __nmk_gpio_set_slpm(nmk_chip, gpio - nmk_chip->chip.base,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? on ? NMK_GPIO_SLPM_WAKEUP_ENABLE
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?: NMK_GPIO_SLPM_WAKEUP_DISABLE);
> - ? ? ? }
> -#endif
> ? ? ? ?__nmk_gpio_irq_modify(nmk_chip, gpio, WAKE, on);
> ?}
>

srinidhi
