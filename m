From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 07 Oct 2015 09:30:04 +0900
Subject: [RFT 0/3] usb: usb3503: Fix probing on Arndale board (missing phy)
Message-ID: <1444177807-15524-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


Introduction
============
This patchset tries to fix probing of usb3503 on Arndale board
if the Samsung PHY driver is probed later (or built as a module).

*The patchset was not tested on Arndale board.*
I don't have that board. Please test it and say if the usb3503 deferred probe
works fine and the issue is solved.

The patchset was tested on Odroid U3 board (which is different!)
in a simulated environment. It is not sufficient testing.


Difference
==========
The usb3503 device driver can be used as a I2C device (on Odroid U3)
or as a platform device connected through phy (on Arndale). In the second
case the necessary phy reference has to be obtained and enabled.

For some details please look also at thread [0][1].

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348524.html
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/348875.html


Best regards,
Krzysztof


Krzysztof Kozlowski (3):
  dt-bindings: usb: usb5303: Document new 'phys' property
  usb: misc: usb3503: Allow usage of device through phy interface
  ARM: dts: Fix usb3503 probe by enabling phy on exynos5250-arndale

 Documentation/devicetree/bindings/usb/usb3503.txt |  4 ++
 arch/arm/boot/dts/exynos5250-arndale.dts          |  2 +
 drivers/usb/misc/usb3503.c                        | 65 +++++++++++++++++++++++
 3 files changed, 71 insertions(+)

-- 
1.9.1
