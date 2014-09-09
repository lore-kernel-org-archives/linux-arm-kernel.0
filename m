From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 09 Sep 2014 12:50:47 +0200
Subject: =?UTF-8?B?562U5aSNOg==?= [PATCH 2/2] PCI: Layerscape: Add
 Layerscape PCIe driver
In-Reply-To: <540F4B23.5040209@freescale.com>
References: <1409856338-1730-1-git-send-email-Minghuan.Lian@freescale.com>
 <6844751.zBSvS2zU47@wuerfel> <540F4B23.5040209@freescale.com>
Message-ID: <60096763.M59cqLJ4gm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 September 2014 18:46:59 Lian Minghuan-B31939 wrote:
> On 2014?09?09? 09:56, Arnd Bergmann wrote:
> > On Tuesday 09 September 2014 17:25:57 Lian Minghuan-B31939 wrote:
> >> [Minghuan] I discussed with my colleague. They worry about performance
> >> degradation if using regmap API,
> >> because there are some fast device use scfg. We tend to use a simple way
> >> to map andread/write scfg directly.
> >
> > I see. In this case, I would probably create a separate msi controller
> > driver that owns the "fsl,ls1021a-scfg" device, and is referenced
> > through the "msi-parent" property in the pcie controller.
> >
> > You can use of_pci_find_msi_chip_by_node() to get the msi_chip
> > instance and then connect that to your pci host. This will also
> > take care of the case where you may want to use the main GICv3
>
> > on a future SoC.
> [Minghuan] There is something wrong with LS1021A MSI hardware that it 
> only supports one interrupt not 32 interrupts.  Now, I do not want to 
> create a separate msi controller driver just for incorrect hardware.
> I may provide complete MSI driver for the new hardware when it is ready.

Would you just leave out MSI support for the LS1021A PCIe variant?
I guess that's fine because all device drivers should also support
legacy interrupts and there is no performance gain in MSI in this
case.

	Arnd
