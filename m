From: rjui@broadcom.com (Ray Jui)
Date: Sun, 7 Dec 2014 18:38:31 -0800
Subject: [PATCH v2 0/5] Add gpio support to Broadcom Cygnus SoC
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1418006316-324-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial GPIO support for the Broadcom Cygnus SoC.
Cygnus has 3 GPIO controllers: 1) the ASIU GPIO; 2) the chipCommonG GPIO;
and 3) the ALWAYS-ON GPIO. All 3 types of GPIO controllers are supported by
the same Cygnus GPIO driver

Changes from v1:
 - Get rid of inline qualifier
 - Get rid of redundant check in the ISR
 - Other minor fixes to imrove code readability

Ray Jui (5):
  gpio: Cygnus: define Broadcom Cygnus GPIO binding
  gpio: Cygnus: add GPIO driver
  ARM: mach-bcm: Enable GPIO support for Cygnus
  ARM: dts: enable GPIO for Broadcom Cygnus
  MAINTAINERS: Entry for Cygnus GPIO driver

 .../devicetree/bindings/gpio/brcm,cygnus-gpio.txt  |   85 +++
 MAINTAINERS                                        |    7 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |   30 +
 arch/arm/mach-bcm/Kconfig                          |    1 +
 drivers/gpio/Kconfig                               |   11 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-bcm-cygnus.c                     |  712 ++++++++++++++++++++
 7 files changed, 847 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/brcm,cygnus-gpio.txt
 create mode 100644 drivers/gpio/gpio-bcm-cygnus.c

-- 
1.7.9.5
