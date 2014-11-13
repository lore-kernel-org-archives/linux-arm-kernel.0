From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 13 Nov 2014 11:09:59 -0700
Subject: [PATCH V2 0/2] PCI: generic: Assiging msi-controller to PCI
 hostbridge
In-Reply-To: <1415733454-24322-1-git-send-email-suravee.suthikulpanit@amd.com>
References: <1415733454-24322-1-git-send-email-suravee.suthikulpanit@amd.com>
Message-ID: <20141113180959.GR5064@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[+cc Yijing]

On Tue, Nov 11, 2014 at 01:17:32PM -0600, suravee.suthikulpanit at amd.com wrote:
> From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> 
> This patch set introduces a new callback function to allow PCI host drivers
> to specify MSI controller to be used for the child buses / devices.

Hi Suravee, 

As Srikanth mentioned, there's a series of MSI-related stuff from Yijing.
I recently put them on my pci/msi branch, and they overlap a bit with
what you're doing here.

So I'll drop these for now.  Maybe there's a way you can accomplish what
you need by implementing pcibios_msi_controller(), which Yijing added?

Also note that "msi-controller" is already being used in device tree (see
Documentation/devicetree/bindings/interrupt-controller/marvell), so maybe
you can do the name.

Bjorn

> This is reabased from:
>     git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-generic
> 
> Changes from V1:
>     - Adding "msi-parent" device tree binding in documentation.
>     - Rebase the patch to get rid of artifacts from other precursor patch
>       accidently applied to the developement tree. This should now apply cleanly
>       to the pci/host-generic branch.
> 
> Suravee Suthikulpanit (2):
>   PCI: Add new pci_ops for setting MSI parent for PCI bus
>   PCI: generic: Add set_msi_parent callback
> 
>  Documentation/devicetree/bindings/pci/host-generic-pci.txt |  3 +++
>  drivers/pci/host/pci-host-generic.c                        | 13 +++++++++++++
>  drivers/pci/probe.c                                        |  3 +++
>  include/linux/pci.h                                        |  1 +
>  4 files changed, 20 insertions(+)
> 
> -- 
> 1.9.3
> 
