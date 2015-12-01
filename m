From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Tue, 1 Dec 2015 11:14:02 +0100
Subject: [PATCH] ARM: ep93xx: Fix clocksource registration
In-Reply-To: <CACRpkdZy7TnrmkWrRerjm6dZW9m65Dsc_kp8TPHzbhTxz5Hbrw@mail.gmail.com>
References: <565513EA.6020603@gmail.com>
 <CACRpkdZy7TnrmkWrRerjm6dZW9m65Dsc_kp8TPHzbhTxz5Hbrw@mail.gmail.com>
Message-ID: <565D72EA.9070609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Linus,

On 01/12/15 11:09, Linus Walleij wrote:
>> clocksource_mmio_init() explicitly checks for counter's width and refuses to
>> > register anything with resolution higher than 32 bits. We need to use
>> > clocksource_register_hz() directly to repair HIGH_RES_TIMERS.
> Maybe tglx want to jump in on this.
> 
> Isn't it better to fix clocksource_mmio_init() to accept > 32 bits?
> 
> What is really prompting this in drivers/clocksource/mmio.c:
> 
> if (bits > 32 || bits < 16)
>                 return -EINVAL;

probably lack of >32bit access functions in the driver. But I do not know
the original intentions of the author. In any case, if we modify the check here,
probably the access function for 64 bits should be moved to the mmio.c?

Alex.
