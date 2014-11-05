From: arno@natisbad.org (Arnaud Ebalard)
Date: Wed, 05 Nov 2014 22:42:11 +0100
Subject: [PATCHv0 0/3] rtc: rtc-isl12057: fixes and alarm support
Message-ID: <cover.1415222752.git.arno@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series includes three patches for Intersil ISL12057 driver.

 - first patch is a fix for masking issues which dates back to driver
   inclusion. Even if those issues are not critical per se, the patch is
   a good candidate for stable down to 3.14.

 - second patch fixes remaining places where 'isl' is used instead of the
   expected NASDAQ symbol for Intersil (i.e. isil) after commit
   7a6540ca856ae ("ARM: mvebu: Change vendor prefix for Intersil 
   Corporation to isil"). 

 - third patch provides alarm support for Intersil ISL12057. This
   support was not added when the driver was initially pushed in 3.14
   kernel due to the inability to check interrupt support. After some
   soldering, this tests have been performed.

Comments are welcome,

Cheers,

a+

Arnaud Ebalard (3):
  rtc: rtc-isl12057: fix masking of register values
  rtc: rtc-isl12057: fix isil vs isl naming for intersil
  rtc: rtc-isl12057: add alarm support to Intersil ISL12057 RTC driver

 .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +-
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +-
 drivers/rtc/rtc-isl12057.c                         | 319 ++++++++++++++++++++-
 3 files changed, 309 insertions(+), 14 deletions(-)

-- 
2.1.1
