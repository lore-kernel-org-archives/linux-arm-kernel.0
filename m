From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 25 Jun 2014 00:44:36 +0200
Subject: [PATCH 0/2] ARM: at91: remove phy fixup for sama5d3xek boards
Message-ID: <1403649878-28242-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch removes a board specific hook for sama5d3xek boards from the
sama5d3 generic DT board file.

This hook (which register a phy fixup configuring board specific delays
in the ksz9021 ethernet phy) is now replaced by the appropriate DT
properties definitions in the sama5d3xcm.dtsi file.

Best Regards,

Boris

Boris BREZILLON (2):
  ARM: at91/dt: describe rgmii ethernet phy connected to sama5d3xek
    boards
  ARM: at91: remove phy fixup for sama5d3xek boards

 arch/arm/boot/dts/sama5d3xcm.dtsi   | 16 ++++++++++++++++
 arch/arm/mach-at91/board-dt-sama5.c | 22 ----------------------
 2 files changed, 16 insertions(+), 22 deletions(-)

-- 
1.8.3.2
