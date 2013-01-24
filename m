From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu, 24 Jan 2013 22:14:37 +0100
Subject: [PATCH 1/2] ARM: dts: omap3-overo: Add support for pwm-leds
In-Reply-To: <51016A84.20703@ti.com>
References: <1358963812-19947-1-git-send-email-florian.vaussard@epfl.ch>
 <1358963812-19947-2-git-send-email-florian.vaussard@epfl.ch>
 <5101510C.9050407@ti.com> <51015663.8080109@epfl.ch>
 <5101570A.1030303@ti.com> <5101663C.7020301@epfl.ch> <51016A84.20703@ti.com>
Message-ID: <5101A43D.7080108@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

>>
>>>> I am working on a patch for pwm-twl-led to defer using a workqueue right now.
>>>
>>> Great!
>>> The only thing I worry about is the latency we are going to get with the
>>> workqueue.
>>>
>>
>> If the latency becomes critical, we can create our own workqueue.
>
> Hrm, when we handled the led via gpio-leds it was also going through the same
> path at the end, via i2c to twl4030.
> I think the fix for this is going to be needed in the pwm core level. Just
> need to look at the gpio code to have similar handling of might_sleep interfaces.
>

You are right. But then the pwm core must provide a way to know if the 
pwm access function are callable
from atomic context or not (the gpio framework provides gpio_cansleep()).
This implies a good amount of changes to the pwm framework, and 
currently we are the only driver using
non-atomic access.

I will take a closer look to the complexity of this solution tomorrow.

Florian
