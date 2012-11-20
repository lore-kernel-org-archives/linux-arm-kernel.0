From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 20 Nov 2012 16:14:17 +0100
Subject: [GIT PULL v2] Marvell XOR driver DT changes
Message-ID: <1353424461-25421-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

Here is a new version of the "Marvell XOR driver DT changes" pull
request. Compared to the previous version, this v2:

 * Adds support for both XOR engines on Armada 370 and Armada XP. In
   the previous version, only one engine was listed in the
   DT. However, it turns out that XOR engines have different addresses
   on Armada 370 and Armada XP, so the DT bits have moved from
   armada-370-xp.dtsi to armada-370.dtsi and armada-xp.dtsi. I have
   therefore separated these additions in two patches, one for 370,
   one for XP.

 * Adds the correct 'clocks' property for Armada 370/XP so that the
   gatable XOR clocks are properly enabled as needed.

This pull request should be applied on top of:

 * The clk pull request "[GIT PULL v3] core, cpu and gated clocks for
   mvebu"

 * The XOR cleanup + DT binding pull request "[GIT PULL] Marvell XOR
   driver cleanup and DT binding".

Thanks!

The following changes since commit 34c93c8657935d30649e777c4aa05f74f16aa418:

  dma: mv_xor: Add a device_control function (2012-11-20 15:59:01 +0100)

are available in the git repository at:

  git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-xor-board-dt-changes-3.8-v2

for you to fetch changes up to a1d53dab4f5b37c800d7a20c56e84a96180a8ea6:

  arm: mvebu: add XOR engines to Armada XP .dtsi (2012-11-20 16:03:37 +0100)

----------------------------------------------------------------
Marvell XOR driver DT changes for 3.8

----------------------------------------------------------------
Andrew Lunn (1):
      arm: kirkwood: Convert XOR instantiation to DT.

Sebastian Hesselbarth (1):
      arm: dove: Convert Dove to DT XOR DMA engine

Thomas Petazzoni (2):
      arm: mvebu: add XOR engines to Armada 370 .dtsi
      arm: mvebu: add XOR engines to Armada XP .dtsi

 arch/arm/boot/dts/armada-370.dtsi |   36 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp.dtsi  |   40 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/dove.dtsi       |   42 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/kirkwood.dtsi   |   40 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-dove/common.c       |   10 ---------
 arch/arm/mach-kirkwood/board-dt.c |   13 ------------
 6 files changed, 158 insertions(+), 23 deletions(-)
