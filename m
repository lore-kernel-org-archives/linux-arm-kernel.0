From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 12:44:58 +0400
Subject: [RFC/PATCH RESEND -next 13/21] mm: slub: add allocation size field
 to struct kmem_cache
In-Reply-To: <alpine.DEB.2.11.1407090933170.1384@gentwo.org>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-14-git-send-email-a.ryabinin@samsung.com>
 <alpine.DEB.2.11.1407090933170.1384@gentwo.org>
Message-ID: <53BE528A.1080104@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/14 18:33, Christoph Lameter wrote:
> On Wed, 9 Jul 2014, Andrey Ryabinin wrote:
> 
>> When caller creates new kmem_cache, requested size of kmem_cache
>> will be stored in alloc_size. Later alloc_size will be used by
>> kerenel address sanitizer to mark alloc_size of slab object as
>> accessible and the rest of its size as redzone.
> 
> I think this patch is not needed since object_size == alloc_size right?
> 

I vaguely remember there was a reason for this patch, but I can't see/recall it now.
Probably I misunderstood something. I'll drop this patch
