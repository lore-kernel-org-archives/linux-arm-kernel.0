From: coelho@ti.com (Luciano Coelho)
Date: Wed, 31 Jul 2013 00:15:19 +0300
Subject: [PATCH v2 0/4] ARM: dts: add WiLink support to panda and omap4-sdp
Message-ID: <1375218923-29876-1-git-send-email-coelho@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

In v2: use IRQ_TYPE_LEVEL_HIGH when defining the interrupts, as
suggested by Laurent.


These patches add the necessary DT configuration to use the WLAN part
of WiLink on OMAP4 Pandaboard and on OMAP4-SDP (including Blaze).

I've tested these changes on Panda and it works fine.  But I couldn't
test the OMAP4 SDP changes properly on 3.11-rc3 because I'm having
problems with clocks and SDIO stuff.  So it's pretty much just
compiled tested.  I've tried this (without the new clock definition
stuff) on Blaze with 3.10 and it was working, though.

Please take a look and let me know what you think.

Luca.

Luciano Coelho (4):
  ARM: dts: omap4-panda: add MMC5 (WiLink WLAN) configuration
  arm: dts: omap4-panda-common: add WiLink6 device tree nodes
  ARM: dts: omap4-sdp: add MMC5 (WiLink WLAN) configuration
  arm: dts: omap4-sdp: add WiLink7 device tree node

 arch/arm/boot/dts/omap4-panda-common.dtsi | 46 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/omap4-sdp.dts           | 50 +++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletion(-)

-- 
1.8.3.2
