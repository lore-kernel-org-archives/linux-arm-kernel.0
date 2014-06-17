From: iamjoonsoo.kim@lge.com (Joonsoo Kim)
Date: Tue, 17 Jun 2014 10:25:07 +0900
Subject: [PATCH v3 -next 0/9] CMA: generalize CMA reserved area
 management code
In-Reply-To: <539EB4C7.3080106@samsung.com>
References: <1402897251-23639-1-git-send-email-iamjoonsoo.kim@lge.com>
 <539EB4C7.3080106@samsung.com>
Message-ID: <20140617012507.GA6825@js1304-P5Q-DELUXE>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 11:11:35AM +0200, Marek Szyprowski wrote:
> Hello,
> 
> On 2014-06-16 07:40, Joonsoo Kim wrote:
> >Currently, there are two users on CMA functionality, one is the DMA
> >subsystem and the other is the KVM on powerpc. They have their own code
> >to manage CMA reserved area even if they looks really similar.
> >>From my guess, it is caused by some needs on bitmap management. Kvm side
> >wants to maintain bitmap not for 1 page, but for more size. Eventually it
> >use bitmap where one bit represents 64 pages.
> >
> >When I implement CMA related patches, I should change those two places
> >to apply my change and it seem to be painful to me. I want to change
> >this situation and reduce future code management overhead through
> >this patch.
> >
> >This change could also help developer who want to use CMA in their
> >new feature development, since they can use CMA easily without
> >copying & pasting this reserved area management code.
> >
> >v3:
> >   - Simplify old patch 1(log format fix) and move it to the end of patchset.
> >   - Patch 2: Pass aligned base and size to dma_contiguous_early_fixup()
> >   - Patch 5: Add some accessor functions to pass aligned base and size to
> >   dma_contiguous_early_fixup() function
> >   - Patch 5: Move MAX_CMA_AREAS definition to cma.h
> >   - Patch 6: Add CMA region zeroing to PPC KVM's CMA alloc function
> >   - Patch 8: put 'base' ahead of 'size' in cma_declare_contiguous()
> >   - Remaining minor fixes are noted in commit description of each one
> >
> >v2:
> >   - Although this patchset looks very different with v1, the end result,
> >   that is, mm/cma.c is same with v1's one. So I carry Ack to patch 6-7.
> >
> >This patchset is based on linux-next 20140610.
> 
> Thanks for taking care of this. I will test it with my setup and if
> everything goes well, I will take it to my -next tree. If any branch
> is required for anyone to continue his works on top of those patches,
> let me know, I will also prepare it.

Hello,

I'm glad to hear that. :)
But, there is one concern. As you already know, I am preparing further
patches (Aggressively allocate the pages on CMA reserved memory). It
may be highly related to MM branch and also slightly depends on this CMA
changes. In this case, what is the best strategy to merge this
patchset? IMHO, Anrew's tree is more appropriate branch. If there is
no issue in this case, I am willing to develope further patches based
on your tree.

Thanks.
