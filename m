From: heiko@sntech.de (Heiko =?windows-1252?q?St=FCbner?=)
Date: Wed, 4 Jan 2012 15:14:57 +0100
Subject: [PATCH v4 0/4] Implement RTC support for S3C2443/S3C2416/S3C2450
In-Reply-To: <201201041512.55126.heiko@sntech.de>
References: <201112211014.30695.heiko@sntech.de>
 <201201041251.42509.heiko@sntech.de> <201201041512.55126.heiko@sntech.de>
Message-ID: <201201041514.57688.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Similar to the ADC the RTC of S3C2443 and S3C2416/2450 has some slight
variances when compared to the existing types.

This series adds support for those SoCs.

As with the ADC patches, these changes where tested on S3C2416 hardware.
The S3C2443 quirks are a subset of those and are done according to the
datasheet, but not tested on real hardware (as I do not own a S3C2443 device).

changes since v3:
fixes missing "," in s3c_rtc_dt_match and wrong handling of the
of_device_id.data property, as reported-by Sylwester Nawrocki

changes since v2:
remove obsolete constants in register cleanup

changes since v1:
address comments from Thomas Abraham, reducing number of ifdefs and
duplicate code


Heiko Stuebner (4):
  ARM: SAMSUNG: cleanup of rtc register definitions
  rtc-s3c: make room for more variants in devicetree block
  rtc-s3c: add variants for S3C2443 and S3C2416
  ARM: S3C2443/S3C2416: add s3c_rtc_setname and rename rtc devices

 arch/arm/mach-s3c2416/s3c2416.c               |    2 +
 arch/arm/mach-s3c2443/s3c2443.c               |    2 +
 arch/arm/plat-samsung/include/plat/regs-rtc.h |   81 +++++++++++++------------
 arch/arm/plat-samsung/include/plat/rtc-core.h |   27 ++++++++
 drivers/rtc/rtc-s3c.c                         |   71 ++++++++++++++++++----
 5 files changed, 131 insertions(+), 52 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/rtc-core.h

-- 
1.7.5.4
