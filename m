From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 28 Jun 2017 07:32:12 -0500
Subject: Build failure in -next due to 'PCI: versatile: Convert PCI scan
 API to pci_scan_root_bus_bridge()'
In-Reply-To: <113c3ec2-152d-de17-e05e-ade4fe76b7d8@roeck-us.net>
References: <113c3ec2-152d-de17-e05e-ade4fe76b7d8@roeck-us.net>
Message-ID: <20170628123212.GP17844@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 07:30:38PM -0700, Guenter Roeck wrote:
> drivers/pci/host/pci-versatile.c: In function 'versatile_pci_probe':
> drivers/pci/host/pci-versatile.c:131:38: error: 'dev' undeclared
>   bridge = devm_pci_alloc_host_bridge(dev, 0);

We fixed this yesterday, but I haven't put it into -next yet (I wanted
the autobuilder to have a crack at it first):

https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?h=pci/host-versatile&id=7a530532567f059f87671cae798c5cd9f32865ed
