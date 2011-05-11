From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 11 May 2011 06:02:49 +0200
Subject: AT91: Remove fixed mapping for AT91RM9200 ethernet
In-Reply-To: <20110511034901.GA22009@game.jcrosoft.org>
References: <1304884489.6089.13.camel@redbox>
	<20110511034901.GA22009@game.jcrosoft.org>
Message-ID: <20110511040249.GB22009@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05:49 Wed 11 May     , Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 21:54 Sun 08 May     , Andrew Victor wrote:
> > The AT91RM9200 Ethernet controller still has a fixed IO mapping.
> > So:
> > * Remove the fixed IO mapping and AT91_VA_BASE_EMAC definition.
> > * Pass the physical base-address via platform-resources to the driver.
> > * Convert at91_ether.c driver to perform an ioremap().
> > * Ethernet PHY detection needs to be performed during the driver
> > initialization process, it can no longer be done first.
> we need to pass the irq too as the hw ip does not belong to Atmel
> so it can be attached to any irq
> 
> ca we split is in two file on for -net and the other one for at91 tree
forget we can not split it

David don't you mind if we apply it through the at91 tree

Best Regards,
J.
> 
> Best Regards,
> J.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
