From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Oct 2017 16:57:52 +0200
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
References: <1507761269-7017-6-git-send-email-jim2101024@gmail.com>
 <589c04cb-061b-a453-3188-79324a02388e@arm.com>
 <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
 <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
Message-ID: <20171020145752.GA4694@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 10:41:56AM -0400, Jim Quinlan wrote:
> I am not sure I understand your comment -- the size of the request
> shouldn't be a factor.  Let's look at your example of the DMA request
> of 3fffff00 to 4000000f (physical memory).  Lets say it is for 15
> pages.  If we block out  the last page [0x3ffff000..0x3fffffff] from
> what is available, there is no 15 page span that can happen across the
> 0x40000000 boundary.  For SG, there can be no merge that connects a
> page from one region to another region.  Can you give an example of
> the scenario you are thinking of?

What prevents a merge from say the regions of
0....3fffffff and 40000000....7fffffff?
