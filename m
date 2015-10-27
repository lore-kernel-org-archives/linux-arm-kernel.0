From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 27 Oct 2015 22:33:01 +0100
Subject: v7-M: Fixing XIP when the kernel is in ROM
In-Reply-To: <85aea33b93066d0959d98b56f8787ba3@agner.ch>
References: <20151026012710.GA17365@laptop>
 <20151026080537.GW4931@pengutronix.de>
 <CAAEAJfB0yywtQ2MrYf2ih5+a3fZJXAy0hFSXWA038wQMQswa7g@mail.gmail.com>
 <CAAEAJfD29_PSTw+srx7d2YrF+Akx-_94Wv9ifKzT+8HTfH5tGA@mail.gmail.com>
 <562FA053.6010208@st.com>
 <CALszF6C4B-S-o3E1OHK3+bKpDQ8a64Ly-ABNQwfSfj95y7qFyA@mail.gmail.com>
 <85aea33b93066d0959d98b56f8787ba3@agner.ch>
Message-ID: <CALszF6Di3LWLu_W67Zdn2LyKKRF_5U241eKFKMmJ-0s+0boFag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-10-27 21:33 GMT+01:00 Stefan Agner <stefan@agner.ch>:
> On 2015-10-27 13:25, Maxime Coquelin wrote:
>> 2015-10-27 17:03 GMT+01:00 Maxime Coquelin <maxime.coquelin@st.com>:
>>> Hi Ezequiel,
>>>
>>> On 10/27/2015 04:35 PM, Ezequiel Garcia wrote:
>>>>>
>>>>> >>>The temporary stack is allocated in the .text.init section
>>>>> >>>and so this doesn't work when the kernel is executing from ROM.
>>>>
>>>> >>
>>>> >>If sp isn't used, how does it break you setup?
>>>
>>> STM32 machine works fine with XIP from internal flash memory, so as Uwe, I'm
>>> surprised it solves your problem.
>>>
>>> I will have a try with your patch later today.
>>
>> Just tested, and confirm it works with (and without) your patch in XIP on STM32.
>
> It probably depends what exactly happens when the CPU core tries to use
> the stack. I mean, the CPU core will issue a write to the flash, and how
> that behaves is probably implementation specific. However, I would
> expect that it should lead to some kind of fault... Do we have fault
> handlers at that time?

Yes we have fault handlers at that time.
I agree the behaviour is probably implementation specific.

>
> Anyway, I guess Ezequiel's fix is the right thing to do...
Or, maybe we should put the stack in RAM as Uwe suggest?

Regards,
Maxime
