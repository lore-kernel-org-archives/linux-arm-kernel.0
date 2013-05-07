From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 07 May 2013 20:19:18 +1000
Subject: [PATCH v8 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <20130507080142.GA8808@arm.com>
References: <1366627295-16964-1-git-send-email-Andrew.Murray@arm.com>
 <1366627295-16964-2-git-send-email-Andrew.Murray@arm.com>
 <1367721709.11982.37.camel@pasglop> <20130507080142.GA8808@arm.com>
Message-ID: <1367921958.25488.8.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-05-07 at 09:01 +0100, Andrew Murray wrote:
> 
> There were no objections to this latest revision until now and it is
> currently sitting with Jason Cooper (mvebu-next/pcie). [1]

Ok, well I've just sent Linus a pull request for my changes so at least
drop the powerpc changes from your tree for the time being.

> This is a view that was also shared by Bjorn [2] when I attempted to
> submit a patchset which moves struct pci_controller to asm-generic.

Right, it's the logical way to go

> The motativation for my patchsets were to give a way for ARM PCI host
> bridge drivers to parse the DT ranges property, but this snow-balled
> into unifying pci_process_bridge_OF_ranges.

Which I understand, I would probably have done the same thing in your
shoes :-)

> My v8 patchset provides a of_pci_range_parser which is used directly
> by a few ARM PCI DT host bridge drivers, this has been generally
> accepted and tested. I don't see why this can't remain and so I'd
> really like to keep this around. 

Sure, no objection, in fact I should/could probably update my new code
to use it as well.

> Grant, Benjamin would you be happy for me to resubmit this series
> which provides the of_pci_range_parser which will be used by the
> separate implementations of pci_process_bridge_OF_ranges in
> PowerPC/Microblaze?

Sure, in fact feel free to update my new code if you have more bandwidth
than I do, it should hit Linus tree soon hopefully unless he objects to
me having a second pull request this merge window...

> Benjamin are you able to still use of_pci_range_parser in your
> 'Support per-aperture memory offset' patch?

I see no reason why not. I just haven't looked into it much, I admit,
being bogged down with a pile of new HW bringup in the lab etc...

Cheers,
Ben.
