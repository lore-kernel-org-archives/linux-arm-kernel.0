From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  9 Mar 2018 14:32:05 +0100
Subject: [PATCH RFC 0/3] nvmem: Enable OTP access for Raspberry Pi
Message-ID: <1520602328-28972-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VC4 firmware exposes a mailbox interface that allows the ARM core
to access only the customer part of the OTP memory. This version brings
read-only support, but could also be extended to write support.

I think this driver could be helpful for vendors, which integrate the
Raspberry Pi Compute Module in their products.

This series depends on commit "soc: bcm2835: sync firmware properties
with downstream".

Stefan Wahren (3):
  dt-bindings: nvmem: add binding for Raspberry Pi OTP
  nvmem: add driver for Raspberry Pi OTP
  ARM: dts: bcm2835-rpi: Enable OTP access for Raspberry Pi

 .../nvmem/raspberrypi,bcm2835-customer-otp.txt     |  27 ++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   6 +
 drivers/nvmem/Kconfig                              |  10 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/raspberrypi-otp.c                    | 138 +++++++++++++++++++++
 5 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/raspberrypi,bcm2835-customer-otp.txt
 create mode 100644 drivers/nvmem/raspberrypi-otp.c

-- 
2.7.4
