From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 15:21:39 +0200
Subject: [PATCH 0/4] Various fixes on STM32 RTC
Message-ID: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series makes some corrections on STM32 RTC:
- update copyright and adopt SPDX identifier
- fix alarm interrupt flags
- rework DBP (Disable Backup domain Protection) management.

This series is a preamble to the serie which will introduce next STM32 RTC
version.

Amelie Delaunay (4):
  rtc: stm32: fix copyright and adopt SPDX identifier
  rtc: stm32: fix alarm interrupt flags by removing IRQF_TRIGGER_RISING
  dt-bindings: rtc: update stm32-rtc documentation for st,syscfg
    property
  rtc: stm32: get DBP register and mask from DT st,syscfg property

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       | 10 ++--
 drivers/rtc/rtc-stm32.c                            | 68 +++++++++++++---------
 2 files changed, 47 insertions(+), 31 deletions(-)

-- 
2.7.4
