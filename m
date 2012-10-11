From: shc_work@mail.ru (Alexander Shiyan)
Date: Thu, 11 Oct 2012 18:24:38 +0400
Subject: [PATCH 5/7] ARM: clps711x: make all virtual addresses
 definition via one macro
In-Reply-To: <201210101825.49391.arnd@arndb.de>
References: <1349883933-8881-1-git-send-email-shc_work@mail.ru>
 <1349883933-8881-5-git-send-email-shc_work@mail.ru>
 <201210101825.49391.arnd@arndb.de>
Message-ID: <20121011182438.abb66cce.shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Oct 2012 18:25:49 +0000
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wednesday 10 October 2012, Alexander Shiyan wrote:
> > This patch make all virtual addresses definition via one macro.
> > This modification allows to avoid warning "BUG: mapping for 0x80000000
> > at 0xff000000 out of vmalloc space".
> > 
> > Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> 
> Two comments on this one:
> 
> * I wonder if we could just kill off some of the mappings if no driver
>   relies on the registers being mapped in advance, especially for those
>   that don't benefit from section mapping like the ethernet one that is
>   only a page anyway.

I'm working on this and the next series of patches will be is almost
completely free of static mappings.

> * I would recommend defining the IO_ADDRESS macro in a way that the
>   result is of type 'void __iomem *', and you add a cast in the 
>   map_desc array. We will probably clean those up eventually and
>   require that they are pointers at that place anyway, based on
>   recent discussions.

It's easy to do. Will be considered in the next series of patches.

-- 
Alexander Shiyan <shc_work@mail.ru>
