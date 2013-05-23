From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 23 May 2013 10:47:09 +0100
Subject: [PATCH v2 0/4] dma-mapping: Define dma_{alloc,free}_attrs()
 for all archs
In-Reply-To: <519D8331.3060203@igel.co.jp>
References: <1367290899-10410-1-git-send-email-dhobsong@igel.co.jp>
 <519C2F5D.8000809@igel.co.jp> <20130522094741.GE14322@arm.com>
 <519D8331.3060203@igel.co.jp>
Message-ID: <20130523094709.GB16722@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 03:47:13AM +0100, Damian Hobson-Garcia wrote:
> Hi Catalin,
> On 2013/05/22 18:47, Catalin Marinas wrote:
> > On Wed, May 22, 2013 at 03:37:17AM +0100, Damian Hobson-Garcia wrote:
> >> Hello,
> >> On 2013/04/30 12:01, Damian Hobson-Garcia wrote:
> >>> Most architectures that define CONFIG_HAVE_DMA=y, have implementations for
> >>> both dma_alloc_attrs() and dma_free_attrs().  All achitectures that do
> >>> not define CONFIG_HAVE_DMA also have both of these definitions provided by
> >>> dma-mapping-broken.h.
> > 
> > BTW, shouldn't this be called CONFIG_HAVE_DMA_ATTRS?
> 
> CONFIG_HAVE_DMA_ATTRS is currently used to enable the functions to
> set/get the DMA attribute values. Poking through the headers, it looks
> like the struct dma_attrs is defined regardless of the
> CONFIG_HAVE_DMA_ATTRS setting, so in that respect
> we always seem to "have" DMA attributes (if we have DMA), but they may
> not always be meaningful (ie. set to some value).

My point was about the commit log - grep'ing the kernel for
CONFIG_HAVE_DMA did not return anything.

-- 
Catalin
