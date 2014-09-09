From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 23:09:36 +0200
Subject: [PATCH v2 2/2] PCI: keystone: update to support multiple pci ports
In-Reply-To: <540F6646.3010607@ti.com>
References: <1410293835-13050-1-git-send-email-m-karicheri2@ti.com>
 <3294679.puV171E8qx@wuerfel> <540F6646.3010607@ti.com>
Message-ID: <9042477.aRbAhpkfQ5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 16:42:46 Murali Karicheri wrote:
> >>
> >>      /* update the Vendor ID */
> >> -    vendor_device_id = readl(ks_pcie->va_reg_pciid);
> >> -    writew((vendor_device_id>>  16), pp->dbi_base + PCI_DEVICE_ID);
> >> +    writew(ks_pcie->device_id, pp->dbi_base + PCI_DEVICE_ID);
> >>
> >>      /* update the DEV_STAT_CTRL to publish right mrrs */
> >>      val = readl(pp->dbi_base + PCIE_CAP_BASE + PCI_EXP_DEVCTL);
> >
> > This change must have slipped in accidentally, at least it's not
> > described in the changelog. Should this be another patch?
> > The change seems useful.
> Are you referring to mrrs or update to device id?  device id is in a SoC 
> register at index2 and is read and updated by the driver here. MRRS 
> update was originally in the code.
> 

I meant the device id change. Maybe you accidentally did 'git commit
--amend' during a rebase and that replaced the real changelog with
the one of the patch in front of it and merged the two patches?

That happened to me a few times and would explain the strange mix
of two changes.

	Arnd
