From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun,  5 Nov 2017 14:30:51 +0900
Subject: [PATCH 0/2] kbuild: move dtb-y and CONFIG_OF_ALL_DTBS to Kbuild core
 to fix some issues
Message-ID: <1509859853-27473-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series applies on top of my previous cleanup patch:
https://patchwork.kernel.org/patch/10038167/

This series must go to the same branch, so I am sending this to DT ML.



Masahiro Yamada (2):
  MIPS: dts: remove bogus bcm96358nb4ser.dtb from dtb-y entry
  kbuild: handle dtb-y and CONFIG_OF_ALL_DTBS natively in Makefile.lib

 arch/arc/boot/dts/Makefile                       |  7 ++-
 arch/arm/boot/dts/Makefile                       |  5 --
 arch/arm64/boot/dts/Makefile                     | 58 ++++++++++--------------
 arch/arm64/boot/dts/actions/Makefile             |  3 --
 arch/arm64/boot/dts/al/Makefile                  |  3 --
 arch/arm64/boot/dts/allwinner/Makefile           |  3 --
 arch/arm64/boot/dts/altera/Makefile              |  3 --
 arch/arm64/boot/dts/amd/Makefile                 |  3 --
 arch/arm64/boot/dts/amlogic/Makefile             |  3 --
 arch/arm64/boot/dts/apm/Makefile                 |  3 --
 arch/arm64/boot/dts/arm/Makefile                 |  3 --
 arch/arm64/boot/dts/broadcom/Makefile            |  6 +--
 arch/arm64/boot/dts/broadcom/northstar2/Makefile |  3 --
 arch/arm64/boot/dts/broadcom/stingray/Makefile   |  3 --
 arch/arm64/boot/dts/cavium/Makefile              |  3 --
 arch/arm64/boot/dts/exynos/Makefile              |  3 --
 arch/arm64/boot/dts/freescale/Makefile           |  3 --
 arch/arm64/boot/dts/hisilicon/Makefile           |  3 --
 arch/arm64/boot/dts/lg/Makefile                  |  3 --
 arch/arm64/boot/dts/marvell/Makefile             |  3 --
 arch/arm64/boot/dts/mediatek/Makefile            |  3 --
 arch/arm64/boot/dts/nvidia/Makefile              |  2 -
 arch/arm64/boot/dts/qcom/Makefile                |  3 --
 arch/arm64/boot/dts/realtek/Makefile             |  3 --
 arch/arm64/boot/dts/renesas/Makefile             |  2 -
 arch/arm64/boot/dts/rockchip/Makefile            |  3 --
 arch/arm64/boot/dts/socionext/Makefile           |  2 -
 arch/arm64/boot/dts/sprd/Makefile                |  3 --
 arch/arm64/boot/dts/xilinx/Makefile              |  3 --
 arch/arm64/boot/dts/zte/Makefile                 |  3 --
 arch/h8300/boot/dts/Makefile                     |  5 --
 arch/metag/boot/dts/Makefile                     |  5 --
 arch/mips/boot/dts/Makefile                      | 32 ++++++-------
 arch/mips/boot/dts/brcm/Makefile                 |  3 --
 arch/mips/boot/dts/cavium-octeon/Makefile        |  2 -
 arch/mips/boot/dts/img/Makefile                  |  2 -
 arch/mips/boot/dts/ingenic/Makefile              |  2 -
 arch/mips/boot/dts/lantiq/Makefile               |  2 -
 arch/mips/boot/dts/mti/Makefile                  |  2 -
 arch/mips/boot/dts/netlogic/Makefile             |  2 -
 arch/mips/boot/dts/ni/Makefile                   |  2 -
 arch/mips/boot/dts/pic32/Makefile                |  2 -
 arch/mips/boot/dts/qca/Makefile                  |  2 -
 arch/mips/boot/dts/ralink/Makefile               |  2 -
 arch/mips/boot/dts/xilfpga/Makefile              |  2 -
 arch/xtensa/boot/dts/Makefile                    |  7 ++-
 scripts/Makefile.dtbinst                         |  6 +--
 scripts/Makefile.lib                             |  5 ++
 48 files changed, 53 insertions(+), 183 deletions(-)

-- 
2.7.4
