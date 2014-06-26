From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 26 Jun 2014 12:13:33 +0200
Subject: [PATCH v2 0/2] ARM: at91: remove phy fixup for sama5d3xek boards
Message-ID: <1403777615-25685-1-git-send-email-boris.brezillon@free-electrons.com>
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

Changes since v1:
 - fix txc-skew-ps and rxc-skew-ps delays
 - remove phy address info to handle Ronetix and Embest HW designs

Boris BREZILLON (2):
  ARM: at91/dt: describe rgmii ethernet phy connected to sama5d3xek
    boards
  ARM: at91: remove phy fixup for sama5d3xek boards

 arch/arm/boot/dts/sama5d3xcm.dtsi   | 15 +++++++++++++++
 arch/arm/mach-at91/board-dt-sama5.c | 22 ----------------------
 2 files changed, 15 insertions(+), 22 deletions(-)

-- 
1.8.3.2
