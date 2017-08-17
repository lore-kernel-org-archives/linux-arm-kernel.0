From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 17 Aug 2017 11:32:59 +0200
Subject: [PATCH 0/7] Add support for USB OTG on STM32F7xx
Message-ID: <1502962386-6683-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The STM32F7xx MCU family embeds two DWC2 USB OTG cores. One core is USB
OTG FS and the other is USB OTG HS. The USB FS core only works with its
internal phy whilst the USB HS core can work in HS with external ULPI phy
or in FS/LS with the on-chip FS phy.

Amelie Delaunay (7):
  dt-bindings: usb: Document the STM32F7xx DWC2 USB OTG HS core binding
  usb: dwc2: add support for STM32F7xx USB OTG HS
  ARM: dts: stm32: Add USB HS support for STM32F746 MCU
  ARM: dts: stm32: Enable USB HS on stm32746g-eval
  ARM: dts: stm32: Enable USB HS on stm32f746-disco
  ARM: dts: stm32: Add USB FS support for STM32F746 MCU
  ARM: dts: stm32: Enable USB FS on stm32f746-disco

 Documentation/devicetree/bindings/usb/dwc2.txt |  2 +
 arch/arm/boot/dts/stm32746g-eval.dts           | 16 ++++++
 arch/arm/boot/dts/stm32f746-disco.dts          | 30 ++++++++++
 arch/arm/boot/dts/stm32f746.dtsi               | 80 ++++++++++++++++++++++++++
 drivers/usb/dwc2/params.c                      | 11 ++++
 5 files changed, 139 insertions(+)

-- 
2.7.4
