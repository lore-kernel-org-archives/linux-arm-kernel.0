From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 02 Dec 2011 09:24:38 +0000
Subject: [PATCH 1/2] ARM: exynos4: Fix build error due to 'gic_bank_offset'
 undeclared
In-Reply-To: <04f701ccb0ce$7c044d30$740ce790$%kim@samsung.com>
References: <1322753070.11611.0.camel@phoenix> <4ED7ADCE.8040609@arm.com>
 <04f701ccb0ce$7c044d30$740ce790$%kim@samsung.com>
Message-ID: <4ED89956.9060908@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/11 08:43, Kukjin Kim wrote:
> Marc Zyngier wrote:
>>
>> On 01/12/11 15:24, Axel Lin wrote:
>>> Fix below build error:
>>>   CC      arch/arm/mach-exynos/cpu.o
>>> arch/arm/mach-exynos/cpu.c: In function 'exynos4_init_irq':
>>> arch/arm/mach-exynos/cpu.c:245: error: 'gic_bank_offset' undeclared
>> (first use in this function)
>>> arch/arm/mach-exynos/cpu.c:245: error: (Each undeclared identifier is
>> reported only once
>>> arch/arm/mach-exynos/cpu.c:245: error: for each function it appears in.)
>>> arch/arm/mach-exynos/cpu.c:243: warning: unused variable 'bank_offset'
>>> make[1]: *** [arch/arm/mach-exynos/cpu.o] Error 1
>>> make: *** [arch/arm/mach-exynos] Error 2
>>>
>>> Signed-off-by: Axel Lin <axel.lin@gmail.com>
>>
>> Arghhh... My bad. Thanks for fixing that.
>>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
> Hi Marc,
> 
> Since the commit 4e44d2cb("ARM: exynos4: convert to CONFIG_MULTI_IRQ_HANDLER") is not in my tree, this should be handled in your tree and Axel's patch, "ARM: exynos4: Fix build error" is too.

Hi Kukjin,

No problem, I'll take these through my tree and send a pull request to
Russell.

Cheers,

	M.
-- 
Jazz is not dead. It just smells funny...
