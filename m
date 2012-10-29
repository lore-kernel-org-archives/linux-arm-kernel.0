From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Oct 2012 10:24:36 +0100
Subject: [PATCH v3 3/4] arm: mvebu: move irq controller driver to
 drivers/irqchip
In-Reply-To: <508E49E0.8050606@gmail.com>
References: <1351462748-5224-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351462748-5224-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <508E49E0.8050606@gmail.com>
Message-ID: <20121029102436.504d5053@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Mon, 29 Oct 2012 10:18:24 +0100, Sebastian Hesselbarth wrote:

> using ARCH_MVEBU for enabling irq-armada-370-xp here will lead to
> incompatibilities with Orion SoCs when they move over to ARCH_MVEBU.

Not really: the driver is probed depending on the DT compatible string.
So we can perfectly have two irqchip drivers being enabled on
ARCH_MVEBU.

> Although, it is ok for the moment please choose either a CONFIG_
> common for both Armada 370 and XP.
> 
> With a Kconfig within drivers/irqchip you could define a
> ARMADA_370_XP_IRQ and select that in MACH_ARMADA_370 and MACH_ARMADA_XP
> or MACH_ARMADA_370_XP, which all already exist.

But agreed, I could use MACH_ARMADA_370_XP. I don't know if we want to
add Kconfig options for each irqchip driver.

> As soon as the patch is through, I can provide (and use) a irq-orion
> based on irqchip. I can provide it earlier but to actually use it there
> are still some other patches required on Dove. Other Orions could
> switch now, I guess.

Are you sure? The irqchip drivers only work for sub-architecture that
are fully converted to the Device Tree. And I don't think all of
mach-orion5x, mach-dove, mach-kirkwood and mach-mv78xx0 are converted
to the DT.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
