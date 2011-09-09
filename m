From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 9 Sep 2011 14:54:58 +0200
Subject: [PATCH 12/25] OMAP: Add support to allocate the memory for secure
	RAM
In-Reply-To: <4E69DFBB.9020803@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
	<1315144466-9395-13-git-send-email-santosh.shilimkar@ti.com>
	<CAORVsuV8+zMzwT+PeWTo6TgWeEYfcSQdjY_kv4FcURohVoT=hw@mail.gmail.com>
	<4E69DFBB.9020803@ti.com>
Message-ID: <CAORVsuWNgXqmpuir7kpRHf5T7-o2DE8OSkwR1Evfo3=wKgiTUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Santosh,

On Fri, Sep 9, 2011 at 11:43 AM, Santosh <santosh.shilimkar@ti.com> wrote:
> On Friday 09 September 2011 12:49 AM, Jean Pihet wrote:
>>
>> On Sun, Sep 4, 2011 at 3:54 PM, Santosh Shilimkar
>> <santosh.shilimkar@ti.com> ?wrote:
>>>
>>> Allocate the memory to save secure ram context which needs
>>> to be done when MPU is hitting off mode.
>>>
>>> The ROM code expects a physical address to this memory
>>> and hence use memblock APIs to reserve this memory as part
>>> of .reserve() callback.
>>>
>>> Maximum possible size is allocated and can cater to OMAP3XXX / OMAP4XXX
>>> secure RAM size requirements.
>>>
>>> Signed-off-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
>>> ---
>>> ?arch/arm/mach-omap2/include/mach/omap-secure.h | ? ?4 +++
>>> ?arch/arm/mach-omap2/omap-secure.c ? ? ? ? ? ? ?| ? 29
>>> ++++++++++++++++++++++++
>>> ?arch/arm/plat-omap/common.c ? ? ? ? ? ? ? ? ? ?| ? ?3 ++
>>> ?3 files changed, 36 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/include/mach/omap-secure.h
>>> b/arch/arm/mach-omap2/include/mach/omap-secure.h
>>> index 26e7bcc..e2f95a0 100644
>>> --- a/arch/arm/mach-omap2/include/mach/omap-secure.h
>>> +++ b/arch/arm/mach-omap2/include/mach/omap-secure.h
>>> @@ -26,6 +26,8 @@
>>> ?#define FLAG_FIQ_ENABLE ? ? ? ? ? ? ? ? ? ? ? ?0x1
>>> ?#define NO_FLAG ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?0x0
>>>
>>> +/* Maximum Secure memory storage size */
>>> +#define OMAP_SECURE_RAM_STORAGE ? ? ? ?(88 * SZ_1K)
>>
>> Is this valid for all supported devices? How to differentiate
>> variations in the size for new chips variants in the future?
>>
> You don't have to. ROM code does that job. We should just ensure
> that maximum needed memory is made available to secure code.
The question was: what would be the code if tomorrow -for example- we
have OMAP4460 with 88K of secure RAM, OMAP5432 with 128K and OMAP6667
with 132K? How to code the differences?

Regards,
Jean

>
> Regards
> Santosh
>
