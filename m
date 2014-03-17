From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Mar 2014 07:14:34 +0900
Subject: [PATCH v3 0/3] arm64: add new support Samsung GH7 SoC and SSDK board
Message-ID: <1395094477-8921-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for Samsung ARMv8 core based GH7 SoC and its evaluation SSDK
board.

Changes since v2:
- add comment about reserved memory
- reduced size of reserved memory
- add 4 more cores
- add specific compatible string for pmu
- change model strin for SSDK-GH7 board
- add DT ml in Cc

Note, still missing clocks for serial and it will be added later.

Changes since v1:
- remove model and compatible in dtsi
- remove inclusion /dts-v1/ in dtsi
- add aliase for serial0
- remove compatible cortex-a9-gic for gic
- remove clock-frequncy for timer
- change number of address-cells and size-cells to 2
- enable ARCH_GH7 in single defconfig for arm64

There were many comments for SoC vendor's Kconfig entry but now I have no
choice except adding ARCH_GH7 and enabling it in current single defconfig
for arm64 by default.

[PATCH v3 1/3] arm64: dts: add initial dts for Samsung GH7 SoC and SSDK-GH7 board
[PATCH v3 2/3] arm64: defconfig: Enable ARCH_GH7 by default
[PATCH v3 3/3] Documentation: DT: add new entry for Samsung GH7 SoC and SSDK board
