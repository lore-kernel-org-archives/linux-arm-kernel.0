From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 11 Dec 2017 10:42:33 +0000
Subject: [PATCH v2] PCI: keystone: fix interrupt-controller-node lookup
In-Reply-To: <20171211102955.GK5672@localhost>
References: <20171117133831.1300-1-johan@kernel.org>
 <20171211102955.GK5672@localhost>
Message-ID: <20171211104233.GB3225@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 11:29:55AM +0100, Johan Hovold wrote:
> On Fri, Nov 17, 2017 at 02:38:31PM +0100, Johan Hovold wrote:
> > Fix child-node lookup during initialisation which was using the wrong
> > OF-helper and ended up searching the whole device tree depth-first
> > starting at the parent rather than just matching on its children.
> > 
> > To make things worse, the parent pci node could end up being prematurely
> > freed as of_find_node_by_name() drops a reference to its first argument.
> > Any matching child interrupt-controller node was also leaked.
> > 
> > Fixes: 0c4ffcfe1fbc ("PCI: keystone: Add TI Keystone PCIe driver")
> > Cc: stable <stable@vger.kernel.org>     # 3.18
> > Acked-by: Murali Karicheri <m-karicheri2@ti.com>
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Signed-off-by: Johan Hovold <johan@kernel.org>
> > ---
> > 
> > v2
> >  - amend commit message and mention explicitly that of_find_node_by_name()
> >    drops a reference to the start node
> >  - add Murali's and Lorenzo's acks
> 
> This one hasn't shown up in linux-next, so sending a reminder to make
> sure it doesn't fall between the cracks.

Hi Johan,

yes it is in the list of fixes to be sent upstream - I was about to
ask Bjorn to apply it.

Thanks,
Lorenzo
