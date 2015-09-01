From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 01 Sep 2015 11:07:44 -0700
Subject: Porting MIPS IRQ handler to ARM
In-Reply-To: <55E5E70D.4060006@free.fr>
References: <55E5CED8.7000408@free.fr> <yw1xtwreysnr.fsf@unicorn.mansr.com>
 <55E5E70D.4060006@free.fr>
Message-ID: <55E5E970.90801@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/15 10:57, Mason wrote:
> M?ns Rullg?rd wrote:
> 
>> Mason wrote:
>>
>>> I'm trying to port to my ARM platform: IRQ handling code written for MIPS.
>>> https://github.com/mansr/linux-tangox/blob/master/drivers/irqchip/irq-tangox.c
>>
>> Go get the latest version of that file.  It should work on ARM now.
> 
> It would probably have taken me days to figure out I could just delete
> the arch-dependent code. Linux internals are so hard to grok... <sigh>
> 
> Would you like me to ask if they can send you a dev board? :-)
> 
> By the way, it seems the generic UART driver does not use interrupts,
> which would explain why the console works despite my busted device tree.
> Does that mean that the driver polls? (I'll take a closer look tomorrow.)

Kernel console is buffer and polled, user-space (tty) console uses
interrupts.
-- 
Florian
