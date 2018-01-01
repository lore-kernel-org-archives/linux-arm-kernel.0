From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Mon,  1 Jan 2018 15:22:49 -0800
Subject: [PATCH v2 00/21] Verbatim device names and devm_nvmem_(un)register()
Message-ID: <20180101232310.30420-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas, all:

This patchset contains various small changes that I recently made to
NVMEM, more specifically:

 - Patches 1 and 2 are two changes I am hoping are acceptable upstream

 - Patches 3 to 14 are a follow up to patch 2

 - Patches 15 to 21 are just trivial fixups and I am more than happy
   to drop them if they seem to add more pointless churn rather then
   value.

Feedback is appreciated!

Thanks,
Andrey Smirnov


Changes since [v1]:

 - Fixed a build break detected by kbuild test robot

 - Added a patch to unconditionally enable COMPILE_TEST for meson-efuse

 - Dropped Joachim Eastwood from CC list due to bouncing e-mail


[v1] lkml.kernel.org/r/20171227225956.14442-1-andrew.smirnov at gmail.com


Andrey Smirnov (21):
  nvmem: core: Allow specifying device name verbatim
  nvmem: Introduce devm_nvmem_(un)register()
  nvmem: vf610-ocotp: Convert to use devm_nvmem_register()
  nvmem: imx-ocotp: Convert to use devm_nvmem_register()
  nvmem: uniphier-efuse: Convert to use devm_nvmem_register()
  nvmem: snvs_lgpr: Convert to use devm_nvmem_register()
  nvmem: rockchip-efuse: Convert to use devm_nvmem_register()
  nvmem: qfprom: Convert to use devm_nvmem_register()
  nvmem: mtk-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-mx-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-efuse: Convert to use devm_nvmem_register()
  nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
  nvmem: imx-iim: Convert to use devm_nvmem_register()
  nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
  nvmem: meson-efuse: Do no gate COMPILE_TEST with MESON_SM
  nvmem: snvs_lpgpr: Convert commas to semicolons
  nvmem: rockchip-efuse: Make use of of_device_get_match_data()
  nvmem: vf610-ocotp: Do not use "&pdev->dev" explicitly
  nvmem: rockchip-efuse: Do not use "&pdev->dev" explicitly
  nvmem: imx-iim: Do not use "&pdev->dev" explicitly
  nvmem: bcm-ocotp: Do not use "&pdev->dev" explicitly

 drivers/nvmem/Kconfig          |  2 +-
 drivers/nvmem/bcm-ocotp.c      | 15 ++----------
 drivers/nvmem/core.c           | 52 +++++++++++++++++++++++++++++++++++++++---
 drivers/nvmem/imx-iim.c        | 14 ++----------
 drivers/nvmem/imx-ocotp.c      | 12 +---------
 drivers/nvmem/lpc18xx_otp.c    | 12 +---------
 drivers/nvmem/meson-efuse.c    | 12 +---------
 drivers/nvmem/meson-mx-efuse.c | 12 +---------
 drivers/nvmem/mtk-efuse.c      | 12 +---------
 drivers/nvmem/qfprom.c         | 12 +---------
 drivers/nvmem/rockchip-efuse.c | 28 ++++++++---------------
 drivers/nvmem/snvs_lpgpr.c     | 26 +++++++--------------
 drivers/nvmem/uniphier-efuse.c | 12 +---------
 drivers/nvmem/vf610-ocotp.c    | 15 ++----------
 include/linux/nvmem-provider.h | 17 ++++++++++++++
 15 files changed, 97 insertions(+), 156 deletions(-)

-- 
2.14.3
