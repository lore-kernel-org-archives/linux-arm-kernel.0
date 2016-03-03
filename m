From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 3 Mar 2016 21:00:57 +0900
Subject: [rtc-linux] Re: [RFC 04/15] irqchip: st: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
In-Reply-To: <2506651.J2Z42d81nD@wuerfel>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <1456992221-26712-5-git-send-email-k.kozlowski@samsung.com>
 <2506651.J2Z42d81nD@wuerfel>
Message-ID: <CAJKOXPcZuyicNAaH6CpOe+bTrLtM1k0tVisS_xJXGDrxyZ_i5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-03-03 19:53 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 03 March 2016 17:03:30 Krzysztof Kozlowski wrote:
>>  config ST_IRQCHIP
>>         bool
>>         select REGMAP
>> +       depends on HAS_IOMEM    # For MFD_SYSCON
>>         select MFD_SYSCON
>>         help
>>           Enables SysCfg Controlled IRQs on STi based platforms.
>>
>
> Not user visible.

Hmmm... you are right (here and in other patches) but why am I getting
all these errors:
warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X
&& DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI &&
TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE &&
S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK &&
RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM
&& ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which
has unmet direct dependencies (HAS_IOMEM)
?
(ARCH=um, allyesconfig)
Adding depends here (and in other places) really helps... but it
should not have any impact...

Thanks for comments,
Krzysztof
