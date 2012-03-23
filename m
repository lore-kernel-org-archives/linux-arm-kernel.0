From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 23 Mar 2012 14:35:48 -0700
Subject: [GIT PULL] DMA-mapping framework updates for 3.4
In-Reply-To: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
References: <1332228283-29077-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <CA+55aFy9oxMrfm-+deMqV=XnFOa98aKXqW+8PR-P-zOARtC2BQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 12:24 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> ?git://git.infradead.org/users/kmpark/linux-samsung dma-mapping-next
>
> Those patches introduce a new alloc method (with support for memory
> attributes) in dma_map_ops structure, which will later replace
> dma_alloc_coherent and dma_alloc_writecombine functions.

So I'm quite unhappy with these patches.

Here's just the few problems I saw from some *very* quick look-through
of the git tree:

 - I'm not seeing ack's from the architecture maintainers for the
patches that change some architecture.

 - Even more importantly, what I really want is acks and comments from
the people who are expected to *use* this.

 - it looks like patches break compilation half-way through the
series. Just one example I noticed: the "x86 adaptation" patch changes
the functions in lib/swiotlb.c, but afaik ia64 *also* uses those. So
now ia64 is broken until a couple of patches later. I suspect there
are other examples like that.

 - the sign-off chains are odd. What happened there? Several patches
are signed off by Kyungmin Park, but he doesn't seem to be "in the
chain" at all. Whazzup? (*)

(Btw, I notice the same thing in the tree I pulled from Dave Airlie,
btw - what the F is going on with samsung submissions - those are
marked as committed by Dave Airlie, and don't have Dave in the
sign-off chain at all!)

 - Finally, how/why are "dma attributes" different from the per-device
dma limits ("device_dma_parameters")

Hmm?

                  Linus

(*) Btw, I notice the same thing in the tree I pulled from Dave
Airlie, btw - what the F is going on with samsung submissions - those
are marked as committed by Dave Airlie, and don't have Dave in the
sign-off chain at all! Dave?
