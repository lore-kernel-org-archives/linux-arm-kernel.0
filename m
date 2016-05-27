From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Fri, 27 May 2016 06:10:37 -0400
Subject: [PATCH v2 0/4] hw rng support for NSP SoC
Message-ID: <1464343841-29504-1-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the hw random number generator support for the
Broadcom's NSP SoC. The block is similar to the block available in
bcm2835 with different default interrupt mask value. Due to lack of
documentation, I cannot confirm the interrupt mask register details
in bcm2835. In an effort to not break the existing functionality of
bcm2835, I used a different compatible string to mask the interrupt
for NSP SoC. Please let me know. Also supported providing requested
number of random numbers instead of static size of four bytes.

The first patch contains the documentation changes and the second patch
contains the support for rng available in NSP SoC. The third patch
contains the device tree changes for NSP SoC. The fourth patch contains
the support for reading requested number of random numbers.

This patch set has been tested on NSP bcm958625HR board.
This patch set is based on v4.6.0-rc1 and is available from github
repo: https://github.com/Broadcom/cygnus-linux.git
branch: nsp-rng-v2

Changes since v1

Addressed the review comments from Eric
Added acked by Eric

Yendapally Reddy Dhananjaya Reddy (4):
  dt-bindings: rng: Northstar Plus SoC rng bindings
  hwrng: bcm2835: Support Broadcom NSP SoC rng
  ARM: dts: nsp: Add rng device tree entry
  hwrng: bcm2835: Read as much data as available

 .../devicetree/bindings/rng/brcm,bcm2835.txt       |  7 +++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  5 +++
 drivers/char/hw_random/Kconfig                     |  2 +-
 drivers/char/hw_random/bcm2835-rng.c               | 46 +++++++++++++++++++---
 4 files changed, 52 insertions(+), 8 deletions(-)

-- 
2.1.0
