From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Fri, 21 Oct 2016 17:57:18 +0200
Subject: [PATCH 0/5] Remove STiH415/416 SoC platform support remaining parts
Message-ID: <1477065443-10668-1-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

ST have sent patches which remove clock support for these SoCs [1]
which once applied mean the platform will no longer boot.

This series cleans up remaining STi drivers which have
support for these SoC's, by removing code, and updating the DT
documentation accordingly. Some drivers such as st_thermal_syscfg
can be removed completely because the IP is only found on these 
legacy SoC's.

Patrice Chotard (5):
  thermal: st_thermal_syscfg: Remove obsolete STiH415/416 platform
    support.
  ARM: multi_v7_defconfig: Remove ST_THERMAL_SYSCFG Kconfig symbol
  ARM: multi_v7_defconfig: Remove CONFIG_ST_THERMAL_MEMMAP Kconfig
    symbol
  irqchip: st: remove STiH415/416 irqchip support
  irqchip: st: Remove obsolete platforms from dt binding doc

 .../interrupt-controller/st,sti-irq-syscfg.txt     |   6 +-
 arch/arm/configs/multi_v7_defconfig                |   2 -
 drivers/irqchip/irq-st.c                           |  10 --
 drivers/thermal/st/Kconfig                         |   4 -
 drivers/thermal/st/Makefile                        |   1 -
 drivers/thermal/st/st_thermal_syscfg.c             | 178 ---------------------
 6 files changed, 2 insertions(+), 199 deletions(-)
 delete mode 100644 drivers/thermal/st/st_thermal_syscfg.c

-- 
1.9.1
