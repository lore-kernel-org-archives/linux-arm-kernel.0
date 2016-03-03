From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 03 Mar 2016 13:28:29 +0100
Subject: [rtc-linux] Re: [RFC 04/15] irqchip: st: Add missing MFD_SYSCON
 dependency on HAS_IOMEM
In-Reply-To: <CAJKOXPcZuyicNAaH6CpOe+bTrLtM1k0tVisS_xJXGDrxyZ_i5A@mail.gmail.com>
References: <1456992221-26712-1-git-send-email-k.kozlowski@samsung.com>
 <2506651.J2Z42d81nD@wuerfel>
 <CAJKOXPcZuyicNAaH6CpOe+bTrLtM1k0tVisS_xJXGDrxyZ_i5A@mail.gmail.com>
Message-ID: <2188157.YL7RR6FeEK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 March 2016 21:00:57 Krzysztof Kozlowski wrote:
> >
> > Not user visible.
> 
> Hmmm... you are right (here and in other patches) but why am I getting
> all these errors:
> warning: (ST_IRQCHIP && HIP04_ETH && STMMAC_PLATFORM && DWMAC_IPQ806X
> && DWMAC_LPC18XX && DWMAC_ROCKCHIP && DWMAC_SOCFPGA && DWMAC_STI &&
> TI_CPSW && PINCTRL_ROCKCHIP && PINCTRL_DOVE && POWER_RESET_KEYSTONE &&
> S3C2410_WATCHDOG && VIDEO_OMAP3 && VIDEO_S5P_FIMC && USB_XHCI_MTK &&
> RTC_DRV_AT91SAM9 && LPC18XX_DMAMUX && VIDEO_OMAP4 && HWSPINLOCK_QCOM
> && ATMEL_ST && QCOM_GSBI && PHY_HI6220_USB) selects MFD_SYSCON which
> has unmet direct dependencies (HAS_IOMEM)
> ?
> (ARCH=um, allyesconfig)

The problem is that Kconfig will just print any option that
selects the one that has a missing dependency, but doesn't
show which of those are actually enabled.

> Adding depends here (and in other places) really helps... but it
> should not have any impact...

I think patch 5 by itself would have been sufficient.

	Arnd
