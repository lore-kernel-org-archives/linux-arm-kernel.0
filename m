From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Dec 2015 18:23:41 +0100
Subject: [PATCH] ARM: ep93xx: Fix clocksource registration
In-Reply-To: <565D72EA.9070609@gmail.com>
References: <565513EA.6020603@gmail.com>
 <CACRpkdZy7TnrmkWrRerjm6dZW9m65Dsc_kp8TPHzbhTxz5Hbrw@mail.gmail.com>
 <565D72EA.9070609@gmail.com>
Message-ID: <CACRpkdbn=EXFpCof6O4uP94N3yi3qTHsasRMzu3-zuneDJAaMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 1, 2015 at 11:14 AM, Alexander Sverdlin
<alexander.sverdlin@gmail.com> wrote:
> On 01/12/15 11:09, Linus Walleij wrote:
>>> clocksource_mmio_init() explicitly checks for counter's width and refuses to
>>> > register anything with resolution higher than 32 bits. We need to use
>>> > clocksource_register_hz() directly to repair HIGH_RES_TIMERS.
>> Maybe tglx want to jump in on this.
>>
>> Isn't it better to fix clocksource_mmio_init() to accept > 32 bits?
>>
>> What is really prompting this in drivers/clocksource/mmio.c:
>>
>> if (bits > 32 || bits < 16)
>>                 return -EINVAL;
>
> probably lack of >32bit access functions in the driver. But I do not know
> the original intentions of the author. In any case, if we modify the check here,
> probably the access function for 64 bits should be moved to the mmio.c?

The clocksource returns a cycle_t which is 64 bits. I have sent a proper
patch to Daniel+tglx fixing it up.

Yours,
Linus Walleij
