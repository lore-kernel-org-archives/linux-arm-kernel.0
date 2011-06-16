From: philip@balister.org (Philip Balister)
Date: Wed, 15 Jun 2011 17:48:12 -0700
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory	Allocator
	added
In-Reply-To: <201106150937.18524.arnd@arndb.de>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>	<201106142030.07549.arnd@arndb.de>	<000501cc2b2b$789a54b0$69cefe10$%szyprowski@samsung.com>
	<201106150937.18524.arnd@arndb.de>
Message-ID: <4DF952CC.4010301@balister.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/15/2011 12:37 AM, Arnd Bergmann wrote:
> On Wednesday 15 June 2011 09:11:39 Marek Szyprowski wrote:
>> I see your concerns, but I really wonder how to determine the properties
>> of the global/default cma pool. You definitely don't want to give all
>> available memory o CMA, because it will have negative impact on kernel
>> operation (kernel really needs to allocate unmovable pages from time to
>> time).
>
> Exactly. This is a hard problem, so I would prefer to see a solution for
> coming up with reasonable defaults.

Is this a situation where passing the information from device tree might 
help? I know this does not help short term, but I am trying to 
understand the sorts of problems device tree can help solve.

Philip

>
>> The only solution I see now is to provide Kconfig entry to determine
>> the size of the global CMA pool, but this still have some issues,
>> especially for multi-board kernels (each board probably will have
>> different amount of RAM and different memory-consuming devices
>> available). It looks that each board startup code still might need to
>> tweak the size of CMA pool. I can add a kernel command line option for
>> it, but such solution also will not solve all the cases (afair there
>> was a discussion about kernel command line parameters for memory
>> configuration and the conclusion was that it should be avoided).
>
> The command line option can be a last resort if the heuristics fail,
> but it's not much better than a fixed Kconfig setting.
>
> How about a Kconfig option that defines the percentage of memory
> to set aside for contiguous allocations?
>
> 	Arnd
>
> _______________________________________________
> Linaro-mm-sig mailing list
> Linaro-mm-sig at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-mm-sig
>
