From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 29 Apr 2016 12:59:48 +0200
Subject: [RFT PATCH 0/3] usb: misc: usb3503: Fix missing device when TFTP
 booting
Message-ID: <1461927591-7864-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Patches are independent, please pick up as you wish.

However all of them are needed to solve the issue, so I am sending
everything together for easier testng.


Problem
=======
When Odroid U3 (usb3503 + smsc95xx + max77686) boots from network (TFTP),
the usb3503 does not show up in "lsusb". Hard-reset is required, e.g.
by suspend to RAM. The actual TFTP boot does not have to happen. Just
"usb start" from U-Boot is sufficient.


Solution
========
Perform real hardware reset (including regulator off/on) when probing.


Tested on Odroid U3 so far. Please kindly test on X2 and other
configurations and bootloaders.


Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  usb: misc: usb3503: Fix HUB mode after bootloader initialization
  ARM: dts: exynos: Provide regulator for usb3503 on Odroid to fix
    device detection
  regulator: max77686: Configure enable time to properly handle
    regulator enable

 Documentation/devicetree/bindings/usb/usb3503.txt |  1 +
 arch/arm/boot/dts/exynos4412-odroidu3.dts         |  2 +
 drivers/regulator/max77686-regulator.c            |  5 ++
 drivers/usb/misc/usb3503.c                        | 81 +++++++++++++++++++++++
 4 files changed, 89 insertions(+)

-- 
1.9.1
