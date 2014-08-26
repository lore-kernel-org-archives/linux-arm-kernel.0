From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Aug 2014 11:54:54 +0800
Subject: [PATCH resend v5 0/2] ARM: sunxi: RTC support for A31/A23
Message-ID: <1409025296-6342-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

Resending the sun6i RTC series, rebased onto 3.17-rc1.
The DT/defconfig patches have been queued for 3.18, and therefore
dropped from this series. Hope we can get the driver parts in as
well.

The A31 has a new RTC block that is separate from the timer block.
It has separate interrupts for each of the alarms, and a different
format for the counter alarm. The driver has been tested on the
A31 Hummingbird, and the A23 tablet I'm using to work on sun8i
support.

Patch 1 adds the driver for the RTC.

Patch 2 is a minor cleanup. This makes rtc-sunxi depend on sun4i or
sun7i, the 2 platforms the driver is actually used on.


Changes since v4:
  - Added interrupt for alarm 1 to DT bindings for completeness

Changes since v3:
  - reformatted all multi-line function calls to have
    indentation match open parenthesis

Changes since v2:
  - fixed indentation in DT binding docs
  - have function argument indentation match open parenthesis
  - drop driver owner field

Changes since v1:
  - Enable rtc-sun6i in multi_v7_defconfig
  - Cleanup the time/date GET/SET macros
  - Use GENMASK for control register mask
  - Change Kconfig option to show 'A31'
  - Remove leftover comment from rtc-sun4i
  - Remove extra newline


Cheers
ChenYu



Chen-Yu Tsai (2):
  rtc: sun6i: Add sun6i RTC driver
  rtc: sunxi: Depend on platforms sun4i/sun7i that actually have the rtc

 .../devicetree/bindings/rtc/sun6i-rtc.txt          |  17 +
 drivers/rtc/Kconfig                                |   9 +-
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/rtc-sun6i.c                            | 447 +++++++++++++++++++++
 4 files changed, 473 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/sun6i-rtc.txt
 create mode 100644 drivers/rtc/rtc-sun6i.c

-- 
2.1.0
