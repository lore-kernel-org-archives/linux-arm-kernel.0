From: Mohit.KUMAR@st.com (Mohit KUMAR DCG)
Date: Mon, 31 Mar 2014 13:25:53 +0800
Subject: [PATCH V7 00/10] PCI: Add SPEAr13xx PCie support
In-Reply-To: <CAErSpo4pr5GC65pphxDUJGfep+yY06C8+RBmhygJPPQ7O5CD_g@mail.gmail.com>
References: <cover.1393568715.git.mohit.kumar@st.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FEB12EE3@EAPEX1MAIL1.st.com>
 <CAErSpo6vAdXV+ObZNySiQjs-x3_TxEiYLG2ZPscmHVGVspE55w@mail.gmail.com>
 <CAAxdfz_pJ3HbKTQmAyFSM1Z+hu=31OOdQCdvdd3Nu_rpr_vC7g@mail.gmail.com>
 <CAErSpo4pr5GC65pphxDUJGfep+yY06C8+RBmhygJPPQ7O5CD_g@mail.gmail.com>
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FEB131C4@EAPEX1MAIL1.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas at google.com]
> Sent: Friday, March 28, 2014 9:56 PM
> To: Mark Nicholson
> Cc: Mohit KUMAR DCG; Arnd Bergmann (arnd at arndb.de); Bartlomiej
> Zolnierkiewicz
> Subject: Re: [PATCH V7 00/10] PCI: Add SPEAr13xx PCie support
> 
> Not from me.  It should be in patchwork
> (http://patchwork.ozlabs.org/project/linux-pci/list/), where you can
> download patches and apply manually.
> 
> If it's *not* in patchwork, it means I discarded it for some reason
> (superseded, changes requested, it wasn't sent to linux-pci, etc., and you
> should resend it so I'll remember to look at it.
> 
- Yes, I can find PCIe specific patch#8,10 here. I think rest of the 
patches should be coming through your tree.

Regards
Mohit

> On Fri, Mar 28, 2014 at 10:21 AM, Mark Nicholson <mark@nicholnet.com>
> wrote:
> > Great!  In the mean time, is there a place to download the patchset?
> >
> > Thanks!
> > ~Mark
> >
> >
> >
> > On Fri, Mar 28, 2014 at 7:53 AM, Bjorn Helgaas <bhelgaas@google.com>
> wrote:
> >>
> >> On Thu, Mar 27, 2014 at 10:37 PM, Mohit KUMAR DCG
> >> <Mohit.KUMAR@st.com>
> >> wrote:
> >> > Gentle Reminder!!
> >> >
> >> > Hello Bjorn,
> >> >
> >> > I am getting multiple queries on the availability of these patches(CC).
> >> > Could you pls pick up this series at least for your tree.
> >>
> >> I'll start merging things for v3.16 next week after v3.14 is released.
> >>  Don't worry, it's not forgotten :)
> >>
> >> Bjorn
> >>
> >> >> -----Original Message-----
> >> >> From: Mohit KUMAR DCG
> >> >> Sent: Friday, February 28, 2014 5:25 PM
> >> >> To: arnd at arndb.de
> >> >> Cc: Mohit KUMAR DCG
> >> >> Subject: [PATCH V7 00/10] PCI: Add SPEAr13xx PCie support
> >> >>
> >> >> Patch# 1 and 2: Improvement and fixes for SPEAr13xx support.
> >> >> Patch# 3,4 and 6: Add DT bindings for spear1310/40-miphy, misc and
> >> >> pcie node Patch# 5: Add spear1310/40-miphy driver and support for
> >> >> spear1310/40
> >> >> miphy wrapper.
> >> >> Patch# 7-9: Add SPEAr13xx PCIe driver and dt support.
> >> >>
> >> >> These pathes are tested with linux-3.14-rc1 with following patch
> >> >> on the top of
> >> >> it:
> >> >> Author: Balaji T K <balajitk@ti.com>
> >> >> Date:   Mon Jan 20 16:41:27 2014 +0200
> >> >>
> >> >>     ata: ahci_platform: Manage SATA PHY
> >> >>
> >> >> Tested with SPEAr1310 evaluation board:
> >> >>       - INTEL PRO 100/100 EP card
> >> >>       - USB xhci gen2 card
> >> >>       - Above cards connected through LeCROY PTC switch
> >> >>
> >> >> Modifications for SATA are tested with SPEAr1340-evb board
> >> >>
> >> >> Changes since v6:
> >> >> - Split miphy driver for SPEAr1310 and SPEAr1340
> >> >> - Some cleanup and incorporated other minor comments Changes
> since v5:
> >> >> - Split DT bindings for misc, miphy-40lp and pcie node into
> >> >> sepearte patches
> >> >> - Merge config options PCIE_SPEAR13XX and PCI_MSI into defconfig
> >> >> patch
> >> >> - Incorporated other minor comments Changes since v4:
> >> >> - Uses per device function pointers passed from .data field to
> >> >>   the of_device_id instead of of_device_is_compatible.
> >> >> - Incorporated other minor comments from v4
> >> >>
> >> >> Changes since v3:
> >> >> - Phy driver renamed to phy-miphy40lp
> >> >> - ahci phy hook patch used as suggested by Arnd
> >> >> - Incorporated other minor comments from v3
> >> >>
> >> >> Changes since v2:
> >> >> - Incorporated comments to move SPEAr13xx PCIe and SATA phy
> >> >> specific routines to
> >> >>   the phy framework
> >> >> - Modify ahci driver to include phy hooks
> >> >> - phy-core driver modifications for subsys_initcall()
> >> >>
> >> >> Changes since v1:
> >> >> - Few patches of the series are already accepted and applied to
> >> >> mainline e.g.
> >> >>  pcie designware driver improvements,fixes for IO translation bug,
> >> >> PCIe dw driver maintainer. So dropped these from v2.
> >> >> - Incorporated comment to move the common/reset PCIe code to the
> >> >> seperate driver
> >> >> - PCIe and SATA share common PHY configuration registers, so move
> >> >> SATA platform code to the system config driver Fourth patch is
> >> >> improves pcie designware driver and fixes the IO translation bug.
> >> >> IO translation bug fix leads to the working of PCIe EP devices
> >> >> connected to RC through switch.
> >> >>
> >> >> Mohit Kumar (2):
> >> >>   SPEAr13xx: defconfig: Update
> >> >>   MAINTAINERS: Add ST SPEAr13xx PCIe driver maintainer
> >> >>
> >> >> Pratyush Anand (8):
> >> >>   clk: SPEAr13XX: Fix pcie clock name
> >> >>   SPEAr13XX: Fix static mapping table
> >> >>   phy: SPEAr1310/40-miphy: Add binding information
> >> >>   SPEAr: misc: Add binding information
> >> >>   phy: SPEAr1310/40-miphy: Add phy driver for PCIe and SATA
> >> >>   SPEAr13XX: Add binding information for PCIe controller
> >> >>   SPEAr13XX: dts: Add PCIe node information
> >> >>   pcie: SPEAr13xx: Add designware wrapper support
> >> >>
> >> >>  .../devicetree/bindings/arm/spear-misc.txt         |    9 +
> >> >>  .../devicetree/bindings/pci/spear13xx-pcie.txt     |   14 +
> >> >>  .../devicetree/bindings/phy/st-spear1310-miphy.txt |   12 +
> >> >>  .../devicetree/bindings/phy/st-spear1340-miphy.txt |   11 +
> >> >>  MAINTAINERS                                        |    6 +
> >> >>  arch/arm/boot/dts/spear1310-evb.dts                |    4 +
> >> >>  arch/arm/boot/dts/spear1310.dtsi                   |   93 +++++-
> >> >>  arch/arm/boot/dts/spear1340-evb.dts                |    4 +
> >> >>  arch/arm/boot/dts/spear1340.dtsi                   |   30 ++-
> >> >>  arch/arm/boot/dts/spear13xx.dtsi                   |    9 +-
> >> >>  arch/arm/configs/spear13xx_defconfig               |   16 +
> >> >>  arch/arm/mach-spear/Kconfig                        |    4 +
> >> >>  arch/arm/mach-spear/include/mach/spear.h           |    4 +-
> >> >>  arch/arm/mach-spear/spear1340.c                    |  127 +------
> >> >>  arch/arm/mach-spear/spear13xx.c                    |    2 +-
> >> >>  drivers/clk/spear/spear1310_clock.c                |    6 +-
> >> >>  drivers/clk/spear/spear1340_clock.c                |    2 +-
> >> >>  drivers/pci/host/Kconfig                           |    8 +
> >> >>  drivers/pci/host/Makefile                          |    1 +
> >> >>  drivers/pci/host/pcie-spear13xx.c                  |  414
> >> >> ++++++++++++++++++++
> >> >>  drivers/phy/Kconfig                                |   12 +
> >> >>  drivers/phy/Makefile                               |    2 +
> >> >>  drivers/phy/phy-spear1310-miphy.c                  |  274
> >> >> +++++++++++++
> >> >>  drivers/phy/phy-spear1340-miphy.c                  |  300
> >> >> ++++++++++++++
> >> >>  24 files changed, 1225 insertions(+), 139 deletions(-)  create
> >> >> mode
> >> >> 100644
> >> >> Documentation/devicetree/bindings/arm/spear-misc.txt
> >> >>  create mode 100644
> >> >> Documentation/devicetree/bindings/pci/spear13xx-
> >> >> pcie.txt
> >> >>  create mode 100644 Documentation/devicetree/bindings/phy/st-
> >> >> spear1310-miphy.txt
> >> >>  create mode 100644 Documentation/devicetree/bindings/phy/st-
> >> >> spear1340-miphy.txt
> >> >>  create mode 100644 drivers/pci/host/pcie-spear13xx.c  create mode
> >> >> 100644
> >> >> drivers/phy/phy-spear1310-miphy.c  create mode 100644
> >> >> drivers/phy/phy- spear1340-miphy.c
> >> >
> >
> >
