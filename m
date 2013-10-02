From: gerlando.falauto@keymile.com (Gerlando Falauto)
Date: Wed, 02 Oct 2013 15:14:28 +0200
Subject: [PATCH 0/1] fix MVEBU GPIO driver bug causing kernel hang
In-Reply-To: <20131002144550.7d28376c@skate>
References: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
 <20131002144550.7d28376c@skate>
Message-ID: <524C1C34.5050403@keymile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 10/02/2013 02:45 PM, Thomas Petazzoni wrote:
> Dear Gerlando Falauto,
>
> On Wed,  2 Oct 2013 14:31:58 +0200, Gerlando Falauto wrote:
>
>> SIDE NOTE: If I understand correctly, a brand new driver from
>> Sebastian Hesselbarth (drivers/irqchip/irq-orion.c) may replace this driver
>> in the future, but it still misses the IRQ_GC_MASK_CACHE_PER_TYPE bit:
>
> Hum? The driver you're touching is a GPIO driver, while
> drivers/irqchip/irq-orion.c is an interrupt controller driver. The
> gpio-mvebu driver can be used on all mvebu platforms that are DT
> capable, but the main interrupt controller is different from one
> platform to another: we already have irq-armada-370-xp.c for Armada
> 370/XP, while Sebastian's irq-orion.c is for older families of SoCs.

My foreword was "if I understand correctly", which I clearly didn't. ;-)

OK, so Sebastian's rework irq-orion.c is about the MAIN interrupt 
controller (replaces arch/arm/plat-orion/irq.c), which also cascades 
interrupts from GPIOs.
These are then either handled by gpio-mvebu.c (for all platforms which 
are DT capable) or by arch/arm/plat-orion/gpio.c (legacy).
Is that right?

> Or maybe I'm missing something?

Sorry, I'm the one missing something here... perhaps too much.

Thanks!
Gerlando
