From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 11 Mar 2018 19:00:00 +0300
Subject: [PATCH 0/8] Refresh Marvell BG2CD SoC support
Message-ID: <20180311160008.22928-1-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'd like to submit a few simple fixes and updates for Marvell BG2CD support
in mainline and Devicetree board file for the device I'm testing this on.

I've also submitted a one-bit fix for USB timeout issues on this board [1]
and a couple of one-line fixes for poor boot-time kernel warnings [2], [3].

Of course with support for DMA and audio/video subsystem entirely missing,
mainline is not very useful on this SoC right now, but nevertheless it may
be a good playground for the curious.

Thanks.

[1] https://patchwork.kernel.org/patch/10257793/
[2] https://patchwork.kernel.org/patch/10252479/
[3] http://patchwork.ozlabs.org/patch/883146/

Alexander Monakov (8):
  ARM: berlin: extend BG2CD Kconfig entry
  ARM: dts: berlin2cd: fix local timer interrupt flags
  ARM: dts: berlin2cd: move PMU node from soc to root
  ARM: dts: berlin2cd: add ADC/thermal sensor node
  ARM: dts: berlin2cd: add remaining Cortex-A9 nodes
  ARM: dts: berlin2cd: add remaining nodes to apb subtrees
  ARM: dts: berlin2cd: add a label for the CPU node
  ARM: dts: berlin2cd: add Valve Steam Link board

 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts |  80 ++++++++++++++
 arch/arm/boot/dts/berlin2cd.dtsi                | 134 ++++++++++++++++++++++--
 arch/arm/mach-berlin/Kconfig                    |   7 +-
 4 files changed, 214 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts

-- 
2.11.0
