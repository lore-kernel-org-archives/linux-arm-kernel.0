From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 12 Oct 2016 07:36:21 -0500
Subject: [PATCH v2 0/2] PCI: aardvark: Cleanup
Message-ID: <20161012123001.22186.4053.stgit@bhelgaas-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add local "dev" pointers to reduce repetition of things like "&pdev->dev"
and remove unused drvdata.

Changes from v1:
  I dropped the following because they added a lot of churn for
  questionable benefit:
    PCI: aardvark: Name private struct pointer "advk" consistently
    PCI: aardvark: Reorder accessor functions
    PCI: aardvark: Swap order of advk_write() reg/val arguments

---

Bjorn Helgaas (2):
      PCI: aardvark: Add local struct device pointers
      PCI: aardvark: Remove unused platform data


 drivers/pci/host/pci-aardvark.c |   39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)
