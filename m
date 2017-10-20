From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Oct 2017 18:17:19 +0200
Subject: [PATCH 5/9] PCI: host: brcmstb: add dma-ranges for inbound traffic
In-Reply-To: <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
References: <20171017081422.GA19475@lst.de>
 <CANCKTBsCB+x2XgrND9AhRtxPkCXfps1nA+YymkZjKHOUZfjSHQ@mail.gmail.com>
 <20171018065316.GA11183@lst.de>
 <CANCKTBv+yiCNsrnx3m+W9wPqC4NdKPZ2p=zLtSa8fX6v1rPcYQ@mail.gmail.com>
 <20171019091644.GA14983@lst.de>
 <CANCKTBuaTD29My77QfOeUmtZfLAmmJXUYe6QvBW+uoH2Kb+tAQ@mail.gmail.com>
 <20171020073730.GA12937@lst.de>
 <CANCKTBsRRkwNMrxWjtgxbyZqT6NOxPX0NHDbnEO2BMjj8oVtpg@mail.gmail.com>
 <20171020145752.GA4694@lst.de>
 <CANCKTBtxp9gSdndKAZ7xGA+VozQsn2PX_-9P8A22_5Matbb7-w@mail.gmail.com>
Message-ID: <20171020161719.GA6247@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 20, 2017 at 11:27:41AM -0400, Jim Quinlan wrote:
>       memc0-a@[        0....3fffefff] <=> pci@[        0....3fffefff]
>       memc0-b@[100000000...13fffefff] <=> pci@[ 40000000....7fffefff]
>       memc1-a@[ 40000000....7fffefff] <=> pci@[ 80000000....bfffefff]
>       memc1-b@[300000000...33fffefff] <=> pci@[ c0000000....ffffefff]
>       memc2-a@[ 80000000....bfffefff] <=> pci@[100000000...13fffefff]
>       memc2-b@[c00000000...c3fffffff] <=> pci@[140000000...17fffffff]
> 
> This leaves a one-page gap between phsyical memory regions which would
> normally be contiguous. One cannot have a dma alloc that spans any two
> regions.  This is a drastic step, but I don't see an alternative.
> Perhaps  I may be missing what you are saying...

Ok, IFF we are guranteed to always have a gap between physical memory
locations we are fine indeed.
