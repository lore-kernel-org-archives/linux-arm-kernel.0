From: erin.lo@mediatek.com (Erin Lo)
Date: Tue, 20 Oct 2015 14:34:29 +0800
Subject: [PATCH v3 0/2] Add basic support for Mediatek MT2701 SoC
Message-ID: <1445322871-14134-1-git-send-email-erin.lo@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MT2701 is a SoC based on 32bit ARMv7 architecture. It contains 4 CA7 cores.
MT2701 share many HW IP with MT65xx series. This patchset was tested
on MT2701 evaluation board, and boot to shell ok.

This series contains document bindings, device tree including
interrupt, uart, timer and wdt.

Change in v3:
1. Add the compatible string to arch/arm/mach-mediatek/mediatek.c

Change in v2:
1. Use one tab in stead of spaces in front of "mediatek,mt2701-sysirq" (mediatek,sysirq.txt)
2. Sorting the compatible SoC and add back mt6595 since accidently deleted in previous version (mtk-uart.txt)
3. Correct the mt2701-timer from mt6589-timer since the mistake in previous version (mediatek,mtk-timer.txt)

Erin Lo (2):
  Document: DT: Add bindings for mediatek MT2701 SoC Platform
  ARM: dts: mediatek: add MT2701 basic support

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../bindings/arm/mediatek/mediatek,sysirq.txt      |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |  14 +-
 .../bindings/timer/mediatek,mtk-timer.txt          |   5 +-
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   6 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mt2701-evb.dts                   |  29 ++++
 arch/arm/boot/dts/mt2701.dtsi                      | 146 +++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c                  |   1 +
 9 files changed, 197 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt2701-evb.dts
 create mode 100644 arch/arm/boot/dts/mt2701.dtsi

--
1.9.1
