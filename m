From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 1 Mar 2012 20:40:17 +0000
Subject: [PATCH 8/8] ARM: tegra: HACK: remove set_irq_flags() from driver
In-Reply-To: <CACRpkdZK+9gF7N2akyWw=tvcBS2X2FmSd2-SiNKiuRgUCYXx7w@mail.gmail.com>
References: <1330630010-11241-1-git-send-email-alan@signal11.us>
 <1330630010-11241-9-git-send-email-alan@signal11.us>
 <CACRpkdZK+9gF7N2akyWw=tvcBS2X2FmSd2-SiNKiuRgUCYXx7w@mail.gmail.com>
Message-ID: <201203012040.18158.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 March 2012, Linus Walleij wrote:
> The kernel is full of this kind of stuff (drivers/mfd/twl4030-irq.c):
> 
> #ifdef CONFIG_ARM
>         /* ARM requires an extra step to clear IRQ_NOREQUEST, which it
>          * sets on behalf of every irq_chip.  Also sets IRQ_NOPROBE.
>          */
>         set_irq_flags(irq, IRQF_VALID);
> #else
>         /* same effect on other architectures */
>         irq_set_noprobe(irq);
> #endif

That is the implementation of an irq_chip, not a random device driver.

	Arnd
