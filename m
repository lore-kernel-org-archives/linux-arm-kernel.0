From: liwei213@huawei.com (Li Wei)
Date: Tue, 13 Feb 2018 18:14:07 +0800
Subject: [PATCH v8 0/5] scsi: ufs: add ufs driver code for Hisilicon Hi3660 SoC
Message-ID: <20180213101412.5717-1-liwei213@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds driver support for UFS for Hi3660 SoC. It is verified on HiKey960 board.

Li Wei (5):
  scsi: ufs: add Hisilicon ufs driver code
  dt-bindings: scsi: ufs: add document for hisi-ufs
  arm64: dts: add ufs dts node
  arm64: defconfig: enable configs for Hisilicon ufs
  arm64: defconfig: enable f2fs and squashfs

 Documentation/devicetree/bindings/ufs/ufs-hisi.txt |  37 ++
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi          |  19 +
 arch/arm64/configs/defconfig                       |  11 +
 drivers/scsi/ufs/Kconfig                           |   9 +
 drivers/scsi/ufs/Makefile                          |   1 +
 drivers/scsi/ufs/ufs-hisi.c                        | 623 +++++++++++++++++++++
 drivers/scsi/ufs/ufs-hisi.h                        | 116 ++++
 7 files changed, 816 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-hisi.txt
 create mode 100644 drivers/scsi/ufs/ufs-hisi.c
 create mode 100644 drivers/scsi/ufs/ufs-hisi.h

-- 
Major changes in v7:
 - solve review comments from Philippe Ombredanne.
   *use the new SPDX license ids instead of the GNU General Public License.

Major changes in v8:
 - solve review comments from zhangfei.
   *Add Version history.
 - solve review comments from Rob Herring.
   *remove freq-table-hz.
 -  solve review comments from Riku Voipio.
   *Add MODULE_DEVICE_TABLE for ufs driver.
2.15.0
