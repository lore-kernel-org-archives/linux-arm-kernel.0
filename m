From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 29 Jul 2013 11:11:00 -0600
Subject: Defining schemas for Device Tree
In-Reply-To: <20130729164905.GB2280@localhost.localdomain>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
 <20130729164905.GB2280@localhost.localdomain>
Message-ID: <20130729171100.GA15861@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 05:49:05PM +0100, Dave Martin wrote:

> Provided child/parent relationships are maintained and the set of nodes
> and values is the same, I think completely rearranging a .dts file does
> not change its meaning.
> 
> "depends-on" relationships mostly have to come from the semantics of
> the bindings themselves: for example, if a device is connected to some
> clocks and regulators, the kernel may need to probe those first.

There is already code in the kernel to sort the interrupt controllers
from DT and start them up in the right order.

I've often thought to myself that the deferred probe hack could be
avoided if some layer in the DT stack could do the same kind of topo
sorting, but more generally.

Just topo-sorting based on phandles would probably get things quite
far along??

Jason
