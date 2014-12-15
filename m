From: linux@roeck-us.net (Guenter Roeck)
Date: Mon, 15 Dec 2014 06:17:59 -0800
Subject: [PATCH 7/8] rtc: st: add new driver for ST's LPC RTC
In-Reply-To: <1418642738-17407-8-git-send-email-lee.jones@linaro.org>
References: <1418642738-17407-1-git-send-email-lee.jones@linaro.org>
 <1418642738-17407-8-git-send-email-lee.jones@linaro.org>
Message-ID: <548EED97.60604@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/15/2014 03:25 AM, Lee Jones wrote:
> ST's Low Power Controller (LPC) controls two devices; watchdog and RTC.
> Only one of the devices can be used at any one time.  This is enforced
> by the correlating MFD driver.  This portion of the driver-set controls
> the Real Time Clock.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   drivers/rtc/Kconfig      |  13 ++
>   drivers/rtc/Makefile     |   1 +
>   drivers/rtc/rtc-st-lpc.c | 330 +++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 344 insertions(+)
>   create mode 100644 drivers/rtc/rtc-st-lpc.c
>
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index a168e96..aa4bd90 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -1355,6 +1355,18 @@ config RTC_DRV_SIRFSOC
>   	  Say "yes" here to support the real time clock on SiRF SOC chips.
>   	  This driver can also be built as a module called rtc-sirfsoc.
>
> +config RTC_DRV_ST_LPC
> +	tristate "STMicroelectronics LPC RTC"
> +	depends on ARCH_STI
> +	depends on OF
> +	select MFD_ST_LPC
> +	help
> +	  Say Y here to include STMicroelectronics Low Power Controller
> +	  (LPC) based RTC support.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called rtc-st-lpc.
> +
>   config RTC_DRV_MOXART
>   	tristate "MOXA ART RTC"
>   	depends on ARCH_MOXART || COMPILE_TEST
> @@ -1390,4 +1402,5 @@ config RTC_DRV_HID_SENSOR_TIME
>   	  rtc-hid-sensor-time.
>
>
> +

Hi Lee,

Yet another empty line ?

Guenter
