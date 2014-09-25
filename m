From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Thu, 25 Sep 2014 15:02:05 +0530
Subject: [PATCH v2 0/4] rtc: omap: Add support for regulator supply
Message-ID: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans up the OMAP RTC driver to use per device data structure.
And adds support for regulator supply.

Testing:
RTC functionality test on:
DRA742-evm: http://hastebin.com/avowiyegut.xml
DRA722-evm: http://hastebin.com/hujuyuyato.xml
Beagle Bone Black: http://hastebin.com/fawahapuyi.rb
AM4372-GP-evm: http://hastebin.com/iyitiqeyev.rb (Used an out of tree patch for enabling rtc)

Tested rtc wake using an internal tree with these patches applied:
DRA742-evm: http://hastebin.com/banejadaci.coffee
DRA722-evm: http://hastebin.com/adifefetax.vhdl
Beagle Bone Black: http://hastebin.com/uxezamokiy.coffee
AM4372-GP-evm: http://hastebin.com/ruvetigico.coffee

Lokesh Vutla (3):
  rtc: omap: Introduce rtc_omap_dev structure to include per device data
  rtc: omap: Adopt driver to support probe deferral
  rtc: omap: Support regulator supply for RTC

Tero Kristo (1):
  rtc: omap: Update Kconfig for OMAP RTC

 Documentation/devicetree/bindings/rtc/rtc-omap.txt |   3 +
 drivers/rtc/Kconfig                                |   6 +-
 drivers/rtc/rtc-omap.c                             | 290 +++++++++++++--------
 3 files changed, 182 insertions(+), 117 deletions(-)

-- 
1.9.1
