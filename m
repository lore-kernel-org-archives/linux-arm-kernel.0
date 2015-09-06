From: dingtianhong@huawei.com (Ding Tianhong)
Date: Sun, 6 Sep 2015 17:34:33 +0800
Subject: [PATCH v3 0/2] arm64: Support Hisilicon Hip05-D02 board
Message-ID: <1441532075-9452-1-git-send-email-dingtianhong@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hip05-D02 Development Board is based on Cortex-A57, this patchset
contains initial support for Hip05-D02 Soc and Board. Initial support
is minimal and includes just the arch configuration, device tree
configuration.

PSCI is enabled in device tree and there is no problem to boot all the
16 cores, and the CPU hotplug is also working now, you can download and
compile the latest firmware based on the following link to run this
patch set.

https://github.com/hisilicon/estuary/blob/master/README

v3->v2:
- 1. Change the compatible name for per CPU to arm,cortex-a57.
  2. limit the ITS region to 256k.

v1->v2:
- 1. Change the compatible name for per CPU.
  2. Remove the GIC_CPU_MASK_SIMPLE(xx) which is not used for gicv3
     from hip05.dtsi.

Ding Tianhong (2):
  arm64: hip05-d02: Document devicetree bindings for Hisilicon Hip05-D02
    Board
  arm64: dts: add dts files for Hisilicon Hip05-D02 Development Board

 .../bindings/arm/hisilicon/hisilicon.txt           |   4 +
 arch/arm64/boot/dts/hisilicon/Makefile             |   2 +-
 arch/arm64/boot/dts/hisilicon/hip05-d02.dts        |  36 +++
 arch/arm64/boot/dts/hisilicon/hip05.dtsi           | 271 +++++++++++++++++++++
 4 files changed, 312 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05-d02.dts
 create mode 100644 arch/arm64/boot/dts/hisilicon/hip05.dtsi

-- 
1.9.0
