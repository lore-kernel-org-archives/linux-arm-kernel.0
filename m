From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  1 Nov 2017 11:35:06 +0100
Subject: [PATCH 0/2] dts: renesas: r8a77995: IPMMU upstream integration
Message-ID: <20171101103508.7721-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds DT nodes for IPMMU instances on r8a77995 together with
connections to the r8a77995 on-chip device Ethernet-AVB.

With these patches applied a white list enabled IPMMU driver may be used
to check silicon revision and then enable IPMMU in the known working cases.

The recommended IPMMU driver patch is iommu/next with the following applied:
 [PATCH v5 00/09] iommu/ipmmu-vmsa: r8a7795 support V5
 [PATCH v4 0/3] iommu/ipmmu-vmsa: r8a7796 support V4
 [PATCH 0/2] iommu/ipmmu-vmsa: r8a779(70|95) support

A patch to enable IPMMU devices is not included in this series
as Ethernet-AVB, the only device to which IPMMU is hooked up to,
is disabled.

The DT binding for r8a77995 has been submitted (as part of the
r8a779(70|95) series noted above) in conjunction with this patchset.

This is based on work by Magnus Damm.

Based on renesas-devel-20171101-v4.14-rc7

Simon Horman (2):
  arm64: dts: renesas: r8a77995: Add IPMMU device nodes
  arm64: dts: renesas: r8a77995: Connect Ethernet-AVB to IPMMU-RT

 arch/arm64/boot/dts/renesas/r8a77995.dtsi | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

-- 
2.11.0
