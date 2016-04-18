From: tn@semihalf.com (Tomasz Nowicki)
Date: Mon, 18 Apr 2016 14:21:57 +0200
Subject: [PATCH V6 11/13] pci, acpi: Match PCI config space accessors
 against platfrom specific quirks.
In-Reply-To: <5714C6F6.8050600@huawei.com>
References: <1460740008-19489-1-git-send-email-tn@semihalf.com>
 <1460740008-19489-12-git-send-email-tn@semihalf.com>
 <5714C6F6.8050600@huawei.com>
Message-ID: <5714D165.4020606@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18.04.2016 13:37, liudongdong (C) wrote:
> Hi Tomasz
>
> I merged my patchset to branch topci-acpi-v6.
> The patchset is used for Hisilicon DO2 PCIe ACPI support.
> I found some compile errors. The log as below.
> drivers/pci/host/pcie-hisi-acpi.c: In function 'hisi_pcie_init':
> drivers/pci/host/pcie-hisi-acpi.c:130:6: error: 'struct acpi_pci_root'
> has no member named 'sysdata'
>    root->sysdata = reg_base;
>
> In your PATCH V5, add "sysdata" for strcut acpi_pci_root, but PATCH V6
> has not add it.
> In my patch, I used root->sysdata which will be available along
> read/write accessor.
> I want to know the reason this v6 patchset does not add "sysdata". I
> need this.

We are handling this different way. You can now use "struct 
pci_config_window" -> priv, see pci-thunder-pem.c driver.

Tomasz
