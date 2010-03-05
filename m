From: albin.tonnerre@gmail.com (Albin Tonnerre)
Date: Fri, 5 Mar 2010 11:37:32 +0100
Subject: [PATCH] ARM: Add Versatile Express support
In-Reply-To: <20100305102953.GA4885@n2100.arm.linux.org.uk>
References: <git-1267729916-9e7380877e37e33ffe507b0299aa4c6e9cac599e@rmk-PC>
	<git-1267729916-61c9b6ab773870de77ff9183b8bb055a03b19671@rmk-PC>
	<bbb699fe1003050227k7583de6w8232ddac44d04d8d@mail.gmail.com>
	<20100305102953.GA4885@n2100.arm.linux.org.uk>
Message-ID: <bbb699fe1003050237t2f9fa68ckdb72e4ea67fba83@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 5, 2010 at 11:29 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 05, 2010 at 11:27:13AM +0100, Albin Tonnerre wrote:
>> Hi Russell,
>>
>> > +config ARCH_VEXPRESS
>> > + ? ? ? bool "ARM Ltd. Versatile Express family"
>> > + ? ? ? select ARCH_WANT_OPTIONAL_GPIOLIB
>> > + ? ? ? select ARM_AMBA
>> > + ? ? ? select ARM_TIMER_SP804
>>
>> You need platform.h, as it's used in arch/arm/plat-versatile/timer-sp.c
>> Unless I'm mistaken, it's missing from this patchset.
>>
>> Otherwise, Tested-By: Albin Tonnerre <albin.tonnerre@gmail.com>
>
> Builds fine for me. ?timer-sp.c does not include platform.h

My fault, I overlooked the fact that 'ARM: Realview/Versatile: don't use
magic numbers for timer frequency' removes this particular include.

Regards,
Albin
