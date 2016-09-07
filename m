From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  7 Sep 2016 12:31:21 +0200
Subject: [PATCH 0/8] ARM: dts: bcm283x: add and use pinctrl groups
Message-ID: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

Patches 1-4 of this series add pinctrl group declarations for the
bcm283x.  Picked them up from Eric's git branches and the rpi mailing
list.  They alone should not break anything as they have no effect at
all without patches 5-8.  But even unused pinctrl groups are useful to
have for documentation purposes, so I'd like to see those land in the
next merge window even in case patches 5-8 are considered to be too
risky.

Patches 5-8 put some of these pinctrl groups into use, by adding them
to the devices they belong to (and removing the pins from &gpio at the
same time).  That should in theory not break anything too as we only move
the pinctrl setup to another place, but you never know ...

I've tested it on rpi2 and rpi3 hardware without any problems showing up.
/sys/kernel/debug/pinctrl/3f200000.gpio/pinmux-pins is more informative
with the patches applied.

cheers,
  Gerd

Eric Anholt (3):
  ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.
  ARM: dts: bcm283x: Add a group for mapping pins 48-53 to sdhost.
  ARM: dts: bcm283x: Add a new EMMC pin group from the downstream tree.

Gerd Hoffmann (5):
  ARM: dts: bcm283x: Add the emmc pin group to bcm283x.dtsi.
  ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio

 arch/arm/boot/dts/bcm2835-rpi.dtsi |  12 ++-
 arch/arm/boot/dts/bcm283x.dtsi     | 183 +++++++++++++++++++++++++++++++++++++
 2 files changed, 193 insertions(+), 2 deletions(-)

-- 
1.8.3.1
