From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 21 Jan 2013 19:25:55 +0100
Subject: [PATCH] ARM: architected timers: allow dt based discovery using
 =?UTF-8?Q?clocksource=5Fof=5Finit?=
In-Reply-To: <50FD7904.1070201@wwwdotorg.org>
References: <1358731326-2979-1-git-send-email-thomas.abraham@linaro.org>
 <50FD7904.1070201@wwwdotorg.org>
Message-ID: <ef8b986a3b0a2c3fae230c8d7416d42d@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jan 2013 10:21:08 -0700, Stephen Warren <swarren@wwwdotorg.org>
wrote:
> On 01/20/2013 06:22 PM, Thomas Abraham wrote:
>> Add an entry in __clksrc_of_table so that ARMv7 architected timer is
>> discoverable using call to clocksource_of_init.
> 
>> diff --git a/arch/arm/kernel/arch_timer.c
b/arch/arm/kernel/arch_timer.c
> 
>> +#ifdef CONFIG_CLKSRC_OF
>> +CLOCKSOURCE_OF_DECLARE(armv7_timer, "arm,armv7-timer",
>> arch_timer_of_register)
>> +#endif
> 
> I wonder if we shouldn't enhance include/linux/clocksource.h to define
> CLOCKSOURCE_OF_DECLARE even when !CONFIG_CLKSRC_OF; that way, drivers
> wouldn't need that ifdef.

Indeed. That would be a lot nicer.

        M.
-- 
Fast, cheap, reliable. Pick two.
