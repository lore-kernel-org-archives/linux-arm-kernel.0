From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Tue, 11 Nov 2014 13:17:32 -0600
Subject: [PATCH V2 0/2] PCI: generic: Assiging msi-controller to PCI hostbridge
Message-ID: <1415733454-24322-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

This patch set introduces a new callback function to allow PCI host drivers
to specify MSI controller to be used for the child buses / devices.

This is reabased from:
    git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/host-generic

Changes from V1:
    - Adding "msi-parent" device tree binding in documentation.
    - Rebase the patch to get rid of artifacts from other precursor patch
      accidently applied to the developement tree. This should now apply cleanly
      to the pci/host-generic branch.

Suravee Suthikulpanit (2):
  PCI: Add new pci_ops for setting MSI parent for PCI bus
  PCI: generic: Add set_msi_parent callback

 Documentation/devicetree/bindings/pci/host-generic-pci.txt |  3 +++
 drivers/pci/host/pci-host-generic.c                        | 13 +++++++++++++
 drivers/pci/probe.c                                        |  3 +++
 include/linux/pci.h                                        |  1 +
 4 files changed, 20 insertions(+)

-- 
1.9.3
