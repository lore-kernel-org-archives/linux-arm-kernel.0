From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Tue, 7 Jun 2011 13:28:53 +0300
Subject: [RFC 2/6] omap: iovmm: generic iommu api migration
In-Reply-To: <201106071105.16262.laurent.pinchart@ideasonboard.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
	<1307053663-24572-3-git-send-email-ohad@wizery.com>
	<201106071105.16262.laurent.pinchart@ideasonboard.com>
Message-ID: <BANLkTi=nJXSEfWRXqwnHys1b5i5rgLcYpw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Tue, Jun 7, 2011 at 12:05 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> pgsz isn't used anymore, you can remove it.

Ok.

>> + ? ? ? ? ? ? order = get_order(bytes);
>
> Does iommu_map() handle offsets correctly, or does it expect pa to be aligned
> to an order (or other) boundary ?

Right now we have a BUG_ON if pa is unaligned, but that can be changed
if needed (do we want it to handle offsets ?).

> As Russell pointed out, we should use sg->length instead of sg_dma_length(sg).
> sg_dma_length(sg) is only valid after the scatter list has been DMA-mapped,
> which doesn't happen in the iovmm driver. This applies to all sg_dma_len(sg)
> calls.

I'll make sure I don't introduce such calls, but it sounds like a
separate patch should take care of the existing ones; pls tell me if
you want me to send one.

Thanks,
Ohad.
