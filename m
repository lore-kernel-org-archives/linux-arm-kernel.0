From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 03 Apr 2012 07:20:00 +1000
Subject: [PATCH v5 06/27] irq_domain/powerpc: eliminate irq_map; use
 irq_alloc_desc() instead
In-Reply-To: <alpine.LFD.2.02.1204022251420.2542@ionos>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <1329383368-12122-7-git-send-email-grant.likely@secretlab.ca>
 <m2iphj3zxr.fsf@igel.home> <m2hax2qeqs.fsf@igel.home>
 <alpine.LFD.2.02.1204022251420.2542@ionos>
Message-ID: <1333401600.30734.56.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-04-02 at 22:52 +0200, Thomas Gleixner wrote:
> > When I revert a09b659cd68c10ec6a30cb91ebd2c327fcd5bfe5 ("genirq: Fix
> > long-term regression in genirq irq_set_irq_type() handling") on top
> of
> > 3.4-rc1 the sata irq errors disappear, but I see a lot of spurious
> 
> Hmm. Which irq chip is handling the interrupt for that sata irq ?

MPIC. The irq is a PCI IRQ, and so should be level-low, it should have
been mapped by the PCI code using the of_* calls.

Cheers,
Ben.
