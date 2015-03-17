From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 17 Mar 2015 17:15:45 +0100
Subject: [PATCH 0/5] USB: atmel: rework clock handling
Message-ID: <1426608950-31555-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series reworks clock handling in atmel USB host drivers, and while
doing so fixes a regression introduced by 3440ef1 (ARM: at91/dt: fix USB
high-speed clock to select UTMI).

Best Regards,

Boris

Boris Brezillon (5):
  USB: ehci-atmel: rework clk handling
  USB: host: ohci-at91: remove useless uclk clock
  USB: atmel: update DT bindings documentation
  ARM: at91/dt: remove useless uhpck clock references from ehci
    defintions
  ARM: at91/dt: remove useless usb clock

 .../devicetree/bindings/usb/atmel-usb.txt          | 25 ++++++++++++++++++
 arch/arm/boot/dts/at91rm9200.dtsi                  |  4 +--
 arch/arm/boot/dts/at91sam9260.dtsi                 |  4 +--
 arch/arm/boot/dts/at91sam9261.dtsi                 |  4 +--
 arch/arm/boot/dts/at91sam9263.dtsi                 |  4 +--
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  8 +++---
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  5 ++--
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  8 +++---
 arch/arm/boot/dts/sama5d3.dtsi                     |  9 +++----
 arch/arm/boot/dts/sama5d4.dtsi                     |  9 +++----
 drivers/usb/host/ehci-atmel.c                      | 30 +++++++---------------
 drivers/usb/host/ohci-at91.c                       | 18 +++----------
 12 files changed, 63 insertions(+), 65 deletions(-)

-- 
1.9.1
