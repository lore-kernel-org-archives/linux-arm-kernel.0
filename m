From: drake@endlessm.com (Daniel Drake)
Date: Thu, 7 May 2015 07:21:18 -0600
Subject: dma_alloc_coherent versus streaming DMA,
 neither works satisfactory
In-Reply-To: <554B49F0.1090100@topic.nl>
References: <5538DD02.6050401@topic.nl> <3382997.5hgfVKmNXP@wuerfel>
 <5540D356.50708@topic.nl> <9622793.RaVBbeJMCx@wuerfel>
 <554B49F0.1090100@topic.nl>
Message-ID: <CAD8Lp45w6_ck13sG3PQ549AxsgTi96XQAkUEd9DQqt-i=ZXxUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 7, 2015 at 5:18 AM, Mike Looijmans <mike.looijmans@topic.nl> wrote:
> I reverted all my patches and workarounds. Indeed, the kernel needs a
> "coherent" version of the dma_mmap routine, as the current version will map
> it as non-cachable, resulting in a big performance hit (and nullifying the
> whole idea behind it).
>
> I'll test it further on my 'hardware' and cook up a patch that correctly
> maps the coherent pages.

Sorry that I have only read this thread briefly, but I wonder if this
is what you are looking for:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325489.html

Thanks
Daniel
