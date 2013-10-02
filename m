From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 2 Oct 2013 15:48:21 +0200
Subject: [PATCH 0/1] fix MVEBU GPIO driver bug causing kernel hang
In-Reply-To: <524C1C34.5050403@keymile.com>
References: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
 <20131002144550.7d28376c@skate> <524C1C34.5050403@keymile.com>
Message-ID: <20131002154821.385e0921@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerlando Falauto,

On Wed, 02 Oct 2013 15:14:28 +0200, Gerlando Falauto wrote:

> > Hum? The driver you're touching is a GPIO driver, while
> > drivers/irqchip/irq-orion.c is an interrupt controller driver. The
> > gpio-mvebu driver can be used on all mvebu platforms that are DT
> > capable, but the main interrupt controller is different from one
> > platform to another: we already have irq-armada-370-xp.c for Armada
> > 370/XP, while Sebastian's irq-orion.c is for older families of SoCs.
> 
> My foreword was "if I understand correctly", which I clearly didn't. ;-)
> 
> OK, so Sebastian's rework irq-orion.c is about the MAIN interrupt 
> controller (replaces arch/arm/plat-orion/irq.c), which also cascades 
> interrupts from GPIOs.
> These are then either handled by gpio-mvebu.c (for all platforms which 
> are DT capable) or by arch/arm/plat-orion/gpio.c (legacy).
> Is that right?

Yes, that's right.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
