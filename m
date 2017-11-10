From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Nov 2017 14:25:48 +0100
Subject: [PATCH v2 0/5] arm64: dts: renesas: r8a77970: IPMMU upstream
 integration
Message-ID: <20171110132553.1461-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT nodes for IPMMU instances on r8a77970 together with
connections to r8a77970 on-chip devices: SYS-DMAC and Ethernet-AVB.

With these patches applied a white list enabled IPMMU driver may be used
to check silicon revision and then enable IPMMU in the known working cases.

The recommended test stack for this patchset is a merge of
* The iommu/next branch of the vfio tree
* renesas-devel-20171110-v4.14-rc8 tag of the renesas tree

With the following applied:
* [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
* [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support

The final patch in the series enable IPMMU support for all IPMMU
instances on r8a77970 that are used by IPMMU devices listed above.

The DT binding for r8a77970 are been submitted (as part of the
r8a779(70|95) series noted above) in conjunction with this patchset.

This is based on work by Magnus Damm.

Based on renesas-devel-20171110-v4.14-rc8

Changes since V1:
* Drop mostly redundant comments from nodes
* Add power domains
* Correct compat string used for IPMMU-DS1

Simon Horman (5):
  arm64: dts: renesas: r8a77970: sort includes
  arm64: dts: renesas: r8a77970: Add IPMMU device nodes
  arm64: dts: renesas: r8a77970: Tie SYS-DMAC to IPMMU-DS1
  arm64: dts: renesas: r8a77970: Connect Ethernet-AVB to IPMMU-RT
  arm64: dts: renesas: r8a77970: Enable IPMMU-DS1, RT and MM

 arch/arm64/boot/dts/renesas/r8a77970.dtsi | 57 +++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

-- 
2.11.0
