From: carlo@caione.org (Carlo Caione)
Date: Sat,  7 Nov 2015 12:02:15 +0100
Subject: [PATCH v2 0/4] watchdog: meson: Add meson8b watchdog
Message-ID: <1446894139-6802-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Patchset to add support for the watchdog found on the Amlogic meson8b SoCs.
DTS and documentation are also updated.

Changelog:
   - V1 -> V2:
     * Do not calculate mask at runtime
     * Fix few style problems
     * Remove useless typecase

Carlo Caione (4):
  watchdog: meson: Enable meson SoC specific data
  watchdog: meson: Add meson8b SoC specific data
  Documentation: watchdog: Add new bindings for meson8b
  ARM: dts: meson8b: Add watchdog node

 .../devicetree/bindings/watchdog/meson-wdt.txt     | 13 +++++
 .../devicetree/bindings/watchdog/meson6-wdt.txt    | 13 -----
 arch/arm/boot/dts/meson8b.dtsi                     |  6 +++
 drivers/watchdog/meson_wdt.c                       | 63 ++++++++++++++++------
 4 files changed, 65 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/meson-wdt.txt
 delete mode 100644 Documentation/devicetree/bindings/watchdog/meson6-wdt.txt

-- 
1.9.1
