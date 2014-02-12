From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 12 Feb 2014 09:20:13 -0800
Subject: [GIT PULL] bcm pinctrl rename
Message-ID: <CAEPRUYpCVpV7HwuO6c95ybk3yp1teJgW-9qwyHnjKbs03C9bgQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed:

  Linux 3.14-rc2 (2014-02-09 18:15:47 -0800)

are available in the git repository at:

  git://github.com/broadcom/bcm11351.git tags/bcm-for-3.14-pinctrl-rename

for you to fetch changes up to f5310a1712b68c7f83539fce6ebbfb6f0f510f5b:

  Update dtsi with new pinctrl compatible string (2014-02-12 09:06:53 -0800)

----------------------------------------------------------------
Renaming pinctrl code to keep in line with rest of bcm mobile

Given that this driver has been in the works for a while, it
was written prior to the code standardizing on bcm-based naming.
this patchset brings it in line with the remainder of the code.

----------------------------------------------------------------
Sherman Yin (4):
      pinctrl: Rename Broadcom Capri pinctrl binding
      pinctrl: Rename Broadcom Capri pinctrl driver
      Update bcm_defconfig with new pinctrl CONFIG
      Update dtsi with new pinctrl compatible string

 .../bindings/pinctrl/{brcm,capri-pinctrl.txt =>
brcm,bcm11351-pinctrl.txt}        |    8 +-
 arch/arm/boot/dts/bcm11351.dtsi
            |    2 +-
 arch/arm/configs/bcm_defconfig
            |    2 +-
 drivers/pinctrl/Kconfig
            |    8 +-
 drivers/pinctrl/Makefile
            |    2 +-
 drivers/pinctrl/pinctrl-bcm281xx.c
            | 1461 ++++++++++++++++++++++++++++++++++++++
 drivers/pinctrl/pinctrl-capri.c
            | 1454 -------------------------------------
 7 files changed, 1472 insertions(+), 1465 deletions(-)
 rename Documentation/devicetree/bindings/pinctrl/{brcm,capri-pinctrl.txt
=> brcm,bcm11351-pinctrl.txt} (98%)
 create mode 100644 drivers/pinctrl/pinctrl-bcm281xx.c
 delete mode 100644 drivers/pinctrl/pinctrl-capri.c
