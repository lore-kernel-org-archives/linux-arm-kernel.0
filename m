From: cl@gentwo.org (Christoph Lameter)
Date: Wed, 9 Jul 2014 09:32:21 -0500 (CDT)
Subject: [RFC/PATCH RESEND -next 12/21] mm: util: move krealloc/kzfree
 to slab_common.c
In-Reply-To: <1404905415-9046-13-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-13-git-send-email-a.ryabinin@samsung.com>
Message-ID: <alpine.DEB.2.11.1407090931350.1384@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jul 2014, Andrey Ryabinin wrote:

> To avoid false positive reports in kernel address sanitizer krealloc/kzfree
> functions shouldn't be instrumented. Since we want to instrument other
> functions in mm/util.c, krealloc/kzfree moved to slab_common.c which is not
> instrumented.
>
> Unfortunately we can't completely disable instrumentation for one function.
> We could disable compiler's instrumentation for one function by using
> __atribute__((no_sanitize_address)).
> But the problem here is that memset call will be replaced by instumented
> version kasan_memset since currently it's implemented as define:

Looks good to me and useful regardless of the sanitizer going in.

Acked-by: Christoph Lameter <cl@linux.com>
