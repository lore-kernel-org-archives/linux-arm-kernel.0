From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Thu, 31 Jan 2013 16:03:04 +0530
Subject: [PATCH 0/3] Add DT support for davinci_mmc driver
Message-ID: <1359628387-14437-1-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch set adds DT support for davinci_mmc driver and is
verified on da850-evm without card_detect/write_protect and
EDMA support.

This patch depends on below patches under review:
1) Patch "pinctrl: pinctrl-single: use arch_initcall and module_exit"
	http://www.gossamer-threads.com/lists/linux/kernel/1669067
2) Patch "drivers/pinctrl: grab default handles from device core"
	http://www.gossamer-threads.com/lists/linux/kernel/1664015?page=last
3) Patch "mmc: davinci: allow driver to work without DMA resource"
	http://permalink.gmane.org/gmane.linux.kernel.mmc/18978

Applies on top of v3.9/dt branch of linux_davinci tree:
git://gitorious.org/linux-davinci/linux-davinci.git

Manjunathappa, Prakash (3):
  ARM: davinci: da850: override mmc DT node device name
  mmc: davinci_mmc: add DT support
  ARM: davinci: da850: add mmc DT entries

 .../devicetree/bindings/mmc/davinci_mmc.txt        |   23 +++++++
 arch/arm/boot/dts/da850-evm.dts                    |   13 ++++
 arch/arm/boot/dts/da850.dtsi                       |   15 ++++
 arch/arm/mach-davinci/da8xx-dt.c                   |    8 ++-
 drivers/mmc/host/davinci_mmc.c                     |   69 +++++++++++++++++++-
 5 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt

-- 
1.7.4.1
