From: hch@lst.de (Christoph Hellwig)
Date: Fri, 9 Nov 2018 08:49:55 +0100
Subject: [PATCH 06/10] swiotlb: use swiotlb_map_page in
 swiotlb_map_sg_attrs
In-Reply-To: <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
References: <20181008080246.20543-1-hch@lst.de>
 <20181008080246.20543-7-hch@lst.de>
 <CANcMJZAzrxA9LGNvP-epv2DwsUacEM_hcgA1n5gmaPuWRJG4iw@mail.gmail.com>
Message-ID: <20181109074955.GA27489@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 05:27:14PM -0800, John Stultz wrote:
> But at that point if I just re-apply "swiotlb: use swiotlb_map_page in
> swiotlb_map_sg_attrs", I reproduce the hangs.
> 
> Any suggestions for how to further debug what might be going wrong
> would be appreciated!

Very odd.  In the end map_sg and map_page are defined to do the same
things to start with.  The only real issue we had in this area was:

"[PATCH v2] of/device: Really only set bus DMA mask when appropriate"

so with current mainline + that you still see a problem, and if you
rever the commit we are replying to it still goes away?
