From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 09 Oct 2015 20:32:07 +0200
Subject: [PATCH v2 2/5] PCI: Add quirk for PLDA's XpressRICH3 host bridge
 class.
In-Reply-To: <1444409849-5685-3-git-send-email-Liviu.Dudau@arm.com>
References: <1444409849-5685-1-git-send-email-Liviu.Dudau@arm.com>
 <1444409849-5685-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <7335872.olmykfZgj7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 09 October 2015 17:57:26 Liviu Dudau wrote:
> +/*
> + * The PLDA's XpressRICH3 doesn't describe itself as a bridge. This is required
> + * for correct/normal enumeration.
> + */
> +static void xr3pci_quirk_class(struct pci_dev *pdev)
> +{
> +       pdev->class = PCI_CLASS_BRIDGE_PCI << 8;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_PLDA, PCI_DEVICE_ID_XR3PCI, xr3pci_quirk_class);
> 

Are you sure that this device ID is only used for the host bridge, not
for related devices in endpoint mode?

While we don't support PCIe endpoint drivers at the moment, it might
happen at some point and then things break when someone tries to
plug a machine with this ID into a Linux host.

	Arnd
