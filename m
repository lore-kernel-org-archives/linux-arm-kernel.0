From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 21 Jan 2013 10:30:47 -0800
Subject: [PATCH] ARM: architected timers: allow dt based discovery using
 clocksource_of_init
In-Reply-To: <50FD7904.1070201@wwwdotorg.org>
References: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
 <50FD7904.1070201@wwwdotorg.org>
Message-ID: <CAJuYYwSfH8jTterd6aNc_Aw81PBschfCUf=REKB35=Y4a=i_7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 21 January 2013 09:21, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/20/2013 06:22 PM, Thomas Abraham wrote:
>> Add an entry in __clksrc_of_table so that ARMv7 architected timer is
>> discoverable using call to clocksource_of_init.
>
>> diff --git a/arch/arm/kernel/arch_timer.c b/arch/arm/kernel/arch_timer.c
>
>> +#ifdef CONFIG_CLKSRC_OF
>> +CLOCKSOURCE_OF_DECLARE(armv7_timer, "arm,armv7-timer", arch_timer_of_register)
>> +#endif
>
> I wonder if we shouldn't enhance include/linux/clocksource.h to define
> CLOCKSOURCE_OF_DECLARE even when !CONFIG_CLKSRC_OF; that way, drivers
> wouldn't need that ifdef.

Yes, it will be helpful to have a !CONFIG_CLKSRC_OF version of
CLOCKSOURCE_OF_DECLARE. And can CONFIG_CLKSRC_OF be enabled by default
for all ARM platforms?

Thanks,
Thomas.
