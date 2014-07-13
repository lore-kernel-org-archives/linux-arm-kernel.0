From: ryabinin.a.a@gmail.com (Andrey Ryabinin)
Date: Sun, 13 Jul 2014 14:39:21 +0400
Subject: [RFC/PATCH -next 00/21] Address sanitizer for kernel (kasan) -
 dynamic memory error detector.
In-Reply-To: <53C08876.10209@zytor.com>
References: <1404903678-8257-1-git-send-email-a.ryabinin@samsung.com>
 <53C08876.10209@zytor.com>
Message-ID: <CAPAsAGwb2sLmu0o_o-pFP5pXhMs-1sZSJbA3ji=W+JPOZRepgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-07-12 4:59 GMT+04:00 H. Peter Anvin <hpa@zytor.com>:
> On 07/09/2014 04:00 AM, Andrey Ryabinin wrote:
>>
>> Address sanitizer dedicates 1/8 of the low memory to the shadow memory and uses direct
>> mapping with a scale and offset to translate a memory address to its corresponding
>> shadow address.
>>
>> Here is function to translate address to corresponding shadow address:
>>
>>      unsigned long kasan_mem_to_shadow(unsigned long addr)
>>      {
>>               return ((addr) >> KASAN_SHADOW_SCALE_SHIFT)
>>                            + kasan_shadow_start - (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT);
>>      }
>>
>> where KASAN_SHADOW_SCALE_SHIFT = 3.
>>
>
> How does that work when memory is sparsely populated?
>

Sparsemem configurations currently may not work with kasan.
I suppose I will have to move shadow area to vmalloc address space and
make it (shadow) sparse too if needed.

>         -hpa
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo at kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email at kvack.org </a>



-- 
Best regards,
Andrey Ryabinin
