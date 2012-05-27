From: kosaki.motohiro@gmail.com (KOSAKI Motohiro)
Date: Sun, 27 May 2012 08:35:23 -0400
Subject: [PATCHv2 3/4] mm: vmalloc: add VM_DMA flag to indicate areas used
 by dma-mapping framework
In-Reply-To: <20120524122854.GD11860@linux-sh.org>
References: <1337252085-22039-1-git-send-email-m.szyprowski@samsung.com>
 <1337252085-22039-4-git-send-email-m.szyprowski@samsung.com>
 <4FBB3B41.8010102@kernel.org>
 <01e501cd39a8$67f34ea0$37d9ebe0$%szyprowski@samsung.com>
 <20120524122854.GD11860@linux-sh.org>
Message-ID: <CAHGf_=qmBMFfV=UhXFtepO8styaQonfBA0E0+FO0qSi7RLfJFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 8:28 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Thu, May 24, 2012 at 02:26:12PM +0200, Marek Szyprowski wrote:
>> On Tuesday, May 22, 2012 9:08 AM Minchan Kim wrote:
>> > Hmm, VM_DMA would become generic flag?
>> > AFAIU, maybe VM_DMA would be used only on ARM arch.
>>
>> Right now yes, it will be used only on ARM architecture, but maybe other architecture will
>> start using it once it is available.
>>
> There's very little about the code in question that is ARM-specific to
> begin with. I plan to adopt similar changes on SH once the work has
> settled one way or the other, so we'll probably use the VMA flag there,
> too.

I don't think VM_DMA is good idea because x86_64 has two dma zones. x86 unaware
patches make no sense.
