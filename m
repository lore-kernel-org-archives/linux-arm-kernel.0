From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 17 Jun 2013 09:48:04 +0530
Subject: [PATCH 0/2] Enable config options to enable S2R wakeup
Message-ID: <1371442686-24999-1-git-send-email-tushar.behera@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RTC source is very useful in testing S2R wakeup. Also enable
gpio-keys driver in case someone wants wakeup the board using
the buttons.

S2R wakeup feature on Arndale depends on following two additional
patches.

1. [PATCH 1/8] ARM: EXYNOS: use generic cpu idle function for wfi
 http://permalink.gmane.org/gmane.linux.linaro.devel/15871

2. [PATCH V2] ARM: dts: Enable RTC node for Arndale
(Posted a couple of minutes back, link not available yet)

S2R wakeup tested on Arndale board with an initramfs through
both RTC wakeup alarm and GPIO button interrupt.

Tushar Behera (2):
  ARM: exynos_defconfig: Enable GPIO buttons driver
  ARM: exynos_defconfig: Enable RTC driver

 arch/arm/configs/exynos_defconfig |    3 +++
 1 file changed, 3 insertions(+)

-- 
1.7.9.5
