From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 16 Oct 2015 21:00:40 +0200
Subject: [GIT PULL] pxa for v4.4
Message-ID: <878u72zlif.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin and Olof,

This is the pxa pull request for 4.4 cycle. It is mainly magician enhancement
and fixes. Could you please consider pulling ?

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git pxa-for-4.4

for you to fetch changes up to 54c09889bff6d99c8733eed4a26c9391b177c88b:

  ARM: pxa: remove incorrect __init annotation on pxa27x_set_pwrmode (2015-10-16 20:52:39 +0200)

----------------------------------------------------------------
This is the pxa changes for v4.4 cycle.

This cycle is bigger than usual :
 - magician was greatly enhanced (new IPs discovered, ...)
 - almost all legacy board files have been updated to the
   new PWM API (mostly for backlight control)
 - some minor fixes in raumfeld, z2 and mioa701

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: pxa: remove incorrect __init annotation on pxa27x_set_pwrmode

Jarkko Nikula (1):
      ARM: pxa: Remove unused clock_enable field from struct pxa2xx_spi_master

Petr Cvek (22):
      ARM: pxa: magician: Fix indentation in machine files
      ARM: pxa: magician: Print more specific error message for global GPIOs
      ARM: pxa: magician: Optimize debug messages for LCD power
      ARM: pxa: magician: Change description of LCD power GPIO
      ARM: pxa: magician: Add new discovered EGPIO pins
      ARM: pxa: magician: Rename abstract LCD GPIOs
      ARM: pxa: magician: Optimize powerup delays for Samsung LCD
      ARM: pxa: magician: Rename charger cable detection EGPIOs
      ARM: pxa: magician: Optimize Samsung LCD refresh to 50Hz
      ARM: pxa: magician: Fix and add charging detection functions
      ARM: pxa: magician: Fix platform data for both PXA27x I2C controllers
      ARM: pxa: magician: Fix redundant GPIO request for pxaficp_ir
      ARM: pxa: magician: Fix support for Intel Strata NOR Flash
      ARM: pxa: magician: Fix wrongly enabled USB host ports
      ARM: pxa: magician: Remove definition of the STUART port
      ARM: pxa: magician: Add debug message for backlight brightness function
      ARM: pxa: magician: Add missing regulator for PWM backlight
      ARM: pxa: magician: Move platform_add_devices() to the end of magician_init()
      ARM: pxa: magician: Change comments to be more informative
      ARM: pxa: magician: Add support for MAX1587A Vcore regulator
      ARM: pxa: magician: Add support for PXA27x UDC
      ARM: pxa: magician: Remove pdata for pasic3-leds

Robert Jarzmik (2):
      ARM: pxa: add resources to pxaficp_ir
      ARM: pxa: mioa701: add wm9713 codec

Thierry Reding (17):
      ARM: pxa: colibri-pxa270-income: Use PWM lookup table
      ARM: pxa: ezx: Use PWM lookup table
      ARM: pxa: hx4700: Remove unused field initializers
      ARM: pxa: lpd270: Use PWM lookup table
      ARM: pxa: magician: Use PWM lookup table
      ARM: pxa: mainstone: Use PWM lookup table
      ARM: pxa: mioa701: Use PWM lookup table
      ARM: pxa: palm27x: Use PWM lookup table
      ARM: pxa: palmte2: Use PWM lookup table
      ARM: pxa: pcm990: Use PWM lookup table
      ARM: pxa: raumfeld: Use PWM lookup table
      ARM: pxa: viper: Use PWM lookup table
      ARM: pxa: palmtc: Use PWM lookup table
      ARM: pxa: cm-x300: Use PWM lookup table
      ARM: pxa: tavorevb: Use PWM lookup table
      ARM: pxa: z2: Use PWM lookup table
      ARM: pxa: zylonite: Use PWM lookup table

Uwe Kleine-K?nig (1):
      ARM: pxa: raumfeld: make some variables static

 Documentation/spi/pxa2xx                  |   6 -
 arch/arm/mach-pxa/cm-x300.c               |   9 +-
 arch/arm/mach-pxa/colibri-pxa270-income.c |   9 +-
 arch/arm/mach-pxa/devices.c               |  20 +
 arch/arm/mach-pxa/ezx.c                   |   9 +-
 arch/arm/mach-pxa/hx4700.c                |   3 -
 arch/arm/mach-pxa/icontrol.c              |   2 -
 arch/arm/mach-pxa/include/mach/magician.h |  70 +--
 arch/arm/mach-pxa/include/mach/pxa27x.h   |   2 +-
 arch/arm/mach-pxa/lpd270.c                |   9 +-
 arch/arm/mach-pxa/magician.c              | 680 ++++++++++++++++++------------
 arch/arm/mach-pxa/mainstone.c             |  19 +-
 arch/arm/mach-pxa/mioa701.c               |  11 +-
 arch/arm/mach-pxa/palm27x.c               |   9 +-
 arch/arm/mach-pxa/palmtc.c                |   9 +-
 arch/arm/mach-pxa/palmte2.c               |   9 +-
 arch/arm/mach-pxa/pcm990-baseboard.c      |   9 +-
 arch/arm/mach-pxa/pxa27x.c                |   2 +-
 arch/arm/mach-pxa/raumfeld.c              |  21 +-
 arch/arm/mach-pxa/tavorevb.c              |  13 +-
 arch/arm/mach-pxa/viper.c                 |   9 +-
 arch/arm/mach-pxa/z2.c                    |  15 +-
 arch/arm/mach-pxa/zylonite.c              |   9 +-
 include/linux/spi/pxa2xx_spi.h            |   1 -
 24 files changed, 608 insertions(+), 347 deletions(-)

-- 
Robert
