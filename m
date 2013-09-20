From: tj@kernel.org (Tejun Heo)
Date: Fri, 20 Sep 2013 07:18:34 -0500
Subject: [PATCH 39/51] DMA-API: others: use dma_set_coherent_mask()
In-Reply-To: <20130920121652.GA7630@mtj.dyndns.org>
References: <20130919212235.GD12758@n2100.arm.linux.org.uk>
 <E1VMnNq-0007s4-HN@rmk-PC.arm.linux.org.uk>
 <20130920121652.GA7630@mtj.dyndns.org>
Message-ID: <20130920121834.GB7630@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 20, 2013 at 07:16:52AM -0500, Tejun Heo wrote:
> On Fri, Sep 20, 2013 at 12:11:38AM +0100, Russell King wrote:
> > The correct way for a driver to specify the coherent DMA mask is
> > not to directly access the field in the struct device, but to use
> > dma_set_coherent_mask().  Only arch and bus code should access this
> > member directly.
> > 
> > Convert all direct write accesses to using the correct API.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> The patch is pretty widely spread.  I don't mind how it gets routed
> but what's the plan?

Hmm... maybe hte pata_ixp4xx_cf.c part should be moved to the one
which updates pata_octeon_cf.c?

Thanks.

-- 
tejun
