From: simon.guinot@sequanux.org (Simon Guinot)
Date: Mon, 15 Jun 2015 16:27:21 +0200
Subject: [PATCH 0/2] Fix Ethernet jumbo frames support for Armada 370
Message-ID: <1434378443-23029-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series fixes the Ethernet jumbo frames support for Armada 370
SoCs. Unlike Armada XP, the Ethernet controller in Armada 370 SoCs don't
support TCP/IP checksumming with frames largest than 1600 Bytes.

This patches should be applied to the -stable kernels 3.8 and onwards.

Regards,

Simon

Simon Guinot (2):
  net: mvneta: introduce tx_csum_limit property
  ARM: mvebu: disable IP checksum with jumbo frames for Armada 370

 .../bindings/net/marvell-armada-370-neta.txt       |  3 +++
 arch/arm/boot/dts/armada-370.dtsi                  |  8 +++++++
 drivers/net/ethernet/marvell/mvneta.c              | 25 +++++++++++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

--
Cc: <stable@vger.kernel.org>
-- 
2.1.4
