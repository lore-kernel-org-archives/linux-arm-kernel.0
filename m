From: rientjes@google.com (David Rientjes)
Date: Thu, 9 Apr 2015 12:31:05 -0700 (PDT)
Subject: [PATCH] mempool: add missing include
In-Reply-To: <3302342.cNyRUGN06P@wuerfel>
References: <3302342.cNyRUGN06P@wuerfel>
Message-ID: <alpine.DEB.2.10.1504091230400.11370@chino.kir.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Apr 2015, Arnd Bergmann wrote:

> This is a fix^3 for the mempool poisoning patch, which introduces
> a compile-time error on some ARM randconfig builds:
> 
> mm/mempool.c: In function 'check_element':
> mm/mempool.c:65:16: error: implicit declaration of function 'kmap_atomic' [-Werror=implicit-function-declaration]
>    void *addr = kmap_atomic((struct page *)element);
> 
> The problem is clearly the missing declaration, and including
> linux/highmem.h fixes it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a3db5a8463b0db ("mm, mempool: poison elements backed by page allocator fix fix")

Acked-by: David Rientjes <rientjes@google.com>

Thanks!  Can you confirm that this is because CONFIG_BLOCK is disabled and 
not something else?
