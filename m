From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 20 Feb 2017 18:38:47 +0100
Subject: [PATCH v3 0/3] Extend rtc-armada38x support for Armada 7K/8K
Message-ID: <20170220173850.8640-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
the SOC integration differs in 2 points:
     - MBUS bridge timing initialization
     - IRQ configuration at SoC level

This patch set extends the driver support to these SoCs family.

This third version fixed the GIC_SPI value on CP slave by using 71 as
it was used on the CP mastered.

The second version the device tree was updated allowing to use the
RTC on Armada 80x0 SoCs. Indeed on the Armada 80x0, the RTC clock in
CP master is not connected (by package) to the oscillator. So this one
is disabled for the Armada 8020 and the Armada 8040. On these SoCs it
will be the RTC clock in CP slave connected to the oscillator which
will be used.

Thanks,

Gregory

Gregory CLEMENT (3):
  rtc: armada38x: Prepare driver to manage different versions
  rtc: armada38x: Add support for Armada 7K/8K
  arm64: dts: marvell: add RTC description for Armada 7K/8K

 .../devicetree/bindings/rtc/armada-380-rtc.txt     |   8 +-
 arch/arm64/boot/dts/marvell/armada-8020.dtsi       |  10 +
 arch/arm64/boot/dts/marvell/armada-8040.dtsi       |   9 +
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   7 +
 .../arm64/boot/dts/marvell/armada-cp110-slave.dtsi |   7 +
 drivers/rtc/rtc-armada38x.c                        | 217 ++++++++++++++++-----
 6 files changed, 202 insertions(+), 56 deletions(-)

-- 
2.11.0
