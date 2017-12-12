From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 12 Dec 2017 21:27:34 +0100
Subject: [PATCH] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
In-Reply-To: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk> (Russell King's
 message of "Mon, 11 Dec 2017 18:56:35 +0000")
References: <E1eOTFj-0008MB-Fj@rmk-PC.armlinux.org.uk>
Message-ID: <874lovg095.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@armlinux.org.uk> writes:

> Add a gpio driver for the lubbock miscellaneous write IO register so we
> can take advantage of subsystems modelled around gpiolib, rather than
> having to provide platform specific callbacks.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Hi Russell and Linux,

It looks certainly good to me. It's unfortunate in the current status of
linux-next I have, gpio-reg.c seems broken (that one is for Linus in [1] and
[2]), and therefore I can't test it live.

Nonetheless, do you want me to carry it through the pxa tree or do you want to
keep it through your tree ?

Cheers.

-- 
Robert

[1] For Linus if he wasn't notified before :
---8>---
  CC      drivers/gpio/gpio-reg.o
drivers/gpio/gpio-reg.c: In function 'gpio_reg_to_irq':
drivers/gpio/gpio-reg.c:106:19: error: 'struct gpio_reg' has no member named 'irq'
  if (irq >= 0 && r->irq.domain)
                   ^
drivers/gpio/gpio-reg.c:107:27: error: 'struct gpio_reg' has no member named 'irq'
   irq = irq_find_mapping(r->irq.domain, irq);
                           ^
make[2]: *** [drivers/gpio/gpio-reg.o] Erreur 1
---8>---

[2] For Linux, git commit of my linux-next tip
d20787938ddb ("Add linux-next specific files for 20171212")
