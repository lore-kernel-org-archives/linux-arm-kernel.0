From: kirill@shutemov.name (Kirill A. Shutemov)
Date: Sat, 12 Sep 2009 17:38:31 +0300
Subject: [PATCH v2 RESEND 1/2] ARM: Introduce ARM_L1_CACHE_SHIFT to define
	cache line size
In-Reply-To: <4AABAE4D.6050909@ru.mvista.com>
References: <1252771155-5828-1-git-send-email-kirill@shutemov.name>
	<a9bd121a726831bc30f4ec04235eda667e602615.1252770642.git.kirill@shutemov.name>
	<4AABA3F7.2050301@ru.mvista.com>
	<cc557aab0909120712j354238c3oe3396591287b5562@mail.gmail.com>
	<4AABAE4D.6050909@ru.mvista.com>
Message-ID: <cc557aab0909120738t725fa53cm9277010e656c8ea4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2009 at 5:21 PM, Sergei Shtylyov
<sshtylyov@ru.mvista.com> wrote:
> Hello.
>
> Kirill A. Shutemov wrote:
>
>>>> Currently kernel believes that all ARM CPUs have L1_CACHE_SHIFT == 5.
>>>> It's not true at least for CPUs based on Cortex-A8.
>>>>
>>>> List of CPUs with cache line size != 32 should be expanded later.
>>>>
>>>> Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
>>>> ---
>>>> ?arch/arm/include/asm/cache.h | ? ?2 +-
>>>> ?arch/arm/mm/Kconfig ? ? ? ? ?| ? ?5 +++++
>>>> ?2 files changed, 6 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/arch/arm/include/asm/cache.h b/arch/arm/include/asm/cache.h
>>>> index feaa75f..2ee7743 100644
>>>> --- a/arch/arm/include/asm/cache.h
>>>> +++ b/arch/arm/include/asm/cache.h
>>>> @@ -4,7 +4,7 @@
>>>> ?#ifndef __ASMARM_CACHE_H
>>>> ?#define __ASMARM_CACHE_H
>>>> ?-#define L1_CACHE_SHIFT ? ? ? ? 5
>>>> +#define L1_CACHE_SHIFT ? ? ? ? (CONFIG_ARM_L1_CACHE_SHIFT)
>>>>
>>>>
>>>
>>> ?Parens not needed.
>>>
>>
>> You can write anything in your .config (like 2+3), so I think parens is
>> needed.
>>
>
> ?You can -- but that won't be an integer option.

But kernel will be still compilable, but broken.

I think parens for defines from .config is a good practice.
