From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 11:47:01 +0100
Subject: [PATCH v3 0/5] Add a new RTC driver for recent mvebu SoCs
Message-ID: <1421318826-27268-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Marvell Armada 38x SoCs contains an RTC which differs from the RTC
used in the other mvebu SoCs until now. This third version of the
patch set adds support for this new IP and enable it in the Device
Tree of the Armada 38x SoC.

Thanks,

Gr??gory

Changelog
v2 -> v3:

- Fixed the reg-names description in the dt binding documentation
- Used the delayed version of the writel in everyplace.

v1 -> v2:

- Used reg-names to identify the registers in the device tree
- Changed the space into tab in the MAINTAINERS file
- Emphasized that the 5s wait was only needed between two consecutive
  writes
- Reduced the wait in the set_time function, 100ms were enough
- If no interrupt was available, then disable the alarm related
  functions
- Fixed the critical sections
- Updated the mvebu_v7_defconfig by enabling the new RTC support

Gregory CLEMENT (5):
  rtc: armada38x: Add the device tree binding documentation
  drivers/rtc/rtc-armada38x: Add a new RTC driver for recent mvebu SoCs
  MAINTAINERS: Add the RTC driver for the Armada38x
  ARM: mvebu: add Device Tree description of RTC on Armada 38x
  ARM: mvebu: enable Armada 38x RTC driver in mvebu_v7_defconfig

 .../devicetree/bindings/rtc/armada-380-rtc.txt     |  22 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/armada-38x.dtsi                  |   7 +
 arch/arm/configs/mvebu_v7_defconfig                |   1 +
 drivers/rtc/Kconfig                                |  10 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-armada38x.c                        | 319 +++++++++++++++++++++
 7 files changed, 361 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/armada-380-rtc.txt
 create mode 100644 drivers/rtc/rtc-armada38x.c

-- 
1.9.1
