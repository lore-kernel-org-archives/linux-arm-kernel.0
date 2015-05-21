From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Thu, 21 May 2015 19:58:28 +0200
Subject: [PATCH v8 07/16] drivers: reset: Add STM32 reset driver
In-Reply-To: <CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
References: <1431158038-3813-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1431158038-3813-8-git-send-email-mcoquelin.stm32@gmail.com>
 <555D1C7D.1060205@suse.de>
 <CALszF6CrouFF3oS_Qz6+qQRqa4a5PurdYNdvHnZRDb4zwOJ6mQ@mail.gmail.com>
Message-ID: <555E1CC4.9090605@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 21.05.2015 um 09:46 schrieb Maxime Coquelin:
> 2015-05-21 1:45 GMT+02:00 Andreas F?rber <afaerber@suse.de>:
>> Am 09.05.2015 um 09:53 schrieb Maxime Coquelin:
>>> +static const struct of_device_id stm32_reset_dt_ids[] = {
>>> +      { .compatible = "st,stm32-rcc", },
>>> +      { /* sentinel */ },
>>> +};
>>> +MODULE_DEVICE_TABLE(of, sstm32_reset_dt_ids);
>>
>> Typo.
> 
> Indeed, thanks for pointing this out.
> 
>>
>> IIUC the timer depends on the reset controller, so it must be built in
>> anyway, and that's what's enforced in the Makefile above. Drop the line?
>>
> 
> Agree it must be built-in.
> I will fix that in next version.

Actually, I've updated a timer implementation of mine to invoke a reset
controller similar to how you do in the STM32 clocksource patch, but no
reset controller is getting returned.

It seems to me, you are working around that by simply ignoring the error
in the timer code and not doing a reset then, so the STM32 timer does in
fact _not_ depend on the reset controller? What happened to your efforts
of making the reset controller usable for the timer? In my case, my
timer is originally in reset state and needs to be deasserted, so I
can't just ignore it.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Dilip Upmanyu, Graham Norton; HRB
21284 (AG N?rnberg)
