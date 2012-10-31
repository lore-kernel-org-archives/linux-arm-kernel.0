From: rkiyerpersonal@gmail.com (Rajanikanth H.V)
Date: Wed, 31 Oct 2012 10:09:40 +0000
Subject: Two questions about streaming DMA flushing
In-Reply-To: <20121031090821.GK21164@n2100.arm.linux.org.uk>
References: <CAFNq8R7Fb5Dn6pMDDNvQp=kgpY9vmdpxyhNAPUXYA0-QbfHoJg@mail.gmail.com>
 <20121031090821.GK21164@n2100.arm.linux.org.uk>
Message-ID: <CAHH-VyWu3-QiZunfcxL_fhnVhfy0ENoigZbdXp_ipHpA-7Bwjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > 2.
> > 345 ENTRY(v7_dma_unmap_area)
> > 346         add     r1, r1, r0
> > 347         teq     r2, #DMA_TO_DEVICE
> > 348         bne     v7_dma_inv_range
> > 349         mov     pc, lr
> > 350 ENDPROC(v7_dma_unmap_area)
> >
> > v7_dma_unmap_area, will invalidate corresponding cache line for
> > ?DMA_FROM_DEVICE?. But, at v7_dma_map_area, the invalidate has been done.
> > Why do this again?
>
> Cache prefetching.
>
Speculative prefetch?

>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121031/4ea66442/attachment-0001.html>
