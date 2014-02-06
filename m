From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Thu,  6 Feb 2014 10:10:15 +0100
Subject: [PATCH 0/3] ARM: dts: Fixes for Overo/Tobi against 3.14-rc1
Message-ID: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc1 [1].
This series fixes this, by moving model-agnostic DT into a common dtsi file,
and creating model-specific DT files:

- omap3-overo-tobi.dts -> older OMAP35xx Overo
- omap3-overo-storm-tobi.dts -> newer OMAP36xx/AM37xx/DM37xx Overo

People will have to use the right Overo / expansion board combination.

(Patch 2 in an unrelated fix that was waiting in my queue.)

omap3-overo-tobi.dts tested with Overo Sand (OMAP3503) and omap3-overo-storm-tobi.dts
tested with Overo EarthStorm (AM3703). Both boot. With the Overo Sand, I cannot
mount the ext3 rootfs, but this seems unrelated to the current topic, maybe
a missing errata.

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110006


Florian Vaussard (3):
  ARM: dts: omap3-tobi: Fix boot with OMAP36xx-based Overo
  ARM: dts: omap3-tobi: Use the correct vendor prefix
  ARM: dts: Add support for both OMAP35xx and OMAP36xx Overo/Tobi

 arch/arm/boot/dts/Makefile                         |  3 ++-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 22 ++++++++++++++++++++++
 ...omap3-tobi.dts => omap3-overo-tobi-common.dtsi} |  3 ---
 arch/arm/boot/dts/omap3-overo-tobi.dts             | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi                 |  3 ---
 5 files changed, 46 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobi.dts
 rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi-common.dtsi} (94%)
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobi.dts

-- 
1.8.1.2
