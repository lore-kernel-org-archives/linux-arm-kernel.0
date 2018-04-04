From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed,  4 Apr 2018 15:16:23 +0200
Subject: [PATCH 0/4] ARM: imx: use device properties for at24 eeprom
Message-ID: <20180404131627.9135-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to work towards phasing out the at24_platform_data structure.
There are few users and its contents can be represented using generic
device properties. Using device properties only will allow us to
significantly simplify the at24 configuration code.

This series converts all users of at24_platform_data to using generic
device properties or - as is the case with PATCH 1/4 - drops the
platform data entirely since it's not needed.

Bartosz Golaszewski (4):
  ARM: imx: vpr200: drop at24_platform_data
  ARM: imx: pcm043: use device properties for at24 eeprom
  ARM: imx: pca100: use device properties for at24 eeprom
  ARM: imx: pcm037: use device properties for at24 eeprom

 arch/arm/mach-imx/mach-pca100.c | 13 ++++++-------
 arch/arm/mach-imx/mach-pcm037.c | 13 ++++++-------
 arch/arm/mach-imx/mach-pcm043.c | 13 ++++++-------
 arch/arm/mach-imx/mach-vpr200.c |  9 +--------
 4 files changed, 19 insertions(+), 29 deletions(-)

-- 
2.16.3
