From: jcm@redhat.com (Jon Masters)
Date: Fri, 2 Dec 2016 00:50:47 -0500
Subject: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
In-Reply-To: <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <e5b1f09c-ca4c-fbf0-e9d7-c943ad0df2ff@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2016 07:28 PM, Bjorn Helgaas wrote:

> I'm hoping to end up with something like this:
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?h=pci/ecam&id=51ad4df79a9b7f2a66b346a46b21a785a2937469

The following build warnings happen using your branch on RHELSA7.3:

drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
  THUNDER_PEM_QUIRK(2,  0), /* off-chip devices */
  ^
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[44].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[44].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[45].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[45].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[46].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[46].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[47].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[47].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[48].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[48].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[49].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:101:2: warning: (near initialization for ?mcfg_quirks[49].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
  THUNDER_PEM_QUIRK(2,  1), /* off-chip devices */
  ^
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[50].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[50].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[51].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[51].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[52].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[52].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[53].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[53].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[54].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[54].cfgres.end?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[55].cfgres.start?) [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: left shift count >= width of type [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: initializer element is not a constant expression [enabled by default]
drivers/acpi/pci_mcfg.c:102:2: warning: (near initialization for ?mcfg_quirks[55].cfgres.end?) [enabled by default]

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
