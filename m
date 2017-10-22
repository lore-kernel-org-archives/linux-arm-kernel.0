From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Sun, 22 Oct 2017 12:42:29 +0000
Subject: =?gb2312?B?tPC4tDogW1BBVENIIDAyLzExXSByZXBsYWNlIG1lbW9yeSBmdW5jdGlvbg==?=
In-Reply-To: <20171019120555.GU20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-3-liuwenliang@huawei.com>
 <20171019120555.GU20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CF1E@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2017 20:06 PM, Russell King - ARM Linux wrote:
>On Wed, Oct 11, 2017 at 04:22:18PM +0800, Abbott Liu wrote:
>> From: Andrey Ryabinin <a.ryabinin@samsung.com>
>> 
>> Functions like memset/memmove/memcpy do a lot of memory accesses.
>> If bad pointer passed to one of these function it is important
>> to catch this. Compiler's instrumentation cannot do this since
>> these functions are written in assembly.
>> 
>> KASan replaces memory functions with manually instrumented variants.
>> Original functions declared as weak symbols so strong definitions
>> in mm/kasan/kasan.c could replace them. Original functions have aliases
>> with '__' prefix in name, so we could call non-instrumented variant
>> if needed.
>
>KASAN in the decompressor makes no sense, so I think you need to
>mark the decompressor compilation as such in this patch so it,
>as a whole, sees no change.

Thanks for your reviews, I has already known some error in arm/boot/compressed/ .
I'm going to change it in this patch in new version.
