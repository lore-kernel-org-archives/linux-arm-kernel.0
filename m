From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 02 Apr 2015 16:36:14 +0200
Subject: [PATCH 0/2] Arndale Octa: Fix S2MPS11 RTC alarm IRQ
Message-ID: <1427985376-20420-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

After long struggle this finally fixes the S2MPS11 RTC alarm IRQ
on Arndale Octa board. It can easily be tested with:
rtcwake -d rtc0 -m on -s 5 -v

The patches are independent.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  mfd: sec: Fix RTC alarm interrupt number on S2MPS11
  ARM: dts: Fix pinctrl settings for S2MPS11 RTC alarm IRQ on Arndale
    Octa

 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 13 ++++++++++++-
 drivers/mfd/sec-irq.c                         | 14 ++++++++++----
 include/linux/mfd/samsung/irq.h               |  2 +-
 3 files changed, 23 insertions(+), 6 deletions(-)

-- 
1.9.1
