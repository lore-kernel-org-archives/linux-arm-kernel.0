From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Wed, 9 May 2018 17:46:07 +0200
Subject: [PATCH v2 0/3] Introduce STM32MP1 RTC
Message-ID: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces STM32MP1 RTC.
On STM32MP1:
- two clocks are needed, plck and rtc_ck;
- to wakeup the system, a wakeup alarm interrupt is needed;
- some registers or bits have moved, but the operation is the same;
- the Backup Domain Protection (DBP) is not managed by RTC driver.

---
Changes in v2:
* One compatible per line in bindings file
* Remove unnecessary comment under rtc_ck as this clock is required for all
* Remove interrupts-extended and add stm32mp1 rtc alarm wakeup interrupt in
  interrupts property description

Amelie Delaunay (3):
  rtc: stm32: rework register management to prepare other version of RTC
  dt-bindings: rtc: update stm32-rtc documentation for stm32mp1 rtc
  rtc: stm32: add stm32mp1 rtc support

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  27 +-
 drivers/rtc/rtc-stm32.c                            | 272 ++++++++++++++++-----
 2 files changed, 228 insertions(+), 71 deletions(-)

-- 
2.7.4
