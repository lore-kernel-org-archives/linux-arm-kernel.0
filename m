From: will.deacon@arm.com (Will Deacon)
Date: Tue, 15 Sep 2015 18:53:27 +0100
Subject: [PATCH 6/6] PCI: generic: Allow bus default MSI controller to be
 specified.
In-Reply-To: <1442013719-5001-7-git-send-email-ddaney.cavm@gmail.com>
References: <1442013719-5001-1-git-send-email-ddaney.cavm@gmail.com>
 <1442013719-5001-7-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20150915175327.GM31157@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 12, 2015 at 12:21:59AM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> If the device tree node for the bus has a "msi-parent" property, use
> that as the default MSI controller for devices on the bus.  Add device
> tree binding documentation describing the new property.
> 
> This allows the pci-host-generic driver to be used in systems with
> multiple MSI controllers.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  .../devicetree/bindings/pci/host-generic-pci.txt          |  5 +++++
>  drivers/pci/host/pci-host-generic.c                       | 15 +++++++++++++--
>  2 files changed, 18 insertions(+), 2 deletions(-)

I don't think you need this anymore with 4.3-rc1. The core IRQ subsystem
should take care of parsing and configuring the MSI parents.

Will
