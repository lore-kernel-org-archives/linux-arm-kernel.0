From: lho@apm.com (Loc Ho)
Date: Thu, 10 Apr 2014 12:47:55 -0600
Subject: [PATCH v4 0/3] rtc: Add APM X-Gene SoC RTC driver
Message-ID: <1397155678-26607-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for the APM X-Gene SoC RTC driver.

v4
* Clean up un-needed read RTC_CCVR register in function xgene_rtc_set_alarm
* Update suspend/resume functions to setup clock and IRQ accordingly

v3
* Remove #clock-cell from binding documentation

v2
* Change function xgene_rtc_read_time to return rtc_valid_tm(tm) instead 0

v1
* Initial version

Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>
Signed-off-by: Loc Ho <lho@apm.com>
--
Loc Ho (3):
  Documentation: Add documentation for the APM X-Gene SoC RTC DTS
    binding
  rtc: Add APM X-Gene SoC RTC driver
  arm64: Add APM X-Gene SoC RTC DTS entry

 .../devicetree/bindings/rtc/xgene-rtc.txt          |   27 ++
 arch/arm64/boot/dts/apm-storm.dtsi                 |   21 ++
 drivers/rtc/Kconfig                                |    9 +
 drivers/rtc/Makefile                               |    1 +
 drivers/rtc/rtc-xgene.c                            |  301 ++++++++++++++++++++
 5 files changed, 359 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/xgene-rtc.txt
 create mode 100644 drivers/rtc/rtc-xgene.c
