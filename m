From: gang.chen.5i5j@gmail.com (Chen Gang)
Date: Sat, 23 Aug 2014 10:31:15 +0800
Subject: [PATCH v2] arch: Kconfig: Let all little endian architectures
 define CPU_LITTLE_ENDIAN explicitly
In-Reply-To: <53F724DD.1080605@suse.cz>
References: <53EA99C3.90203@gmail.com>
 <CAMuHMdV_2b-A+eE--cXEFA68=72HK6mqx8+TCXRMVkyhESLYxQ@mail.gmail.com>
 <53F724DD.1080605@suse.cz>
Message-ID: <53F7FCF3.4000800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/22/14 19:09, Michal Marek wrote:
> Dne 13.8.2014 10:03, Geert Uytterhoeven napsal(a):
>> CC kbuild
>>
>> On Wed, Aug 13, 2014 at 12:48 AM, Chen Gang <gang.chen.5i5j@gmail.com> wrote:
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>>> index c49a775..0510a5d 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -199,6 +199,11 @@ config NEED_DMA_MAP_STATE
>>>  config ARCH_SUPPORTS_UPROBES
>>>         def_bool y
>>>
>>> +config CPU_LITTLE_ENDIAN
>>> +       depends on !CPU_BIG_ENDIAN
>>> +       def_bool y
>>> +
>>> +
>>>  config ARCH_HAS_DMA_SET_COHERENT_MASK
>>>         bool
>>
>> As this is a common symbol, and replicated for all affected architectures,
>> I'm wondering if we should have the "config CPU_LITTLE_ENDIAN" in
>> common Kconfig code instead, and make the individual architectures do a
>> "select CPU_LITTLE_ENDIAN"?
> 
> Yes!
> 
> 
>> Also we could have "config CPU_BIG_ENDIAN", too, and error out
>> if none or both are selected (can Kconfig error out?).
> 
> We can error out in the Makefile, if there is consensus that we should
> be doing so.
> 

OK, thanks. I have sent patch v3 for it, and did not check related error
in Kconfig files.

Please check the related patches (excuse me, I send the patch v3 only
according to "scripts/maintainers.pl", maybe not cc to you explicitly).


Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
