From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 20 Dec 2017 13:14:42 +0100
Subject: [PATCH 0/3] ARM: dts: renesas: Reduce size of thermal registers
Message-ID: <20171220121445.31896-1-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reduce size of thermal registers in DT for the following SoCs:
* r8a7790 (R-Car H2)
* r8a7791 (R-Car M3-W)
* r8a7793 (R-Car M3-N)

According to the "User's Manual: Hardware" v2.00 the registers at base
0xe61f0000 extend to an offset of 0x10, rather than 0x14 which is the case
on the r8a73a4 (R-Mobile APE6).

This should not have any runtime affect as mapping granularity is PAGE_SIZE.

As pointed out by Geert Uytterhoeven.

Based on renesas-devel-20171220-v4.15-rc4

Simon Horman (3):
  ARM: dts: r8a7790: Reduce size of thermal registers
  ARM: dts: r8a7791: Reduce size of thermal registers
  ARM: dts: r8a7793: Reduce size of thermal registers

 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/r8a7793.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.11.0
