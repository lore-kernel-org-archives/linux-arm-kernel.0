From: tony@atomide.com (Tony Lindgren)
Date: Wed,  5 Nov 2014 10:35:45 -0800
Subject: [PATCH 0/5] Few fixes for omaps to reduce bootup noise
Message-ID: <1415212550-24692-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are few fixes to reduce bootup errors and warnings when
booting omaps in device tree mode. All these are non-critical,
so these are intended for the v3.19 merge window unless somebody
comes up with a real need for these earlier.

Regards,

Tony


Tony Lindgren (5):
  ARM: OMAP3: Fix errors for omap_l3_smx when booted with device tree
  ARM: dts: Fix NAND last partition size on LDP
  ARM: dts: Add twl keypad map for LDP
  ARM: dts: Add twl keypad map for LDP
  ARM: OMAP4+: Remove unused omap_l3_noc platform init

 arch/arm/boot/dts/omap3-evm-common.dtsi | 21 +++++++++++++++++++
 arch/arm/boot/dts/omap3-ldp.dts         | 23 ++++++++++++++++++++-
 arch/arm/boot/dts/omap3.dtsi            |  2 +-
 arch/arm/mach-omap2/devices.c           | 36 +--------------------------------
 drivers/bus/omap_l3_smx.c               | 26 +++++++++++++++++++-----
 5 files changed, 66 insertions(+), 42 deletions(-)

-- 
2.1.1
