From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon,  5 Oct 2015 10:49:40 +0200
Subject: [PATCH 00/17] ARM: pxa: Use PWM lookup tables
Message-ID: <1444034997-9805-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Back when the PWM framework was introduced the concept of PWM lookup
tables was added to allow board code to register a table of PWM devices
and their association with consumers. The goal is to allow drivers to
use a unified method to request PWM devices. At the same time, since no
boards were exposing these tables, fallback code was kept in drivers to
allow old code to remain functional. Unfortunately I got the numbering
of PWM devices wrong, so all these boards should now be without working
backlight control, though only a few cases have been fixed since, so I
guess most of this hardware is largely unused.

This series aims at finally fixing this up. It converts all PXA boards
that hook up a pwm-backlight device to use the new PWM lookup tables.
All patches have been compile-tested, but I don't have access to any of
these boards, so I couldn't verify that they really work.

Thierry

Thierry Reding (17):
  ARM: pxa: cm-x300: Use PWM lookup table
  ARM: pxa: colibri-pxa270-income: Use PWM lookup table
  ARM: pxa: ezx: Use PWM lookup table
  ARM: pxa: hx4700: Remove unused field initializers
  ARM: pxa: lpd270: Use PWM lookup table
  ARM: pxa: magician: Use PWM lookup table
  ARM: pxa: mainstone: Use PWM lookup table
  ARM: pxa: mioa701: Use PWM lookup table
  ARM: pxa: palm27x: Use PWM lookup table
  ARM: pxa: palmtc: Use PWM lookup table
  ARM: pxa: palmte2: Use PWM lookup table
  ARM: pxa: pcm990: Use PWM lookup table
  ARM: pxa: raumfeld: Use PWM lookup table
  ARM: pxa: tavorevb: Use PWM lookup table
  ARM: pxa: viper: Use PWM lookup table
  ARM: pxa: z2: Use PWM lookup table
  ARM: pxa: zylonite: Use PWM lookup table

 arch/arm/mach-pxa/cm-x300.c               |  9 +++++++--
 arch/arm/mach-pxa/colibri-pxa270-income.c |  9 +++++++--
 arch/arm/mach-pxa/ezx.c                   |  9 +++++++--
 arch/arm/mach-pxa/hx4700.c                |  2 --
 arch/arm/mach-pxa/lpd270.c                |  9 +++++++--
 arch/arm/mach-pxa/magician.c              |  9 +++++++--
 arch/arm/mach-pxa/mainstone.c             | 18 ++++++++++++++----
 arch/arm/mach-pxa/mioa701.c               |  9 +++++++--
 arch/arm/mach-pxa/palm27x.c               |  9 +++++++--
 arch/arm/mach-pxa/palmtc.c                |  9 +++++++--
 arch/arm/mach-pxa/palmte2.c               |  9 +++++++--
 arch/arm/mach-pxa/pcm990-baseboard.c      |  9 +++++++--
 arch/arm/mach-pxa/raumfeld.c              | 11 ++++++++---
 arch/arm/mach-pxa/tavorevb.c              | 13 +++++++++----
 arch/arm/mach-pxa/viper.c                 |  9 +++++++--
 arch/arm/mach-pxa/z2.c                    | 13 +++++++++----
 arch/arm/mach-pxa/zylonite.c              |  9 +++++++--
 17 files changed, 124 insertions(+), 41 deletions(-)

-- 
2.5.0
