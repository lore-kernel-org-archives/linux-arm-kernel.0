From: carlo@caione.org (Carlo Caione)
Date: Tue, 14 Oct 2014 20:35:46 +0200
Subject: [PATCH v2 0/3] ARM: meson: Add reset controller
Message-ID: <1413311749-13948-1-git-send-email-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apparently several IPs found in the MesonX SoCs can be reset by programming a
specific bit in a register in the so called AO (Always-On) domain. From the
documentation released by Amlogic under NDA it is not clear which devices can
be reset acting on this register. So far from the sources release by Amlogic it
seems that at least two IPs use this register for reset: RTC and UART. Since I
need it to reset the RTC, I wrote this small driver.

v2:
* removed useless comment
* added platform_get_drvdata
* removed owner field

Carlo Caione (3):
  ARM: meson: reset: Add reset controller for MesonX SoCs
  ARM: meson: DTSI: Enable reset controller
  ARM: meson: docs: Add docs for MesonX reset controller

 .../bindings/reset/amlogic,meson6-rst-mgr-ao.txt   |  14 ++
 arch/arm/boot/dts/meson.dtsi                       |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-meson.c                        | 142 +++++++++++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/amlogic,meson6-rst-mgr-ao.txt
 create mode 100644 drivers/reset/reset-meson.c

-- 
1.9.1
