From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 22 Jan 2013 17:34:30 +0100
Subject: [PATCH 3/6] arm: kconfig: don't select TWD with local timer for
 Armada 370/XP
In-Reply-To: <201301221557.02976.arnd@arndb.de>
References: <1358790842-2986-1-git-send-email-gregory.clement@free-electrons.com>
 <201301211831.45947.arnd@arndb.de> <50FDC322.2040107@free-electrons.com>
 <201301221557.02976.arnd@arndb.de>
Message-ID: <50FEBF96.6020001@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/22/2013 04:57 PM, Arnd Bergmann wrote:
> On Monday 21 January 2013, Gregory CLEMENT wrote:
>> I don't see a strong reason to not enable it if we don't use it. My concern
>> was that I don't need it so I didn't want to include it and generating extra
>> code for nothing. Then just after having sent this patch set, I received your
>> patch set about build regression in 3.8 and especially the part about
>> CONFIG_MULTIPLATFORM made me realized that it could be a problem.
> 
> Ok.
> 
>>> Maybe it can be written as
>>>
>>> config LOCAL_TIMERS
>>>       bool "Use local timer interrupts"
>>>       depends on SMP
>>>       default y
>>>
>>> config HAVE_ARM_TWD
>>>       depends on LOCAL_TIMERS
>>>       default ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT)
>>
>> So in this case why not written something like this:
>>         default ARCH_MULTIPLATFORM || (!ARCH_MSM_SCORPIONMP && !EXYNOS4_MCT && !ARMADA_370_XP_TIMER)
> 
> That does not change anything, because ARMADA_370_XP_TIMER is only ever enabled
> when ARCH_MULTIPLATFORM is enabled as well.

Yes you're right.

So I remove this patch of my series as I don't need it anymore for supporting local
timer on Armada XP/370.

And I will submit this patch as a standalone one.

> 
>>>       default y
>> I am not a kconfig expert, but won't this line set HAVE_ARM_TWD to 'y' whatever
>> the result of the previous line?
> 
> Yes, that was a mistake on my side.
> 
> 	Arnd
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
