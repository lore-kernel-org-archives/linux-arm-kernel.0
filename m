From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Thu,  8 Mar 2018 11:11:44 -0800
Subject: [PATCH v5 00/21] Verbatim device names and devm_nvmem_(un)register()
Message-ID: <20180308191205.26943-1-andrew.smirnov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas, all:

This patchset contains various small changes that I recently made to
NVMEM, more specifically:

 - Patches 1 and 3 are two changes I am hoping are acceptable upstream

 - Patches 4 to 15 are a follow up to patch 2

 - Patches 16 to 21 are just trivial fixups and I am more than happy
   to drop them if they seem to add more pointless churn rather then
   value.

Feedback is appreciated!

Thanks,
Andrey Smirnov

Chagnes since [v4]:

 - Fixed typo in patch 01/22 pointed out by Sean Wang

 - Converted all of the code to use PTR_ERR_OR_ZERO where possible

 - Dropped "nvmem: meson-efuse: Do no gate COMPILE_TEST with
   MESON_SM", since it was causing build problems by kbuild test bot
   and I didn't want to block the rest of the series.

Changes since [v3]:

 - Patchset rebased on post 4.16-rc1 master from Linus

Changes since [v2]:

 - Added a patch with kerenl doc for struct nvmem_config as a
   prerequsite for patch #2

 - Documented behaviour of nvmem_register() when id is set to -1

 - Added kernel doc for devm_nvmem_(un)register()


Changes since [v1]:

 - Fixed a build break detected by kbuild test robot

 - Added a patch to unconditionally enable COMPILE_TEST for meson-efuse

 - Dropped Joachim Eastwood from CC list due to bouncing e-mail

[v4] lkml.kernel.org/r/20180228144106.16363-1-andrew.smirnov at gmail.com
[v3] lkml.kernel.org/r/20180103200114.23922-1-andrew.smirnov at gmail.com
[v2] lkml.kernel.org/r/20180101232310.30420-1-andrew.smirnov at gmail.com
[v1] lkml.kernel.org/r/20171227225956.14442-1-andrew.smirnov at gmail.com


Andrey Smirnov (21):
  nvmem: Document struct nvmem_config
  nvmem: core: Allow specifying device name verbatim
  nvmem: Introduce devm_nvmem_(un)register()
  nvmem: vf610-ocotp: Convert to use devm_nvmem_register()
  nvmem: imx-ocotp: Convert to use devm_nvmem_register()
  nvmem: uniphier-efuse: Convert to use devm_nvmem_register()
  nvmem: snvs_lgpr: Convert to use devm_nvmem_register()
  nvmem: rockchip-efuse: Convert to use devm_nvmem_register()
  nvmem: mtk-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-mx-efuse: Convert to use devm_nvmem_register()
  nvmem: meson-efuse: Convert to use devm_nvmem_register()
  nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
  nvmem: imx-iim: Convert to use devm_nvmem_register()
  nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
  nvmem: qfprom: Convert to use devm_nvmem_register()
  nvmem: snvs_lpgpr: Convert commas to semicolons
  nvmem: rockchip-efuse: Make use of of_device_get_match_data()
  nvmem: vf610-ocotp: Do not use "&pdev->dev" explicitly
  nvmem: rockchip-efuse: Do not use "&pdev->dev" explicitly
  nvmem: imx-iim: Do not use "&pdev->dev" explicitly
  nvmem: bcm-ocotp: Do not use "&pdev->dev" explicitly

 drivers/nvmem/bcm-ocotp.c      | 15 ++--------
 drivers/nvmem/core.c           | 68 ++++++++++++++++++++++++++++++++++++++++--
 drivers/nvmem/imx-iim.c        | 18 ++---------
 drivers/nvmem/imx-ocotp.c      | 16 ++--------
 drivers/nvmem/lpc18xx_otp.c    | 16 ++--------
 drivers/nvmem/meson-efuse.c    | 16 ++--------
 drivers/nvmem/meson-mx-efuse.c | 16 ++--------
 drivers/nvmem/mtk-efuse.c      | 16 ++--------
 drivers/nvmem/qfprom.c         | 16 ++--------
 drivers/nvmem/rockchip-efuse.c | 32 +++++++-------------
 drivers/nvmem/snvs_lpgpr.c     | 28 +++++------------
 drivers/nvmem/uniphier-efuse.c | 16 ++--------
 drivers/nvmem/vf610-ocotp.c    | 24 ++++-----------
 include/linux/nvmem-provider.h | 42 ++++++++++++++++++++++++++
 14 files changed, 149 insertions(+), 190 deletions(-)

-- 
2.14.3
