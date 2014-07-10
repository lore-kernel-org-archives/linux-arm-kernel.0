From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Thu, 10 Jul 2014 11:41:12 +0400
Subject: [RFC/PATCH RESEND -next 11/21] mm: slub: share slab_err and
 object_err functions
In-Reply-To: <alpine.DEB.2.11.1407090928530.1384@gentwo.org>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-12-git-send-email-a.ryabinin@samsung.com>
 <alpine.DEB.2.11.1407090928530.1384@gentwo.org>
Message-ID: <53BE4398.6020509@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/14 18:29, Christoph Lameter wrote:
> On Wed, 9 Jul 2014, Andrey Ryabinin wrote:
> 
>> Remove static and add function declarations to mm/slab.h so they
>> could be used by kernel address sanitizer.
> 
> Hmmm... This is allocator specific. At some future point it would be good
> to move error reporting to slab_common.c and use those from all
> allocators.
> 

I could move declarations to kasan internals, but it will look ugly too.
I also had an idea about unifying SLAB_DEBUG and SLUB_DEBUG at some future.
I can't tell right now how hard it will be, but it seems doable.
