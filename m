From: nm@ti.com (Nishanth Menon)
Date: Sat, 16 Dec 2017 14:40:32 -0600
Subject: [PATCH V2 0/8] ARM: dts: keystone*: Stage 1 cleanup for W=1
In-Reply-To: <20171215132102.435-1-nm@ti.com>
References: <20171215132102.435-1-nm@ti.com>
Message-ID: <20171216204040.18017-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
The following changes have been done in the updated series:
* Updates for couple few typo errors in commit messages
* copyrights are now always behind description
* rebased to maintainer branch (was previously against master)

Rebased to:
 git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git 
 for_4.16/keystone-dts : 7fbec17465fc ARM: dts: k2g-evm: Enable UART 2

Warnings in the baseline: http://pastebin.ubuntu.com/26196712/ (247)
After this series: http://pastebin.ubuntu.com/26196713/ (96)

Other related patches:
https://patchwork.kernel.org/patch/10114913/ from Mathieu

NOTE: There is yet another follow on series squashing another 33 or so warnings
from Andrew Davis which is pending some internal reviews - hopefully
should be out around early next week.

V1: https://marc.info/?l=devicetree&m=151334424726964&w=2

Nishanth Menon (8):
  ARM: dts: keystone*: Standardize license with SPDX tag
  ARM: dts: keystone*: Use a single soc0 instance
  ARM: dts: keystone: Get rid of usage of skeleton.dtsi
  ARM: dts: keystone: Add missing unit name to interrupt controller
  ARM: dts: keystone-clocks: Add missing unit name to clock nodes that
    have regs
  ARM: dts: keystone-hk-clocks: Add missing unit name to clock nodes
    that have regs
  ARM: dts: keystone-k2e-clocks: Add missing unit name to clock nodes
    that have regs
  ARM: dts: keystone-k2l-clocks: Add missing unit name to clock nodes
    that have regs

 arch/arm/boot/dts/keystone-clocks.dtsi      | 59 ++++++++++-----------
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi  | 15 +++---
 arch/arm/boot/dts/keystone-k2e-evm.dts      | 11 ++--
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi   |  7 +--
 arch/arm/boot/dts/keystone-k2e.dtsi         | 11 ++--
 arch/arm/boot/dts/keystone-k2g-evm.dts      | 12 +----
 arch/arm/boot/dts/keystone-k2g-ice.dts      |  3 +-
 arch/arm/boot/dts/keystone-k2g.dtsi         | 14 ++---
 arch/arm/boot/dts/keystone-k2hk-clocks.dtsi | 81 ++++++++++++++---------------
 arch/arm/boot/dts/keystone-k2hk-evm.dts     | 57 ++++++++++----------
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi  |  7 +--
 arch/arm/boot/dts/keystone-k2hk.dtsi        | 11 ++--
 arch/arm/boot/dts/keystone-k2l-clocks.dtsi  | 51 +++++++++---------
 arch/arm/boot/dts/keystone-k2l-evm.dts      | 11 ++--
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi   |  7 +--
 arch/arm/boot/dts/keystone-k2l.dtsi         | 11 ++--
 arch/arm/boot/dts/keystone.dtsi             | 18 +++----
 17 files changed, 164 insertions(+), 222 deletions(-)

-- 
2.14.1
