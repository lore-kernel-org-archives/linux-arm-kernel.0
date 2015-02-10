From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 10 Feb 2015 22:53:23 +0800
Subject: [resend PATCH v3 4/4] usb: phy: add phy-hi6220-usb
In-Reply-To: <20150210144807.GC16711@saruman.tx.rr.com>
References: <1423559404-13058-1-git-send-email-zhangfei.gao@linaro.org>
 <1423559404-13058-5-git-send-email-zhangfei.gao@linaro.org>
 <20150210144807.GC16711@saruman.tx.rr.com>
Message-ID: <54DA1B63.5070007@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/10/2015 10:48 PM, Felipe Balbi wrote:
> On Tue, Feb 10, 2015 at 05:10:04PM +0800, Zhangfei Gao wrote:
>> Add usb phy controller for hi6220 platform
>>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   drivers/usb/phy/Kconfig          |   9 ++
>>   drivers/usb/phy/Makefile         |   1 +
>>   drivers/usb/phy/phy-hi6220-usb.c | 306 +++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 316 insertions(+)
>>   create mode 100644 drivers/usb/phy/phy-hi6220-usb.c
>>
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index c6d0c8e..405a3d0 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -173,6 +173,15 @@ config USB_MXS_PHY
>>
>>   	  MXS Phy is used by some of the i.MX SoCs, for example imx23/28/6x.
>>
>> +config USB_HI6220_PHY
>> +	tristate "hi6220 USB PHY support"
>> +	select USB_PHY
>> +	select MFD_SYSCON
>> +	help
>> +	  Enable this to support the HISILICON HI6220 USB PHY.
>> +
>> +	  To compile this driver as a module, choose M here.
>> +
>>   config USB_RCAR_PHY
>>   	tristate "Renesas R-Car USB PHY support"
>>   	depends on USB || USB_GADGET
>> diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
>> index 75f2bba..00172d3 100644
>> --- a/drivers/usb/phy/Makefile
>> +++ b/drivers/usb/phy/Makefile
>> @@ -18,6 +18,7 @@ obj-$(CONFIG_SAMSUNG_USBPHY)		+= phy-samsung-usb.o
>>   obj-$(CONFIG_TWL6030_USB)		+= phy-twl6030-usb.o
>>   obj-$(CONFIG_USB_EHCI_TEGRA)		+= phy-tegra-usb.o
>>   obj-$(CONFIG_USB_GPIO_VBUS)		+= phy-gpio-vbus-usb.o
>> +obj-$(CONFIG_USB_HI6220_PHY)		+= phy-hi6220-usb.o
>
> new drivers only on drivers/phy/, sorry.
>
OK, thanks for the info, I don't know this at all.
So even usb phy should be put under drivers/phy/.

Will change that.

Thanks Felipe
