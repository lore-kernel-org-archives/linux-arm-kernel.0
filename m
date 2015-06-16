From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 16 Jun 2015 15:27:42 +0800
Subject: [PATCH v2 0/3] Add the efuse driver on rockchip platform
Message-ID: <1434439665-27781-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The original driver is uploaded by Jianqun.
Here is his patchs:
    https://patchwork.kernel.org/patch/5410341/
    https://patchwork.kernel.org/patch/5410351/

Jianqun, nevermind!
I check-pick it and re-upload the driver for the upstream.
e.g.:
    Tested by on minnie board.(kernel-4.1-rc8)
    cd /sys/devices/platform/ffb40000.efuse
    localhost ffb40000.efuse # cat cpu_leakage_show
    cpu_version_show
    The results:
            19
            2

Changes in v2:
- Change the document decription.
- Move the efuse driver into driver/soc/vendor.
- update the efuse driver.
- Add the dts node on RK3288.

Caesar Wang (3):
  soc/rockchip: Add efuse bindings for Rockchip SoC efuse driver
  soc/rockchip: efuse: Add Rockchip SoC efuse support
  ARM: dts: Add RK3288 efuse node

 .../bindings/fuse/rockchip,rockchip-efuse.txt      |  14 ++
 arch/arm/boot/dts/rk3288.dtsi                      |   5 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/rockchip/Makefile                      |   4 +
 drivers/soc/rockchip/efuse.c                       | 212 +++++++++++++++++++++
 5 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fuse/rockchip,rockchip-efuse.txt
 create mode 100644 drivers/soc/rockchip/Makefile
 create mode 100644 drivers/soc/rockchip/efuse.c

-- 
1.9.1
