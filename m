From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 28 May 2012 10:19:39 +0200
Subject: [PATCHv2 3/4] mm: vmalloc: add VM_DMA flag to indicate areas used
 by dma-mapping framework
In-Reply-To: <CAHGf_=qmBMFfV=UhXFtepO8styaQonfBA0E0+FO0qSi7RLfJFA@mail.gmail.com>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
 <1337252085-22039-4-git-send-email-m.szyprowski@samsung.com>
 <4FBB3B41.8010102@kernel.org>
 <01e501cd39a8$67f34ea0$37d9ebe0$%szyprowski@samsung.com>
 <20120524122854.GD11860@linux-sh.org>
 <CAHGf_=qmBMFfV=UhXFtepO8styaQonfBA0E0+FO0qSi7RLfJFA@mail.gmail.com>
Message-ID: <001d01cd3caa$a05d0510$e1170f30$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sunday, May 27, 2012 2:35 PM KOSAKI Motohiro wrote:

> On Thu, May 24, 2012 at 8:28 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Thu, May 24, 2012 at 02:26:12PM +0200, Marek Szyprowski wrote:
> >> On Tuesday, May 22, 2012 9:08 AM Minchan Kim wrote:
> >> > Hmm, VM_DMA would become generic flag?
> >> > AFAIU, maybe VM_DMA would be used only on ARM arch.
> >>
> >> Right now yes, it will be used only on ARM architecture, but maybe other architecture will
> >> start using it once it is available.
> >>
> > There's very little about the code in question that is ARM-specific to
> > begin with. I plan to adopt similar changes on SH once the work has
> > settled one way or the other, so we'll probably use the VMA flag there,
> > too.
> 
> I don't think VM_DMA is good idea because x86_64 has two dma zones. x86 unaware
> patches make no sense.

I see no problems to add VM_DMA64 later if x86_64 starts using vmalloc areas for creating 
kernel mappings for the dma buffers (I assume that there are 2 dma zones: one 32bit and one
64bit). Right now x86 and x86_64 don't use vmalloc areas for dma buffers, so I hardly see
how this patch can be considered as 'x86 unaware'.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
