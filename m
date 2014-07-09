From: vegard.nossum@gmail.com (Vegard Nossum)
Date: Wed, 9 Jul 2014 23:59:01 +0200
Subject: [RFC/PATCH RESEND -next 00/21] Address sanitizer for kernel
 (kasan) - dynamic memory error detector.
In-Reply-To: <8761j6nr53.fsf@tassilo.jf.intel.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <53BDB1D6.1090605@intel.com> <8761j6nr53.fsf@tassilo.jf.intel.com>
Message-ID: <CAOMGZ=Fmqg6MWyx3NygqVmYiqw=npkPQrO9ifhF489bq5Gxz4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 July 2014 23:44, Andi Kleen <andi@firstfloor.org> wrote:
> Dave Hansen <dave.hansen@intel.com> writes:
>>
>> You're also claiming that "KASAN is better than all of
>
> better as in finding more bugs, but surely not better as in
> "do so with less overhead"
>
>> CONFIG_DEBUG_PAGEALLOC".  So should we just disallow (or hide)
>> DEBUG_PAGEALLOC on kernels where KASAN is available?
>
> I don't think DEBUG_PAGEALLOC/SLUB debug and kasan really conflict.
>
> DEBUG_PAGEALLOC/SLUB is "much lower overhead but less bugs found".
> KASAN is "slow but thorough" There are niches for both.
>
> But I could see KASAN eventually deprecating kmemcheck, which
> is just incredible slow.

FWIW, I definitely agree with this -- if KASAN can do everything that
kmemcheck can, it is no doubt the right way forward.


Vegard
