From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat,  9 Nov 2013 13:23:52 +0100
Subject: [PATCH 0/7] ARM: shmobile: Use interrupt macros in DT files
Message-ID: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series replaces all numerical IRQ types by the corresponding
IRQ_TYPE_* macros in device tree sources. It starts by switching from
/include/ to #include (1/7), replacing numerical types by macros in SoC DT
files (2/7) and board DT files (3/7), and fixing several boards that use a
defined IRQ type instead of IRQ_TYPE_NONE.

The changes have been tested on the armadillo and marzen boards.

Laurent Pinchart (7):
  ARM: shmobile: Use #include in device tree sources
  ARM: shmobile: Use interrupt macros in SoC DT files
  ARM: shmobile: Use interrupt macros in board DT files
  ARM: shmobile: marzen-reference: Use falling edge IRQ for LAN9221
  ARM: shmobile: bockw-reference: Use falling edge IRQ for LAN9221
  ARM: shmobile: kzm9g-reference: Use falling edge IRQ for LAN9221
  ARM: shmobile: armadillo-reference: Use low level IRQ for ST1231

 arch/arm/boot/dts/r7s72100-genmai.dts              |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |   2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |   5 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 108 ++++++++++++-----
 .../boot/dts/r8a7740-armadillo800eva-reference.dts |   5 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   2 +-
 arch/arm/boot/dts/r8a7740.dtsi                     | 106 ++++++++---------
 arch/arm/boot/dts/r8a7778-bockw-reference.dts      |   5 +-
 arch/arm/boot/dts/r8a7778-bockw.dts                |   2 +-
 arch/arm/boot/dts/r8a7778.dtsi                     |  44 +++----
 arch/arm/boot/dts/r8a7779-marzen-reference.dts     |   5 +-
 arch/arm/boot/dts/r8a7779-marzen.dts               |   2 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |  42 +++----
 arch/arm/boot/dts/r8a7790-lager-reference.dts      |   2 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |   2 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  58 +++++-----
 arch/arm/boot/dts/r8a7791-koelsch-reference.dts    |   2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts              |   2 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  49 ++++----
 arch/arm/boot/dts/sh7372-mackerel.dts              |   2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   5 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   2 +-
 arch/arm/boot/dts/sh73a0.dtsi                      | 128 +++++++++++----------
 23 files changed, 325 insertions(+), 257 deletions(-)

-- 
Regards,

Laurent Pinchart
