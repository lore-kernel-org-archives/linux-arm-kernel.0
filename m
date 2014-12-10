From: lyz@rock-chips.com (Yunzhi Li)
Date: Wed, 10 Dec 2014 18:40:36 +0800
Subject: [PATCH v4 1/5] phy: add a driver for the Rockchip SoC internal
 USB2.0 PHY
In-Reply-To: <CABgxDoJRA4cQBqNBTCSGnnLpcOHqqTuBqcyWQosVv4A_Gx315g@mail.gmail.com>
References: <1418093001-30443-1-git-send-email-lyz@rock-chips.com>	<1418093001-30443-2-git-send-email-lyz@rock-chips.com>
 <CABgxDoJRA4cQBqNBTCSGnnLpcOHqqTuBqcyWQosVv4A_Gx315g@mail.gmail.com>
Message-ID: <54882324.10700@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Romain:

On 2014/12/9 18:41, Romain Perier wrote:
> Hi,
>
> 2014-12-09 3:43 GMT+01:00 Yunzhi Li <lyz@rock-chips.com>:
>> Changes in v3:
>> - Use BIT macro instead of bit shift ops.
>> - Rename the config entry to PHY_ROCKCHIP_USB.
> Contradiction between this , [1] and [2]
>>   drivers/phy/Kconfig            |   7 ++
>>   drivers/phy/Makefile           |   1 +
>>   drivers/phy/phy-rockchip-usb.c | 211 +++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 219 insertions(+)
>>   create mode 100644 drivers/phy/phy-rockchip-usb.c
>>
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index ccad880..8a39d2a 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -239,6 +239,13 @@ config PHY_QCOM_IPQ806X_SATA
>>          depends on OF
>>          select GENERIC_PHY
>>
>> +config PHY_ROCKCHIP_USB2
>> +       tristate "Rockchip USB2 PHY Driver"
>> +       depends on ARCH_ROCKCHIP && OF
>> +       select GENERIC_PHY
>> +       help
>> +         Enable this to support the Rockchip USB 2.0 PHY.
>> +
> 1. The config entry ends by "USB2". Explain that your driver is for
> usb 2.0 in the description is enough, imho.
>
>>   config PHY_ST_SPEAR1310_MIPHY
>>          tristate "ST SPEAR1310-MIPHY driver"
>>          select GENERIC_PHY
>> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
>> index aa74f96..8a13f72 100644
>> --- a/drivers/phy/Makefile
>> +++ b/drivers/phy/Makefile
>> @@ -28,6 +28,7 @@ phy-exynos-usb2-$(CONFIG_PHY_EXYNOS5250_USB2) += phy-exynos5250-usb2.o
>>   phy-exynos-usb2-$(CONFIG_PHY_S5PV210_USB2)     += phy-s5pv210-usb2.o
>>   obj-$(CONFIG_PHY_EXYNOS5_USBDRD)       += phy-exynos5-usbdrd.o
>>   obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)    += phy-qcom-apq8064-sata.o
>> +obj-$(CONFIG_PHY_ROCKCHIP_USB2) += phy-rockchip-usb.o
> 2. and... this :)
So,do you mean that I should rename the C source file as 
phy-rockchip-usb2.c ?
> Romain
>
>
