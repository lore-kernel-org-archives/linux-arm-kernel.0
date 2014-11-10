From: rbyshko@gmail.com (Roman Byshko)
Date: Mon, 10 Nov 2014 19:55:05 +0100
Subject: [PATCH v2 0/5] ARM: sunxi: Add support for USB OTG PHY
Message-ID: <cover.1415645258.git.rbyshko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There is already support for two USB phys, which are used for
USB host controllers on Allwinner SoC aka sunxi.

This patch series add support for the USB OTG phy (aka phy0).

The code has been tested on Allwinner A20 aka sun7i (Cubietruck).

Best regards,
Roman Byshko

Changes since v1:
	* Improved comment about 45 Ohm resistor calibration
	* Added Signed-off-by to all patches

Roman Byshko (5):
  phy: sun4i: add support for USB phy0
  ARM: dtsi: sunxi: add common VBUS regulator
  ARM: sun7i: dtsi: add support for usbphy0
  ARM: dts: sun7i: Cubietruck: override regulator pin
  ARM: dts: sun7i: Cubietruck: add power supply regulator for USB OTG
    VBUS

 arch/arm/boot/dts/sun7i-a20-cubietruck.dts     | 14 ++++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi               |  4 ++--
 arch/arm/boot/dts/sunxi-common-regulators.dtsi | 19 +++++++++++++++++++
 drivers/phy/phy-sun4i-usb.c                    |  9 ++++++---
 4 files changed, 41 insertions(+), 5 deletions(-)

-- 
2.1.2
