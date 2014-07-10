From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 17:59:47 +0400
Subject: [RFC/PATCH RESEND -next 00/21] Address sanitizer for kernel
 (kasan) - dynamic memory error detector.
In-Reply-To: <CAOMGZ=Fmqg6MWyx3NygqVmYiqw=npkPQrO9ifhF489bq5Gxz4A@mail.gmail.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <53BDB1D6.1090605@intel.com> <8761j6nr53.fsf@tassilo.jf.intel.com>
 <CAOMGZ=Fmqg6MWyx3NygqVmYiqw=npkPQrO9ifhF489bq5Gxz4A@mail.gmail.com>
Message-ID: <53BE9C53.5090301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/14 01:59, Vegard Nossum wrote:
> On 9 July 2014 23:44, Andi Kleen <andi@firstfloor.org> wrote:
>> Dave Hansen <dave.hansen@intel.com> writes:
>>>
>>> You're also claiming that "KASAN is better than all of
>>
>> better as in finding more bugs, but surely not better as in
>> "do so with less overhead"
>>
>>> CONFIG_DEBUG_PAGEALLOC".  So should we just disallow (or hide)
>>> DEBUG_PAGEALLOC on kernels where KASAN is available?
>>
>> I don't think DEBUG_PAGEALLOC/SLUB debug and kasan really conflict.
>>
>> DEBUG_PAGEALLOC/SLUB is "much lower overhead but less bugs found".
>> KASAN is "slow but thorough" There are niches for both.
>>
>> But I could see KASAN eventually deprecating kmemcheck, which
>> is just incredible slow.
> 
> FWIW, I definitely agree with this -- if KASAN can do everything that
> kmemcheck can, it is no doubt the right way forward.
> 

AFAIK kmemcheck could catch reads of uninitialized memory.
KASAN can't do it now, but It should be possible to implementation.
There is such tool for userspace - https://code.google.com/p/memory-sanitizer/wiki/MemorySanitizer

However detection of reads of uninitialized  memory will require a different
shadow encoding. Therefore I think it would be better to make it as a separate feature, incompatible with kasan.



> 
> Vegard
> 
