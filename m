From: elder@linaro.org (Alex Elder)
Date: Fri, 20 Oct 2017 12:20:18 -0500
Subject: [PATCH 0/3] arm64: remove some unused defconfig options
Message-ID: <20171020172021.8119-1-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series deletes three config options related to USB on Qualcomm
SoCs from the arm64 "defconfig", along with the code that they
enable.  The code is no longer needed by any Qualcomm hardware.  

					-Alex

Alex Elder (3):
  arm64: defconfig: remove CONFIG_USB_EHCI_MSM
  arm64: defconfig: remove CONFIG_USB_MSM_OTG
  arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY

 arch/arm64/configs/defconfig        |    3 -
 drivers/usb/host/Makefile           |    1 -
 drivers/usb/host/ehci-msm.c         |  265 -----
 drivers/usb/phy/Makefile            |    2 -
 drivers/usb/phy/phy-msm-usb.c       | 2085 -----------------------------------
 drivers/usb/phy/phy-qcom-8x16-usb.c |  366 ------
 6 files changed, 2722 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-msm.c
 delete mode 100644 drivers/usb/phy/phy-msm-usb.c
 delete mode 100644 drivers/usb/phy/phy-qcom-8x16-usb.c

-- 
2.11.0
