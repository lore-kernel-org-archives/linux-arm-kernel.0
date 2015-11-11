From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 11 Nov 2015 15:34:27 +0800
Subject: [PATCH 0/4] support the efuse for rk3188/rk3066a SoCs and cleanup
 driver on nvmem.
Message-ID: <1447227272-1728-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset to support reading the efuse info for more SoCs.
(Note: support 32 bits SoCs).

Meanwhile, cleanup sunxi/rockchip drivers for more readability.

You can easy to test for following:

cd /sys/bus/nvmem/devices/rockchip-efuse0
localhost rockchip-efuse0 # busybox hexdump -C nvmem



Caesar Wang (4):
  nvmem: sunxi: trivial: fix code style
  nvmem: rockchip: trivial: Make the driver more readability
  ARM: dts: rockchip: add eFuse node for rk3066a SoCs
  ARM: dts: rockchip: add eFuse node for rk3188 SoCs

 arch/arm/boot/dts/rk3066a.dtsi | 13 ++++++
 arch/arm/boot/dts/rk3188.dtsi  | 13 ++++++
 drivers/nvmem/rockchip-efuse.c | 90 ++++++++++++++++++++----------------------
 drivers/nvmem/sunxi_sid.c      |  9 ++---
 4 files changed, 71 insertions(+), 54 deletions(-)

-- 
1.9.1
