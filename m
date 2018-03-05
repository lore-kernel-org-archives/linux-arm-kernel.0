From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 5 Mar 2018 15:48:32 +0000
Subject: [PATCH 5/6] dma-mapping: support fsl-mc bus
In-Reply-To: <20180305150814.GA15918@lst.de>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
 <20180305150814.GA15918@lst.de>
Message-ID: <7b4f9972-6aaa-fc9d-3854-d48b19a8051c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/18 15:08, Christoph Hellwig wrote:
> We should not add any new hardocded busses here.  Please mark them in
> OF/ACPI.

Unfortunately for us, fsl-mc is conceptually rather like PCI in that 
it's software-discoverable and the only thing described in DT is the bus 
"host", thus we need the same sort of thing as for PCI to map from the 
child devices back to the bus root in order to find the appropriate 
firmware node. Worse than PCI, though, we wouldn't even have the option 
of describing child devices statically in firmware at all, since it's 
actually one of these runtime-configurable "build your own network 
accelerator" hardware pools where userspace gets to create and destroy 
"devices" as it likes.

Robin.
