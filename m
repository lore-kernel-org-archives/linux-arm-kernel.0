From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sat,  4 Nov 2017 19:39:08 +0800
Subject: [GIT PULL] ARM: realtek: dt64 for v4.15
Message-ID: <20171104113908.9748-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here's a (late) dt64 pull for Realtek.
Contains two new board DTs and a generalization of the SoC DT.

Regards,
Andreas

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-realtek.git tags/realtek-arm64-dt-for-4.15

for you to fetch changes up to a9ce6f854581aa7c39fd94f965658aa4e7ff7892:

  arm64: dts: realtek: Add MeLE V9 (2017-10-26 16:24:38 +0900)

----------------------------------------------------------------
Realtek ARM64 based SoC DT for v4.15

This refactors the RTD1295 DT, preparing for (but not yet adding)
RTD1293 and RTD1296. Superfluous reg property entries are dropped.
DTs for PROBOX2 AVA and MeLE V9 TV boxes are added.

----------------------------------------------------------------
Andreas F?rber (8):
      arm64: dts: realtek: Clean up RTD1295 UART reg property
      dt-bindings: Add vendor prefix for ProBox2
      dt-bindings: arm: realtek: Add ProBox2 AVA
      arm64: dts: realtek: Add ProBox2 Ava
      arm64: dts: realtek: Factor out common RTD129x parts
      dt-bindings: Add vendor prefix for MeLE
      dt-bindings: arm: realtek: Document MeLE V9
      arm64: dts: realtek: Add MeLE V9

 Documentation/devicetree/bindings/arm/realtek.txt  |  2 +
 .../devicetree/bindings/vendor-prefixes.txt        |  2 +
 arch/arm64/boot/dts/realtek/Makefile               |  2 +
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts    | 31 ++++++++++
 .../arm64/boot/dts/realtek/rtd1295-probox2-ava.dts | 31 ++++++++++
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |  6 --
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           | 62 ++-----------------
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           | 72 ++++++++++++++++++++++
 8 files changed, 144 insertions(+), 64 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-probox2-ava.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd129x.dtsi
