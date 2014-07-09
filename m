From: cl@gentwo.org (Christoph Lameter)
Date: Wed, 9 Jul 2014 09:33:39 -0500 (CDT)
Subject: [RFC/PATCH RESEND -next 13/21] mm: slub: add allocation size
 field to struct kmem_cache
In-Reply-To: <1404905415-9046-14-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-14-git-send-email-a.ryabinin@samsung.com>
Message-ID: <alpine.DEB.2.11.1407090933170.1384@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jul 2014, Andrey Ryabinin wrote:

> When caller creates new kmem_cache, requested size of kmem_cache
> will be stored in alloc_size. Later alloc_size will be used by
> kerenel address sanitizer to mark alloc_size of slab object as
> accessible and the rest of its size as redzone.

I think this patch is not needed since object_size == alloc_size right?
