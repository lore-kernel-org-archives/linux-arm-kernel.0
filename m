From: erin.lo@mediatek.com (erin.lo at mediatek.com)
Date: Wed, 23 Sep 2015 16:56:08 +0800
Subject: [PATCH 0/2] Add basic support for Mediatek MT2701 SoC
Message-ID: <1442998570-54031-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2701 is a SoC based on 32bit ARMv7 architecture. It contains 4 CA7 cores.
MT2701 share many HW IP with MT65xx series. This patchset was tested
on MT2701 evaluation board, and boot to shell ok.

This series contains document bindings, device tree including
interrupt, uart, timer and wdt.

Erin Lo (2):
  Document: DT: Add bindings for mediatek MT2701 SoC Platform
  ARM: dts: mediatek: add MT2701 basic support

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../bindings/arm/mediatek/mediatek,sysirq.txt      |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |   5 +-
 .../bindings/timer/mediatek,mtk-timer.txt          |   5 +-
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   6 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mt2701-evb.dts                   |  29 ++++
 arch/arm/boot/dts/mt2701.dtsi                      | 146 +++++++++++++++++++++
 8 files changed, 192 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt2701-evb.dts
 create mode 100644 arch/arm/boot/dts/mt2701.dtsi
