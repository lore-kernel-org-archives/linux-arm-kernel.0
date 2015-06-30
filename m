From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 30 Jun 2015 16:20:19 +0200
Subject: [PATCH v4 0/3] Fix Ethernet jumbo frames support for Armada 370 and
 38x
Message-ID: <1435674022-13295-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes the Ethernet jumbo frames support for the SoCs
Armada 370, 380 and 385. Unlike Armada XP, the Ethernet controller for
this SoCs don't support TCP/IP checksumming with a frame size larger
than 1600 bytes.

This patches should be applied to the -stable kernels 3.8 and onwards.

Changes since v1:
- Use a new compatible string for the Ethernet IP found in Armada XP
  SoCs (instead of using an optional property).
- Fix the issue for the Armada 380 and 385 SoCs as well.

Changes since v2:
- Add Acked-by from Gregory Clement.
- Add "Fixes:" tag to each commits.

Changes since v3:
- Fix patch 3 name: replace prefix "ARM: mvebu:" with "net: mvneta:".

Regards,

Simon

Simon Guinot (3):
  net: mvneta: introduce compatible string "marvell,armada-xp-neta"
  ARM: mvebu: update Ethernet compatible string for Armada XP
  net: mvneta: disable IP checksum with jumbo frames for Armada 370

 .../bindings/net/marvell-armada-370-neta.txt       |  2 +-
 arch/arm/boot/dts/armada-370-xp.dtsi               |  2 --
 arch/arm/boot/dts/armada-370.dtsi                  |  8 +++++++
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  2 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  2 +-
 arch/arm/boot/dts/armada-xp.dtsi                   | 10 +++++++-
 drivers/net/ethernet/marvell/mvneta.c              | 27 +++++++++++++++++++++-
 7 files changed, 46 insertions(+), 7 deletions(-)

-- 
2.1.4
