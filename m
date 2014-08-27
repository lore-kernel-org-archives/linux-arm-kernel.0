From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Wed, 27 Aug 2014 18:24:04 +0200
Subject: [PATCH v9 00/12] Support for creating generic PCI host bridges
 from DT
In-Reply-To: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
References: <1407860725-25202-1-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20140827162404.GA4818@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Liviu,

On 12.08.14 17:25:13, Liviu Dudau wrote:
> This is my updated attempt at adding support for generic PCI host
> bridge controllers that make use of device tree information to
> configure themselves. This version incorporates Catalin's proposal
> for managing domain numbers that got Bjorn's approval. I am now requesting
> ACKs from the relevant maintainers as I would like to get the upstream ball
> rolling.
>
> Of the more important changes vs v8, this version has an altered implementation
> of of_create_pci_host_bridge() that allows for easier conversion of architectures
> that use pci_scan_root_bus() in their code rather than pci_create_root_bus().
> With my v8 version of the patchset it would've meant adding back the code
> from pci_scan_root_bus() into architectural code. v9 fixes that and adds
> a callback parameter to of_create_pci_host_bridge() that permits the host
> controller driver to finish the driver setup before the bus is being scanned.
>
> To repeat for the benefit of people writing host bridge drivers on top of
> my patchset: the API for of_create_pci_host_bridge() has changed and it will now
> do all the child bus and device scanning for you, so you only need to provide a
> setup function that will be called before scanning start. I will post a patch
> that Lorenzo has kindly constructed for converting pci-host-generic.c to my API.

would it be possible to provide a branch with this patch set in your
git repo as for v8?

This would make rebasing and testing of our Cavium Thunder code base
much easier. We could then also refer to a public repo where our
patches base on.

Thanks,

-Robert
