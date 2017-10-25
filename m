From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Oct 2017 17:20:20 -0700
Subject: [PATCH 0/3] arm64: remove some unused defconfig options
In-Reply-To: <20171020172021.8119-1-elder@linaro.org>
References: <20171020172021.8119-1-elder@linaro.org>
Message-ID: <20171025002019.GC30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20, Alex Elder wrote:
> This series deletes three config options related to USB on Qualcomm
> SoCs from the arm64 "defconfig", along with the code that they
> enable.  The code is no longer needed by any Qualcomm hardware.  
> 
> 					-Alex
> 
> Alex Elder (3):
>   arm64: defconfig: remove CONFIG_USB_EHCI_MSM
>   arm64: defconfig: remove CONFIG_USB_MSM_OTG
>   arm64: defconfig: remove CONFIG_USB_QCOM_8X16_PHY

As I said off-list, I would split this into defconfig for arm-soc
and drivers/usb for usb subsystem to pick up.

> 
>  arch/arm64/configs/defconfig        |    3 -
>  drivers/usb/host/Makefile           |    1 -
>  drivers/usb/host/ehci-msm.c         |  265 -----
>  drivers/usb/phy/Makefile            |    2 -
>  drivers/usb/phy/phy-msm-usb.c       | 2085 -----------------------------------
>  drivers/usb/phy/phy-qcom-8x16-usb.c |  366 ------
>  6 files changed, 2722 deletions(-)
>  delete mode 100644 drivers/usb/host/ehci-msm.c
>  delete mode 100644 drivers/usb/phy/phy-msm-usb.c
>  delete mode 100644 drivers/usb/phy/phy-qcom-8x16-usb.c
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
