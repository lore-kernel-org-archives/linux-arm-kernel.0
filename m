From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Oct 2012 10:50:12 +0100
Subject: [PATCH v3 3/4] arm: mvebu: move irq controller driver to
 drivers/irqchip
In-Reply-To: <508E4EB3.5060901@gmail.com>
References: <1351462748-5224-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1351462748-5224-4-git-send-email-thomas.petazzoni@free-electrons.com>
 <508E49E0.8050606@gmail.com> <20121029102436.504d5053@skate>
 <508E4EB3.5060901@gmail.com>
Message-ID: <20121029105012.4fa417e7@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 29 Oct 2012 10:38:59 +0100, Sebastian Hesselbarth wrote:

> > Not really: the driver is probed depending on the DT compatible string.
> > So we can perfectly have two irqchip drivers being enabled on
> > ARCH_MVEBU.
> 
> I agreed but this will always build irq-armada-370-xp into the kernel
> although I maybe want a orion-only kernel. Although multi-platform will
> be great for ARM, I doubt that every kernel will be multi-platform?

Agreed.

> >> As soon as the patch is through, I can provide (and use) a irq-orion
> >> based on irqchip. I can provide it earlier but to actually use it there
> >> are still some other patches required on Dove. Other Orions could
> >> switch now, I guess.
> >
> > Are you sure? The irqchip drivers only work for sub-architecture that
> > are fully converted to the Device Tree. And I don't think all of
> > mach-orion5x, mach-dove, mach-kirkwood and mach-mv78xx0 are converted
> > to the DT.
> 
> Hmm, I do have an experimental branch of Dove with irqchip enabled that
> works perfectly fine even with non-DT code in it. Actually, it is based
> on 3.7-rc3 which means it is before your patches.
> 
> But the irq controller itself is referenced from DT, of course.

Yes, you need at least to probe the irq controller from DT. But neither
mach-orion5x nor mach-mv78xx0 have DT at all, and they need irq-orion.

I am currently in contact with an engineer from LaCie, who has put his
hands on a mach-orion5x platform, I hope to work with him to get DT
support in mach-orion5x.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
