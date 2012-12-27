From: mikedunn@newsguy.com (Mike Dunn)
Date: Thu, 27 Dec 2012 10:02:16 -0800
Subject: [PATCH v2 0/4]  ARM: pxa: palmtreo: a few treo fixes
Message-ID: <1356631340-30328-1-git-send-email-mikedunn@newsguy.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some miscellaneous fixes to the treo code.

Change log:
v2:
  patch 1: gpio initialization separated out from lcd initialization, per
  	   Marek's suggestion (lcd still initializes correctly this way).
  patch 2: Removed #ifdef CONFIG_MACH_TREO680 from around defines in
  	   both palmtreo.h and leds-gpio device data in palmtreo.c, per Marek's
	   suggestion, and let compiler optimize out unused data (verified).
  patch 3: Use IS_EMABLED macro, per Sergei's suggestion
  patch 4: new patch for v2: use IS_ENABLED elsewhere in file

Mike Dunn (4):
  ARM: palmtreo: fix lcd initilialization on treo680
  ARM: palmtreo: fix #ifdefs for leds-gpio device
  ARM: palmtreo: add docg4 device initialization
  ARM: palmtreo: replace #if defined with IF_ENABLED

 arch/arm/mach-pxa/include/mach/palmtreo.h |    5 +-
 arch/arm/mach-pxa/palmtreo.c              |  101 ++++++++++++++++++++++++++---
 2 files changed, 94 insertions(+), 12 deletions(-)

-- 
1.7.8.6
