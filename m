From: elder@linaro.org (Alex Elder)
Date: Tue, 31 Oct 2017 08:11:28 -0500
Subject: [PATCH v3 0/3] usb: remove some unused code
Message-ID: <20171031131131.8099-1-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series deletes some Qualcomm USB code is no longer needed by
any Qualcomm hardware.  A separate series deletes the Kconfig
options that enable building this code from the ARM64 defconfig.

With these drivers, host and gadget mode were implemented separately
for the same hardware, which is inherently racy and broken.  These
drivers have not really been needed since Stephen Boyd reworked the
ChipIdea driver to support these platforms.

					-Alex

v3: - rebased, and expanded the above description; no functional change
v2: - delete sections of Kconfig files that control whether the deleted
      code gets built


Alex Elder (3):
  usb: host: remove ehci-msm.c
  usb: phy: remove phy-msm-usb.c
  usb: phy: remove phy-qcom-8x16-usb.c

 drivers/usb/host/Kconfig            |   12 -
 drivers/usb/host/Makefile           |    1 -
 drivers/usb/host/ehci-msm.c         |  265 -----
 drivers/usb/phy/Kconfig             |   29 -
 drivers/usb/phy/Makefile            |    2 -
 drivers/usb/phy/phy-msm-usb.c       | 2085 -----------------------------------
 drivers/usb/phy/phy-qcom-8x16-usb.c |  366 ------
 7 files changed, 2760 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-msm.c
 delete mode 100644 drivers/usb/phy/phy-msm-usb.c
 delete mode 100644 drivers/usb/phy/phy-qcom-8x16-usb.c

-- 
2.11.0
