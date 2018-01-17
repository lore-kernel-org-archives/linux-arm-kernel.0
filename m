From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 17 Jan 2018 17:17:01 +0100
Subject: [PATCH v2 0/16] ARM: r8a7790: add soc node
Message-ID: <20180117161717.14589-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset adds an soc node, moves all nodes for IP blocks with an
address on the bus to be sub nodes of the soc node, and sorts subnodes of
the root and soc nodes.

The use of an soc node is consistent with handling of R-Car Gen3, RZ/G1,
and R-Car V2H (R8A77920) SoCs upstream. This patch-set adds it for all
other R-Car Gen2 SoCs: r8a7790 (H2), r8a7791 (M2-W), r8a7793 (M2-N),
r8a7794 (E2).

Sorting of nodes is also done for the R-Car V2H (R8A77920), making it
consistent across all R-Car Gen2 SoCs and thus allowing easier comparison
of DTs of different R-Car Gen2 SoCs.

The patchset also fixes some minor whitespace problems.

Based on renesas-devel-20180116-v4.15-rc8.

Tested on r8a7790 (H2) / Lager, r8a7791 (M2-W) / Koelsch and
r8a7794 (E2)/ Alt.

As this patchset contains patches with large numbers of lines changed I
have also pushed it to the topic/rcar-gen2-soc-node branch of my renesas
tree on kernel.org.

Simon Horman (16):
  ARM: dts: r8a7790: consistently use single space after =
  ARM: dts: r8a7790: add soc node
  ARM: dts: r8a7790: sort subnodes of soc node
  ARM: dts: r8a7790: sort subnodes of root node
  ARM: dts: r8a7791: consistently use single space after =
  ARM: dts: r8a7791: add soc node
  ARM: dts: r8a7791: sort subnodes of root node
  ARM: dts: r8a7792: sort subnodes of soc node
  ARM: dts: r8a7793: consistently use single space after =
  ARM: dts: r8a7793: add soc node
  ARM: dts: r8a7793: sort subnodes of soc node
  ARM: dts: r8a7793: sort subnodes of root node
  ARM: dts: r8a7794: consistently use single space after =
  ARM: dts: r8a7794: add soc node
  ARM: dts: r8a7794: sort subnodes of soc node
  ARM: dts: r8a7794: sort subnodes of root node

 arch/arm/boot/dts/r8a7790.dtsi | 2837 +++++++++++++++++++-------------------
 arch/arm/boot/dts/r8a7791.dtsi | 2986 ++++++++++++++++++++--------------------
 arch/arm/boot/dts/r8a7792.dtsi |  498 +++----
 arch/arm/boot/dts/r8a7793.dtsi | 2392 ++++++++++++++++----------------
 arch/arm/boot/dts/r8a7794.dtsi | 2421 ++++++++++++++++----------------
 5 files changed, 5694 insertions(+), 5440 deletions(-)

-- 
2.11.0
