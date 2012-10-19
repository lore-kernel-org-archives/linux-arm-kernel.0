From: afzal@ti.com (Afzal Mohammed)
Date: Fri, 19 Oct 2012 15:29:08 +0530
Subject: [PATCH v4 0/5] rtc: omap dt support (for am33xx)
Message-ID: <cover.1350633036.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

This series enhances rtc-omap driver so as to be usable on
am33xx SoC by adding DT support (Beagle Bone uses am33xx).
This is a revised version of series that was posted on
27th July 2012 with the subject,
"omap-am33xx rtc dt support".
It seems rtc maintainer in inactive and hence sending it you.

Please help this reach mainline.

Brief:
Enhance rtc-omap driver to make it DT capable. This is
required to support boards that boot only with DT like
Beagle Bone. rtc-omap driver is used in DaVinci platforms
and they are also now going DT way, and these changes make
their DT migration easier. rtc-omap driver is made
intelligent enough to handle kicker mechanism. This also
helps in removing kicker mechanism support done for DaVinci
at platform level.

This series has been made over 3.7-rc1

This has been tested on Beaglebone (am33xx platform) and on
DaVinci da850 evm.

Regards
Afzal

v4:
 Resolve build error during module build
 Improve DT documentation

v3:
 Remove unit address in DT node
 Use readb/writeb instead of __raw_* variants
 Remove unnecessary parens

v2:
 Use device name da830-rtc instead of am1808-rtc, similar change in
 compatible for DT
 Newly added register name made similar to that existing in the driver
 Better commit message description
 Modify Kconfig help, resolve checkpatch warning


Afzal Mohammed (4):
  rtc: omap: kicker mechanism support
  ARM: davinci: remove rtc kicker release
  rtc: omap: dt support
  rtc: omap: depend on am33xx

Vaibhav Hiremath (1):
  rtc: omap: Add runtime pm support

 Documentation/devicetree/bindings/rtc/rtc-omap.txt | 17 +++++
 arch/arm/mach-davinci/devices-da8xx.c              | 13 +---
 drivers/rtc/Kconfig                                | 10 +--
 drivers/rtc/rtc-omap.c                             | 80 +++++++++++++++++++++-
 4 files changed, 101 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-omap.txt

-- 
1.7.12
