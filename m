From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Nov 2015 11:23:47 +0900
Subject: [PATCH 0/4] ARM: shmobile: Use SoC specific binding for rcar-dmac
 nodes
Message-ID: <1447381431-2255-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the new SoC specific binding for rcar-dmac and the generic
binding as a fall-back in the r8a779[0134] device trees.

In general Renesas hardware is not documented to the extent where the
relationship between IP blocks on different SoCs can be assumed although
they may appear to operate the same way. Furthermore the documentation
typically does not specify a version for individual IP blocks. For these
reasons a convention of using the SoC name in place of a version and
providing SoC-specific compat strings has been adopted.

Although not universally liked this convention is used in the bindings for
most drivers for Renesas hardware. The purpose of this patch is to
update the Renesas R-Car DMA Controller nodes to follow this convention.

Simon Horman (4):
  ARM: shmobile: r8a7790: Use SoC specific binding for rcar-dmac nodes
  ARM: shmobile: r8a7791: Use SoC specific binding for rcar-dmac nodes
  ARM: shmobile: r8a7793: Use SoC specific binding for rcar-dmac nodes
  ARM: shmobile: r8a7794: Use SoC specific binding for rcar-dmac nodes

 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++----
 arch/arm/boot/dts/r8a7791.dtsi | 8 ++++----
 arch/arm/boot/dts/r8a7793.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7794.dtsi | 4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.1.4
