From: vz@mleia.com (Vladimir Zapolskiy)
Date: Sun, 18 Oct 2015 00:35:49 +0300
Subject: [PATCH v2 0/8] arm: dts: lpc32xx: updates to LPC32xx SoC and boards
Message-ID: <1445117757-8073-1-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The change improves description of NXP LPC32xx hardware, among
important changes it adds standard timers and external memory
controller nodes, splits PWM device node into two,

Changes from v1 to v2:
- removed v1 2/5 "arm: dts: lpc32xx: fix improper usage of ranges property"
- v1 4/5 "arm: dts: lpc32xx: remove unneeded cell settings from cpus"
  is replaced by v2 3/8 "arm: dts: lpc32xx: add reg property to cpu device node"
- new change, sets physical memory offset for EA3250 and PHY3250 v5/8
- new change, added EMC device node v2 6/8
- new change, added standard timer nodes v2 7/8
- new change, grouped USB subdevices together v2 8/8

Link to the obsolete patch series:
- http://www.spinics.net/lists/arm-kernel/msg451745.html

Vladimir Zapolskiy (8):
  arm: dts: lpc32xx: change include syntax to be C preprocessor friendly
  arm: dts: lpc32xx: add labels to all defined peripheral nodes
  arm: dts: lpc32xx: add reg property to cpu device node
  arm: dts: lpc32xx: add device node for the second pwm controller
  arm: dts: ea3250/phy3250: specify phys memory offset for lpc32xx boards
  arm: dts: lpc32xx: add external memory controller device node
  arm: dts: lpc32xx: add device nodes for standard timers
  arm: dts: lpc32xx: move USB controller subdevices into own device node

 arch/arm/boot/dts/ea3250.dts   |  41 +++++-------
 arch/arm/boot/dts/lpc32xx.dtsi | 142 ++++++++++++++++++++++++++++++-----------
 arch/arm/boot/dts/phy3250.dts  |  41 +++++-------
 3 files changed, 139 insertions(+), 85 deletions(-)

-- 
2.1.4
