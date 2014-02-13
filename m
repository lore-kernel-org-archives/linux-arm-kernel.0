From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Feb 2014 13:21:04 +0100
Subject: [PATCH v2 3/3] PCI: ARM: add support for generic PCI host
 controller
In-Reply-To: <20140213120042.GE13576@mudshark.cambridge.arm.com>
References: <1392236171-10512-1-git-send-email-will.deacon@arm.com>
 <348076699.SKFqCqFVHd@wuerfel>
 <20140213120042.GE13576@mudshark.cambridge.arm.com>
Message-ID: <4122896.snWHKCSulY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 February 2014 12:00:42 Will Deacon wrote:
> > With the patch I just suggested, we can simply keep
> > pci_common_init_dev() for older (non-multiplatform) controllers 
> > and not change them at all but move on to something else for
> > the interesting ones, i.e. those we want to share with arm64.
> 
> Yes, that looks sensible. An alternative is to create an hw_pci in
> pci_host_bridge_register with nr_controllers = 1 then call
> pci_common_init_dev. It would remove slightly more code, but obviously ties
> the thing to arm.

You'd still need to pass all the contents of the hw_pci struct that
get copied into pci_sys_data, so that's not different from passing
hw_pci as we do today.

	Arnd
