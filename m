From: rdunlap@infradead.org (Randy Dunlap)
Date: Tue, 03 Mar 2015 09:46:41 -0800
Subject: [RFC PATCH 1/4] mm: move memtest under /mm
In-Reply-To: <54F57D4C.9010909@arm.com>
References: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
 <1425308145-20769-2-git-send-email-vladimir.murzin@arm.com>
 <54F513C0.4000706@infradead.org> <54F57D4C.9010909@arm.com>
Message-ID: <54F5F381.30104@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/03/15 01:22, Vladimir Murzin wrote:
> On 03/03/15 01:52, Randy Dunlap wrote:
>> On 03/02/15 06:55, Vladimir Murzin wrote:
>>> There is nothing platform dependent in the core memtest code, so other platform
>>> might benefit of this feature too.
>>>
>>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>>> ---
>>>  arch/x86/Kconfig            |   11 ----
>>>  arch/x86/include/asm/e820.h |    8 ---
>>>  arch/x86/mm/Makefile        |    2 -
>>>  arch/x86/mm/memtest.c       |  118 -------------------------------------------
>>>  include/linux/memblock.h    |    8 +++
>>>  lib/Kconfig.debug           |   11 ++++
>>>  mm/Makefile                 |    1 +
>>>  mm/memtest.c                |  118 +++++++++++++++++++++++++++++++++++++++++++
>>>  8 files changed, 138 insertions(+), 139 deletions(-)
>>>  delete mode 100644 arch/x86/mm/memtest.c
>>>  create mode 100644 mm/memtest.c
>>
>>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>>> index c5cefb3..8eb064fd 100644
>>> --- a/lib/Kconfig.debug
>>> +++ b/lib/Kconfig.debug
>>> @@ -1732,6 +1732,17 @@ config TEST_UDELAY
>>>  
>>>  	  If unsure, say N.
>>>  
>>> +config MEMTEST
>>> +	bool "Memtest"
>>> +	---help---
>>> +	  This option adds a kernel parameter 'memtest', which allows memtest
>>> +	  to be set.
>>> +	        memtest=0, mean disabled; -- default
>>> +	        memtest=1, mean do 1 test pattern;
>>> +	        ...
>>> +	        memtest=4, mean do 4 test patterns.
>>
>> This sort of implies a max of 4 test patterns, but it seems to be 17
>> if I counted correctly, so if someone wants to test all of the possible
>> 'memtest' patterns, they would need to use 'memtest=17', is that correct?
>>
> 
> Yes, that correct. Additional patterns were introduced since 63823126
> "x86: memtest: add additional (regular) test patterns", but looks like
> Kconfig was not updated that time. Do you want me to fold updates for
> that info or make a separate patch?

Either is OK with me but it probably should be a separate patch.

Thanks.
-- 
~Randy
