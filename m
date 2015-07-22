From: s-anna@ti.com (Suman Anna)
Date: Tue, 21 Jul 2015 19:01:30 -0500
Subject: [PATCH 0/4] Add DRA7 IOMMU DT nodes
Message-ID: <1437523294-20058-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

The following patches add the basic DT nodes for the DSP
and IPU IOMMU devices for the DRA7xx SoC family. The first
two patches add syscon nodes for DSP_SYSTEM sub-modules, while
the last two add the IOMMU nodes.

The IPU IOMMU nodes mostly are similar to existing ones on OMAP4
and OMAP5. The DSP sub-system though has two MMUs, with a dedicated
MMU for the internal EDMA engine. On previous SoCs, a single MMU
served both the DSP processor and the internal EDMA. The DSP IOMMU
nodes require a new property to reference the syscon nodes, as they
each need a specific bit to be set in a register within the
corresponding DSP_SYSTEM sub-module. So, these are pending based
on the equivalent bindings update series [1]. Please let me know
if the binding looks ok to you, as this seems it can be done in
couple of ways.

Patches are based on 4.2-rc3.

regards
Suman

[1] http://marc.info/?l=linux-omap&m=143752295508435&w=2

Suman Anna (4):
  ARM: dts: DRA7: Add dsp1_system syscon node
  ARM: dts: DRA74x: Add dsp2_system syscon node
  ARM: dts: DRA7: Add common IOMMU nodes
  ARM: dts: DRA74x: Add IOMMU nodes for DSP2

 arch/arm/boot/dts/dra7.dtsi   | 45 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra74x.dtsi | 25 ++++++++++++++++++++++++
 2 files changed, 70 insertions(+)

-- 
2.4.4
