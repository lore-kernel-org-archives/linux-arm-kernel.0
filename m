From: cl@gentwo.org (Christoph Lameter)
Date: Wed, 9 Jul 2014 09:26:03 -0500 (CDT)
Subject: [RFC/PATCH RESEND -next 01/21] Add kernel address sanitizer
 infrastructure.
In-Reply-To: <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-2-git-send-email-a.ryabinin@samsung.com>
Message-ID: <alpine.DEB.2.11.1407090924030.1384@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jul 2014, Andrey Ryabinin wrote:

> +
> +Markers of unaccessible bytes could be found in mm/kasan/kasan.h header:
> +
> +#define KASAN_FREE_PAGE         0xFF  /* page was freed */
> +#define KASAN_PAGE_REDZONE      0xFE  /* redzone for kmalloc_large allocations */
> +#define KASAN_SLAB_REDZONE      0xFD  /* Slab page redzone, does not belong to any slub object */

We call these zones "PADDING". Redzones are associated with an object.
Padding is there because bytes are left over, unusable or necessary for
alignment.
