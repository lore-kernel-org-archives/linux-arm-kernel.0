From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 14:47:45 +0530
Subject: [PATCH 0/9] Pinctrl: SPEAr: Fixes for 3.7-rc3
Message-ID: <cover.1351329224.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

This patchset fixes many errors/mistakes in current pinctrl configurations for
various SPEAr SoCs. Please see if they can be merged in next rc release, if they
look fine to you.

--
viresh

Deepak Sikri (2):
  pinctrl: SPEAr320: Correct pad mux entries for rmii/smii
  pinctrl: SPEAr1340: Make DDR reset & clock pads as gpio

Shiraz Hashim (3):
  pinctrl: SPEAr3xx: correct register space to configure pwm
  pinctrl: SPEAr1310: fix clcd high resolution pin group name
  pinctrl: SPEAr1310: add register entries for enabling pad direction

Vipul Kumar Samar (3):
  pinctrl: SPEAr1310: Fix value of PERIP_CFG reigster and
    MCIF_SEL_SHIFT
  pinctrl: SPEAr1310: Separate out pci pins from pcie_sata pin group
  pinctrl: SPEAr1340: Add clcd sleep mode pin configuration

Viresh Kumar (1):
  pinctrl: SPEAr: Don't update all non muxreg bits on pinctrl_disable

 drivers/pinctrl/spear/pinctrl-spear.c     |   2 +-
 drivers/pinctrl/spear/pinctrl-spear1310.c | 365 ++++++++++++++++++++++++++----
 drivers/pinctrl/spear/pinctrl-spear1340.c |  41 +++-
 drivers/pinctrl/spear/pinctrl-spear320.c  |   8 +-
 drivers/pinctrl/spear/pinctrl-spear3xx.h  |   1 +
 5 files changed, 367 insertions(+), 50 deletions(-)

-- 
1.7.12.rc2.18.g61b472e
