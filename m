From: ayaka@soulik.info (Randy Li)
Date: Sat,  9 Jul 2016 17:23:43 +0800
Subject: [PATCH 0/3] making rtc cores from s3c6410 and exynos3250 both work
Message-ID: <1468056226-19128-1-git-send-email-ayaka@soulik.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 8792f7772f4f40ffc68bad5f28311205584b734d would just make those
platform using rtc core from exynos3250 work but have a huge 
effect on those platforms using the rtc core from s3c6410.
These patches would fix this problem.

Randy Li (3):
  Revert "drivers/rtc/rtc-s3c.c: add .needs_src_clk to s3c6410 RTC data"
  rtc: s3c: add device data for samsung,exynos3250-rtc
  ARM: dts: exynos: correct the rtc compatible value for exynos5

 arch/arm/boot/dts/exynos3250.dtsi |  2 +-
 arch/arm/boot/dts/exynos5.dtsi    |  2 +-
 drivers/rtc/rtc-s3c.c             | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.7.4
