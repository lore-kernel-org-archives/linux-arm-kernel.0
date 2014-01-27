From: hs@denx.de (Heiko Schocher)
Date: Mon, 27 Jan 2014 07:17:18 +0100
Subject: GPIO triggers kernel reboot
In-Reply-To: <371E240E6FC1D44DA5E51EE9DCDCB7845E5EA0E1@NA-MBX-01.mgc.mentorg.com>
References: <52E3E031.6040709@denx.de>
 <371E240E6FC1D44DA5E51EE9DCDCB7845E5EA0A1@NA-MBX-01.mgc.mentorg.com>
 <371E240E6FC1D44DA5E51EE9DCDCB7845E5EA0E1@NA-MBX-01.mgc.mentorg.com>
Message-ID: <52E5F9EE.2020707@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello John,

Am 25.01.2014 21:24, schrieb Mehaffey, John:
>> -----Original Message-----
>> From: linux-embedded-owner at vger.kernel.org
>> [mailto:linux-embedded-owner at vger.kernel.org] On Behalf Of Heiko
>> Schocher
>> Sent: Saturday, January 25, 2014 8:03 AM
>> To: linux-embedded at vger.kernel.org
>> Cc: Wolfgang Denk; linux-arm-kernel at lists.infradead.org
>> Subject: GPIO triggers kernel reboot
>>
>> Hello all,
>>
>> is it possible to reboot current mainline kernel triggered from a GPIO in kernel space?
>>
>> If not, how can be done this, so that it has a chance to go into mainline?
>>
>> Thanks for any suggestions
>>
>> bye,
>> Heiko
>
> Hi Heiko,
> Call kexec() from the GPIO driver.
> It will take some effort to get it right :)

Thanks for your answer!
Hmm.. but has this a chance to go into mainline?

> Or if a simple reboot is all that you want, examine the several reboot APIs in kernel/reboot.c

A current implementation from a customer is for an arm, am335x based board
to add in board setup code:

         ret = request_irq(OMAP_GPIO_IRQ(RESET_BUTTON_IRQ_GPIO)
                 , (irq_handler_t)arm_pm_restart, IRQF_TRIGGER_LOW, "reset button", NULL);

and as I want to bring this board to mainline, I think this is not
an acceptable/good way ... or?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
