From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 2 Oct 2013 14:45:50 +0200
Subject: [PATCH 0/1] fix MVEBU GPIO driver bug causing kernel hang
In-Reply-To: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
References: <1380717118-10860-1-git-send-email-gerlando.falauto@keymile.com>
Message-ID: <20131002144550.7d28376c@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gerlando Falauto,

On Wed,  2 Oct 2013 14:31:58 +0200, Gerlando Falauto wrote:

> SIDE NOTE: If I understand correctly, a brand new driver from
> Sebastian Hesselbarth (drivers/irqchip/irq-orion.c) may replace this driver
> in the future, but it still misses the IRQ_GC_MASK_CACHE_PER_TYPE bit:

Hum? The driver you're touching is a GPIO driver, while
drivers/irqchip/irq-orion.c is an interrupt controller driver. The
gpio-mvebu driver can be used on all mvebu platforms that are DT
capable, but the main interrupt controller is different from one
platform to another: we already have irq-armada-370-xp.c for Armada
370/XP, while Sebastian's irq-orion.c is for older families of SoCs.

Or maybe I'm missing something?

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
