From: vkoul@kernel.org (Vinod)
Date: Fri, 29 Jun 2018 13:49:39 +0530
Subject: [PATCH v3 1/5] dmaengine: xilinx_dma: in axidma slave_sg and
 dma_cylic mode align split descriptors
In-Reply-To: <CAN8YU5Owh2Sb+-mOR0nVFkdZpD=dRd2jCin5MCdnsNLPo5zwwg@mail.gmail.com>
References: <20180625092724.22164-1-andrea.merello@gmail.com>
 <20180629072552.GY22377@vkoul-mobl>
 <CAN8YU5Owh2Sb+-mOR0nVFkdZpD=dRd2jCin5MCdnsNLPo5zwwg@mail.gmail.com>
Message-ID: <20180629081939.GA22377@vkoul-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-06-18, 09:46, Andrea Merello wrote:
> On Fri, Jun 29, 2018 at 9:25 AM, Vinod <vkoul@kernel.org> wrote:

> >> +
> >> +                     if ((copy + sg_used < period_len) &&
> >> +                         chan->xdev->common.copy_align) {
> >> +                             /*
> >> +                              * If this is not the last descriptor, make sure
> >> +                              * the next one will be properly aligned
> >> +                              */
> >> +                             copy = rounddown(copy,
> >> +                                     (1 << chan->xdev->common.copy_align));
> >> +                     }
> >
> > same code pasted twice, can we have a routine for this... perhaps more
> > code can be made common too
> 
> Yes, I see.. Indeed there was duplicated code before this series and
> it is still there after it.
> 
> I can see if we can have a routine as you suggested at least for the
> code portions touched by this patch. Do you eventually want this extra
> change to be done in the same patch 1/5 or do you want a separate
> patch i.e. 2/6 or 6/6 ?

Each patch should do one thing, so would make sense to move first and
then add you on top of that. 1/6 commonize and 2/6 add this bit.


-- 
~Vinod
