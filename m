From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 11:31:13 +0400
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <alpine.DEB.2.11.1407090924030.1384@gentwo.org>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
 <alpine.DEB.2.11.1407090924030.1384@gentwo.org>
Message-ID: <53BE4141.6060908@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/14 18:26, Christoph Lameter wrote:
> On Wed, 9 Jul 2014, Andrey Ryabinin wrote:
> 
>> +
>> +Markers of unaccessible bytes could be found in mm/kasan/kasan.h header:
>> +
>> +#define KASAN_FREE_PAGE         0xFF  /* page was freed */
>> +#define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
>> +#define KASAN_SLAB_REDZONE      0xFD  /* Slab page redzone, does not belong to any slub object */
> 
> We call these zones "PADDING". Redzones are associated with an object.
> Padding is there because bytes are left over, unusable or necessary for
> alignment.
> 
Goop point. I will change the name to make it less confusing.
