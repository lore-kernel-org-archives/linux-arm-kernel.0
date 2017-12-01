From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 1 Dec 2017 09:57:26 +0100
Subject: [PATCH v4 6/6] ARM: configs: Add missing config for DART-MX6 SoM
In-Reply-To: <20171130004629.GD22908@dragon>
References: <1511950857-19292-1-git-send-email-narmstrong@baylibre.com>
 <1511950857-19292-7-git-send-email-narmstrong@baylibre.com>
 <20171130004629.GD22908@dragon>
Message-ID: <54651ce0-545b-a61b-f8b1-5d03789ede1e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 30/11/2017 01:46, Shawn Guo wrote:
> On Wed, Nov 29, 2017 at 11:20:57AM +0100, Neil Armstrong wrote:
>> This patch adds the missing configs for the DART-MX6 SoM support :
>> - SERDEV bluetooth driver + SERIAL_DEV_BUS configs
>> - WL18XX driver
>> - DEFAULT_ON Led Trigger
>>
>> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> 
> 'ARM: imx_v6_v7_defconfig: ...' or 'ARM: imx: defconfig: ...' please.
> 

Ok done.

Thanks for the review,

Neil

> Shawn
> 
>> ---
>>  arch/arm/configs/imx_v6_v7_defconfig | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
>> index 0d44949..abd06c3 100644
>> --- a/arch/arm/configs/imx_v6_v7_defconfig
>> +++ b/arch/arm/configs/imx_v6_v7_defconfig
>> @@ -80,6 +80,7 @@ CONFIG_CAN=y
>>  CONFIG_CAN_FLEXCAN=y
>>  CONFIG_BT=y
>>  CONFIG_BT_HCIUART=y
>> +CONFIG_BT_HCIUART_SERDEV=y
>>  CONFIG_BT_HCIUART_H4=y
>>  CONFIG_BT_HCIUART_LL=y
>>  CONFIG_CFG80211=y
>> @@ -155,6 +156,7 @@ CONFIG_USB_USBNET=y
>>  CONFIG_USB_NET_CDC_EEM=m
>>  CONFIG_BRCMFMAC=m
>>  CONFIG_WL12XX=m
>> +CONFIG_WL18XX=m
>>  CONFIG_WLCORE_SDIO=m
>>  # CONFIG_WILINK_PLATFORM_DATA is not set
>>  CONFIG_INPUT_EVDEV=y
>> @@ -185,6 +187,8 @@ CONFIG_SERIAL_IMX=y
>>  CONFIG_SERIAL_IMX_CONSOLE=y
>>  CONFIG_SERIAL_FSL_LPUART=y
>>  CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>> +CONFIG_SERIAL_DEV_BUS=y
>> +CONFIG_SERIAL_DEV_CTRL_TTYPORT=y
>>  # CONFIG_I2C_COMPAT is not set
>>  CONFIG_I2C_CHARDEV=y
>>  CONFIG_I2C_MUX=y
>> @@ -248,6 +252,7 @@ CONFIG_VIDEO_OV5640=m
>>  CONFIG_SOC_CAMERA_OV2640=y
>>  CONFIG_IMX_IPUV3_CORE=y
>>  CONFIG_DRM=y
>> +CONFIG_DRM_PANEL_LVDS=y
>>  CONFIG_DRM_PANEL_SIMPLE=y
>>  CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
>>  CONFIG_DRM_DW_HDMI_CEC=y
>> @@ -340,6 +345,7 @@ CONFIG_LEDS_TRIGGER_ONESHOT=y
>>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>>  CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>>  CONFIG_LEDS_TRIGGER_GPIO=y
>> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>>  CONFIG_RTC_CLASS=y
>>  CONFIG_RTC_INTF_DEV_UIE_EMUL=y
>>  CONFIG_RTC_DRV_DS1307=y
>> -- 
>> 2.7.4
>>
