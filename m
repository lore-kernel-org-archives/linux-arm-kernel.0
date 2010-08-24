From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 24 Aug 2010 10:19:11 +0200
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <30193.50267.qm@web180305.mail.gq1.yahoo.com>
References: <30193.50267.qm@web180305.mail.gq1.yahoo.com>
Message-ID: <4C73807F.4090007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 23/08/2010 18:36, David Brownell :
> 
> 
> --- On Mon, 8/23/10, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> 
>> From: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Subject: [PATCH] pio: add arch specific gpio_is_valid() function
> 
> What's the rationale?  It's valid or not.  And there's already a
> function whose job it is to report that status ... which is set up
> for arch customization.

How do you customize it? I would like to keep the benefit of gpiolib
implementation.
In arch/arm/mach-at91/include/mach/gpio.h we include the
asm-generic/gpio.h. That is why I protect the generic code with
__HAVE_ARCH_GPIO_IS_VALID.

With this, we can keep the benefit of having an inline function.

>  Which ISTR worked fine for AT91 (among other
> platforms) ...

Well the standard function:
return ((unsigned)number) < ARCH_NR_GPIOS;
is not suitable for AT91 as said in the thread.

Best regards,
-- 
Nicolas Ferre
