From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 7 Dec 2011 10:35:14 +0100
Subject: [PATCH] highmem: fix missed kmap_atomic update in
 arch/arm/include/asm/highmem.h
In-Reply-To: <1323249719.27710.2.camel@phoenix>
References: <1323249719.27710.2.camel@phoenix>
Message-ID: <20111207093514.GI4585@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2011 at 05:21:59PM +0800, Axel Lin wrote:
> commit 37bfbb "highmem: kill all __kmap_atomic()" missed the update to
> arch/arm/include/asm/highmem.h.
> 
> This patch fixes below build error:
>   CC      init/main.o
> In file included from include/linux/pagemap.h:10,
>                  from include/linux/mempolicy.h:70,
>                  from init/main.c:49:
> include/linux/highmem.h: In function 'kmap_atomic_deprecated':
> include/linux/highmem.h:127: error: implicit declaration of function 'kmap_atomic'
> include/linux/highmem.h:127: warning: return makes pointer from integer without a cast
> include/linux/highmem.h: In function 'clear_highpage':
> include/linux/highmem.h:218: warning: initialization makes pointer from integer without a cast
> include/linux/highmem.h: In function 'zero_user_segments':
> include/linux/highmem.h:227: warning: initialization makes pointer from integer without a cast
> include/linux/highmem.h: In function 'copy_highpage':
> include/linux/highmem.h:279: warning: assignment makes pointer from integer without a cast
> include/linux/highmem.h:280: warning: assignment makes pointer from integer without a cast
> make[1]: *** [init/main.o] Error 1
> make: *** [init] Error 2
Already reported and fixed, see

	http://thread.gmane.org/gmane.linux.kernel/1225278

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
