From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Mar 2018 19:39:38 +0100
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
In-Reply-To: <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
 <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
Message-ID: <20180305183938.GB20086@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2018 at 03:48:32PM +0000, Robin Murphy wrote:
> Unfortunately for us, fsl-mc is conceptually rather like PCI in that it's 
> software-discoverable and the only thing described in DT is the bus "host", 
> thus we need the same sort of thing as for PCI to map from the child 
> devices back to the bus root in order to find the appropriate firmware 
> node. Worse than PCI, though, we wouldn't even have the option of 
> describing child devices statically in firmware at all, since it's actually 
> one of these runtime-configurable "build your own network accelerator" 
> hardware pools where userspace gets to create and destroy "devices" as it 
> likes.

I really hate the PCI special case just as much.  Maybe we just
need a dma_configure method on the bus, and move PCI as well as fsl-mc
to it.
