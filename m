From: butao@hisilicon.com (Bu Tao)
Date: Fri, 16 Jun 2017 14:51:14 +0800
Subject: [PATCH v2 0/5] scsi: ufs: add ufs driver code for Hi3660 SoC
Message-ID: <20170616065119.10704-1-butao@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board

In v2
The dts ufs node patch, v2-0003-arm64-dts-Add-ufs-dts-node-for-Hisilicon-Hi3660-S.patch,
is dependent on the patch below:

>From Guodong Xu <guodong.xu@xxxxxxxxxx>
https://www.spinics.net/lists/arm-kernel/msg588232.html

Bu Tao (3):
  scsi: ufs: add hi3660 ufs driver code
  scsi: ufs: add ufs node document for hi3660
  arm64: dts: Add ufs dts node for Hisilicon Hi3660 SoC

Zhangfei Gao(2):
  rm64: defconfig: enable configs for hi3660 ufs
  arm64: defconfig: enable f2fs and squashfs

 .../devicetree/bindings/ufs/hi3660-ufs.txt         |  58 ++
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts  |   9 +
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  19 +
 arch/arm64/configs/defconfig                       |  11 +
 drivers/scsi/ufs/Kconfig                           |   8 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hi3660.c                      | 727 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hi3660.h                      | 173 +++++
 8 files changed, 1006 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/hi3660-ufs.txt
 create mode 100644 drivers/scsi/ufs/ufs-hi3660.c
 create mode 100644 drivers/scsi/ufs/ufs-hi3660.h

-- 
2.11.GIT
