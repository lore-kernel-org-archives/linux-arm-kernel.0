From: s-anna@ti.com (Suman Anna)
Date: Wed, 5 Mar 2014 18:24:09 -0600
Subject: [PATCH 00/10] arch/arm OMAP IOMMU patches for 3.15
Message-ID: <1394065459-16409-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul, Benoit,

This is a repost as per Tony's request [3] of all the OMAP IOMMU DT support
patches that are under arch/arm. The series just assimilates patches 8
through 13 from the v3 OMAP IOMMU DT adaptation for 3.15 series [1], and
all the v2 patches from the OMAP IOMMU DTS nodes [2].

The only change made with respect to the patches above is in the OMAP4
and OMAP5 DTS nodes - I have adjusted the reg sizes from 0xff to 0x100.

Can you please provide your acks on the hwmod patches and DTS
patches?

regards
Suman

[1] http://marc.info/?l=linux-omap&m=139362022805667&w=2
[2] http://marc.info/?l=linux-omap&m=139362062805816&w=2
[3] http://marc.info/?l=linux-omap&m=139404802021252&w=2

Florian Vaussard (4):
  ARM: OMAP3: remove deprecated CONFIG_OMAP_IOMMU_IVA2
  ARM: dts: OMAP3: Update ISP IOMMU node
  ARM: dts: OMAP3: Add IVA IOMMU node
  ARM: dts: OMAP4: Add IOMMU nodes

Suman Anna (6):
  ARM: OMAP3: fix iva mmu programming issues
  ARM: OMAP2+: change the ISP device archdata MMU name for DT
  ARM: OMAP2+: use pdata quirks for iommu reset lines
  ARM: OMAP5: hwmod data: add mmu data for ipu & dsp
  ARM: OMAP2+: extend iommu pdata-quirks to OMAP5
  ARM: dts: OMAP5: Add IOMMU nodes

 arch/arm/boot/dts/omap3.dtsi                | 15 ++++--
 arch/arm/boot/dts/omap4.dtsi                | 15 ++++++
 arch/arm/boot/dts/omap5.dtsi                | 15 ++++++
 arch/arm/mach-omap2/clockdomains3xxx_data.c |  2 +-
 arch/arm/mach-omap2/devices.c               |  3 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c  | 12 ++---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c  | 83 +++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pdata-quirks.c          | 24 +++++++++
 arch/arm/plat-omap/Kconfig                  |  3 --
 9 files changed, 157 insertions(+), 15 deletions(-)

-- 
1.9.0
