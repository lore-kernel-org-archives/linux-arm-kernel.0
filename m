From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:35:00 +0100
Subject: [PATCH 0/4] arm64: dts: renesas: r8a7796: IPMMU upstream integration
Message-ID: <20171101103504.7658-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT nodes for IPMMU instances on r8a77970 together with
connections to r8a77970 on-chip devices: SYS-DMAC and Ethernet-AVB.

With these patches applied a white list enabled IPMMU driver may be used
to check silicon revision and then enable IPMMU in the known working cases.

The recommended IPMMU driver patch is iommu/next with the following applied:
 [PATCH v5 00/09] iommu/ipmmu-vmsa: r8a7795 support V5
 [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
 [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support

The final patch in the series enable IPMMU support for all IPMMU
instances on r8a77970 that are used by IPMMU devices listed above.

The DT binding for r8a77970 are been submitted (as part of the
r8a779(70|95) series noted above) in conjunction with this patchset.

This is based on work by Magnus Damm.

Based on renesas-devel-20171101-v4.14-rc7

Simon Horman (4):
  arm64: dts: renesas: r8a77970: Add IPMMU device nodes
  arm64: dts: renesas: r8a77970: Tie SYS-DMAC to IPMMU-DS1
  arm64: dts: renesas: r8a77970: Connect Ethernet-AVB to IPMMU-RT
  arm64: dts: renesas: r8a77970: Enable IPMMU-DS1, RT and MM

 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 47 +++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

-- 
2.11.0
