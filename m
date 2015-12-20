From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sun, 20 Dec 2015 22:19:41 +0100
Subject: [GIT PULL] ARM: mediatek: dts updates for v4.4
Message-ID: <CABuKBe+SLMYqWvOmL2w-YWOwkGz5tGU8U-fkntFT6rBuFbOsPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Please pull the following patches.

Thanks,
Matthias

---

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v4.4-next-dts

for you to fetch changes up to eb0fc0d6ae99305a5aecbcf8a67cce838547d638:

  dt-bindings: soc: Add supplies for Mediatek SCPSYS unit (2015-12-09
12:24:56 +0100)

----------------------------------------------------------------
Add regulators to the scpsys binding.

Move the include of the reset contoller to include/dt-bindings/reset.

Add basic support for mt2701 SoC and evaluation board.

----------------------------------------------------------------
Erin Lo (2):
      Document: DT: Add bindings for mediatek MT2701 SoC Platform
      ARM: dts: mediatek: add MT2701 basic support

Philipp Zabel (1):
      ARM: mediatek: DT: Move reset controller constants into common location

Sascha Hauer (1):
      dt-bindings: soc: Add supplies for Mediatek SCPSYS unit

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt    |   2 +-
 .../bindings/arm/mediatek/mediatek,pericfg.txt     |   2 +-
 .../interrupt-controller/mediatek,sysirq.txt       |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |  14 +-
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  12 ++
 .../bindings/timer/mediatek,mtk-timer.txt          |   1 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt       |   6 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/mt2701-evb.dts                   |  29 ++++
 arch/arm/boot/dts/mt2701.dtsi                      | 146 +++++++++++++++++++++
 arch/arm/boot/dts/mt8135.dtsi                      |   2 +-
 arch/arm/mach-mediatek/mediatek.c                  |   1 +
 arch/arm64/boot/dts/mediatek/mt8173.dtsi           |   2 +-
 .../{reset-controller => reset}/mt8135-resets.h    |   0
 .../{reset-controller => reset}/mt8173-resets.h    |   0
 16 files changed, 211 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt2701-evb.dts
 create mode 100644 arch/arm/boot/dts/mt2701.dtsi
 rename include/dt-bindings/{reset-controller => reset}/mt8135-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/mt8173-resets.h (100%)
