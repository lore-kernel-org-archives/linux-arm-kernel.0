From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 29 Nov 2016 15:39:48 -0600
Subject: [PATCH v2] PCI: Add information about describing PCI in ACPI
Message-ID: <20161129212816.15663.28100.stgit@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's another stab at this writeup.  I'd appreciate any comments!

Changes from v1 to v2:
  - Consumer/Producer is defined for Extended Address Space descriptors;
    should be ignored for QWord/DWord/Word Address Space descriptors
  - New arches may use Extended Address Space descriptors in PNP0A03 for
    bridge registers, including ECAM (if the arch adds support for this)
  - Add more details about MCFG and _CBA (Lv's suggestion)
  - Incorporate Rafael's suggestions

---

Bjorn Helgaas (1):
      PCI: Add information about describing PCI in ACPI


 Documentation/PCI/00-INDEX      |    2 
 Documentation/PCI/acpi-info.txt |  180 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+)
 create mode 100644 Documentation/PCI/acpi-info.txt
