From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 26 Jan 2012 10:58:25 +0100
Subject: [Linaro-mm-sig] [PATCH 1/3] dma-buf: Introduce dma buffer sharing
 mechanism
In-Reply-To: <CAB2ybb98BT8L569G_728x1ZXdFNaQCDZzW2+kB0ZNeFak5_g+Q@mail.gmail.com>
References: <1324891397-10877-1-git-send-email-sumit.semwal@ti.com>
 <201201201423.46858.laurent.pinchart@ideasonboard.com>
 <CAB2ybb98BT8L569G_728x1ZXdFNaQCDZzW2+kB0ZNeFak5_g+Q@mail.gmail.com>
Message-ID: <201201261058.27098.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sumit,

On Wednesday 25 January 2012 14:56:52 Semwal, Sumit wrote:
> On Fri, Jan 20, 2012 at 6:53 PM, Laurent Pinchart wrote:
> > Hi Summit,
> > 
> > Sorry for the late review. I know that this code is now in mainline, but
> > I still have a couple of comments. I'll send patches if you agree with
> > them.
> 
> Hi Laurent,
> 
> Thanks for your review; apologies for being late in replying - I was
> OoO for last couple of days.

No worries.

[snip]

> Let me know if you'd send patches for these, or should I just go ahead and
> correct.

I'll send patches.

Another small comment. The map_dma_buf operation is defined as

        struct sg_table * (*map_dma_buf)(struct dma_buf_attachment *,
                                                enum dma_data_direction);

If we want to let exporters cache the sg_table we should return a const struct 
sg_table *. unmap_dma_buf will then take a const pointer as well, which would 
need to be cast to a non-const pointer internally. What's your opinion on that 
?

-- 
Regards,

Laurent Pinchart
