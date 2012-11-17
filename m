From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 21:02:36 -0700
Subject: [GIT PULL 2/3] ARM: bcm2835: core SoC enhancements
In-Reply-To: <1353124957-23808-1-git-send-email-swarren@wwwdotorg.org>
References: <1353124957-23808-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1353124957-23808-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A machine restart/reboot implementation is added. The GPIO/pinmux
controller is instantiated, and dummy gpio.h added.

----------------------------------------------------------------

The following changes since commit 6f0c0580b70c89094b3422ba81118c7b959c7556:

  Linux 3.7-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git bcm2835-for-3.8-soc

for you to fetch changes up to 805504abdc73cfc745a5fee3d616cdb24bb2a68c:

  ARM: bcm2835: enable GPIO/pinctrl

----------------------------------------------------------------

Stephen Warren (2):
      ARM: bcm2835: implement machine restart hook
      ARM: bcm2835: enable GPIO/pinctrl

 .../bindings/watchdog/brcm,bcm2835-pm-wdog.txt     |   13 ++++
 arch/arm/Kconfig                                   |    5 +-
 arch/arm/boot/dts/bcm2835-rpi-b.dts                |   15 +++++
 arch/arm/boot/dts/bcm2835.dtsi                     |   28 +++++++++
 arch/arm/mach-bcm2835/bcm2835.c                    |   46 +++++++++++++++
 arch/arm/mach-bcm2835/include/mach/gpio.h          |    1 +
 6 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,bcm2835-pm-wdog.txt
 create mode 100644 arch/arm/mach-bcm2835/include/mach/gpio.h
