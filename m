From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Fri, 30 Aug 2013 09:23:12 -0400
Subject: [PATCH v4 09/10] swiotlb-xen: support autotranslate guests
In-Reply-To: <alpine.DEB.2.02.1308282112300.6397@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1308151200580.4470@kaball.uk.xensource.com>
 <1376565054-24153-9-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130815200738.GD5337@konrad-lan.dumpdata.com>
 <alpine.DEB.2.02.1308282112300.6397@kaball.uk.xensource.com>
Message-ID: <20130830132312.GF21239@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Did you run any performance tests to see if adding the extra
> > spinlock (as the native SWIOTLB already has its own lock) and handling
> > of the tree is affecting it?

.. bla bla..

> I haven't done any measurements but consider that the spin_lock is
> already only used to access the red-black tree that keeps track of
> dma_addr -> phys_addr mappings.
> So it's taken at setup time once, then every time we call
> xen_bus_to_phys and the guest is an autotraslate guest.
> If the guest is not autotraslate there are no additional locks.
> 
> That makes me realize that we don't need any spin_locks at all: there
> are no risks of concurrent accesses and modifications of the tree
> because there are no changes on the tree once it's setup at boot time.
> We can get rid of the spin_lock entirely as concurrent read accesses on
> the tree are obviously fine.

Nice :-) I think that (and the goto) were the only concerns I had.

Thanks!
