From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 4 Sep 2014 07:24:34 -0600
Subject: [PATCH 2/2] PCI: Layerscape: Add Layerscape PCIe driver
In-Reply-To: <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <1409856338-1730-2-git-send-email-Minghuan.Lian@freescale.com>
Message-ID: <CAErSpo5kFkF-JoUj-Ean7VXa4gxYW+q-X89+7ahyEymWpxxQ2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 12:45 PM, Minghuan Lian
<Minghuan.Lian@freescale.com> wrote:
> Add support for Freescale Layerscape PCIe controller. This driver
> re-uses the designware core code.
>
> Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
> ---
>  .../devicetree/bindings/pci/fsl,ls-pcie.txt        |  41 +++
>  drivers/pci/host/Kconfig                           |   7 +
>  drivers/pci/host/Makefile                          |   1 +
>  drivers/pci/host/pci-layerscape.c                  | 315 +++++++++++++++++++++
>  include/linux/pci_ids.h                            |   1 +
>  5 files changed, 365 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/fsl,ls-pcie.txt
>  create mode 100644 drivers/pci/host/pci-layerscape.c

> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6ed0bb7..26d4c30 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2442,6 +2442,7 @@
>  #define PCI_DEVICE_ID_P5020            0x0421
>  #define PCI_DEVICE_ID_P5010E           0x0428
>  #define PCI_DEVICE_ID_P5010            0x0429
> +#define PCI_DEVICE_ID_LS1021A          0x0e0b

This is only used in one file and should not be in pci_ids.h (per the
comment at the top of pci_ids.h).

>  #define PCI_DEVICE_ID_MPC8641          0x7010
>  #define PCI_DEVICE_ID_MPC8641D         0x7011
>  #define PCI_DEVICE_ID_MPC8610          0x7018
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
