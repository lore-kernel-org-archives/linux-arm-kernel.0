From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 15 May 2017 10:16:42 +0200
Subject: [PATCH v4 0/2] Tango PCIe controller support
In-Reply-To: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
References: <d054300a-5891-0a25-8726-2be6b1beff6c@sigmadesigns.com>
Message-ID: <f65112f3-f958-3f87-5527-fcba34975576@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/04/2017 16:24, Marc Gonzalez wrote:

> This patch was split in two, to ease review of two orthogonal
> parts (MSI controller and host bridge). NB: the patch is
> just split in two where host bridge support starts.
> 
> Changes from v3 to v4
> 
> In the MSI part:
> - Support 256 MSIs instead of only 32
> - Define tango_{ack,mask,unmask} callbacks for the HW irq_chip
> - Use a spinlock instead of a mutex
> - Rename msi_mask register to msi_enable
> 
> In the host bridge part:
> - Move several quirk-handling snippets out of the config space read function
> - Check whether the PCIe link is up at probe-time
> 
> Other files
> - Let the framework compute the bus-range from the config space width
> - Be slightly more verbose in the Kconfig help
> 
> 
> What has *not* changed, waiting from feedback from Bjorn:
> 
> - Pray that config and mem space accesses NEVER occur concurrently.
> - Using of_device_is_compatible() vs of_device_get_match_data()
> 
> 
> Marc Gonzalez (2):
>   PCI: Add tango MSI controller support
>   PCI: Add tango PCIe host bridge support
> 
>  Documentation/devicetree/bindings/pci/tango-pcie.txt |  32 ++++
>  drivers/pci/host/Kconfig                             |   8 +
>  drivers/pci/host/Makefile                            |   1 +
>  drivers/pci/host/pcie-tango.c                        | 393 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci_ids.h                              |   2 +
>  5 files changed, 436 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/tango-pcie.txt
>  create mode 100644 drivers/pci/host/pcie-tango.c

Now that Linus has closed the merge window for v4.12, I hope that this
driver can be accepted in v4.13 ?

Regards.
