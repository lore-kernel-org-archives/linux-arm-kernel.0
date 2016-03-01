From: carlo@caione.org (Carlo Caione)
Date: Tue,  1 Mar 2016 23:04:32 +0100
Subject: [PATCH 0/4] Refactor pinctrl driver for aobus / cbus
Message-ID: <1456869876-19320-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

The rationale behind this patchset is in this thread
http://www.spinics.net/lists/devicetree/msg115019.html

We basically want to introduce in the Amlogic Meson device-tree the CBUS and
AOBUS nodes. To do this we need to split / refactor the pinctrl driver that is
currently accessing at the same time registers on both these buses.

Carlo Caione (4):
  pinctrl: amlogic: Separate some pin functions for Meson8 / Meson8b
  pinctrl: amlogic: Make driver independent from two-domain
    configuration
  ARM: dts: amlogic: Split pinctrl device for Meson8 / Meson8b
  documentation: Fix pinctrl documentation for Meson8 / Meson8b

 .../devicetree/bindings/pinctrl/meson,pinctrl.txt  |  36 +---
 arch/arm/boot/dts/meson8.dtsi                      |  57 ++++---
 arch/arm/boot/dts/meson8b.dtsi                     |  12 +-
 drivers/pinctrl/meson/pinctrl-meson.c              | 135 +++++++--------
 drivers/pinctrl/meson/pinctrl-meson.h              |  21 +--
 drivers/pinctrl/meson/pinctrl-meson8.c             | 137 +++++++++-------
 drivers/pinctrl/meson/pinctrl-meson8b.c            | 182 ++++++++++++---------
 7 files changed, 296 insertions(+), 284 deletions(-)

-- 
1.9.1
