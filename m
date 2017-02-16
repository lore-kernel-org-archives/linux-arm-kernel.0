From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 16 Feb 2017 16:31:33 +0100
Subject: [PATCH 0/3] Extend rtc-armada38x support for Armada 7K/8K
Message-ID: <20170216153136.27009-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The Armada 7K/8K SoCs use the same RTC IP than the Armada 38x. However
the SOC integration differs in 2 points:
     - MBUS bridge timing initialization
     - IRQ configuration at SoC level

This patch set extends the driver support to these SoCs family.

Gregory

Gregory CLEMENT (3):
  rtc: armada38x: Prepare driver to manage different versions
  rtc: armada38x: Add support for Armada 7K/8K
  arm64: dts: marvell: add RTC description for Armada 7K/8K

 .../devicetree/bindings/rtc/armada-380-rtc.txt     |   8 +-
 .../boot/dts/marvell/armada-cp110-master.dtsi      |   7 +
 drivers/rtc/rtc-armada38x.c                        | 217 ++++++++++++++++-----
 3 files changed, 176 insertions(+), 56 deletions(-)

-- 
2.11.0
