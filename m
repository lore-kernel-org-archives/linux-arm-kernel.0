From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 20 Mar 2014 19:07:59 -0400
Subject: [GIT PULL] Keystone DTS fixes for 3.15
Message-ID: <1395356879-3009-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arm-soc folks,

Please pull below keystone DTS fixes for 3.15. It merges ok with 'next/dt'
heads with a trivial makefile conflict. For the dependencies it is based
on top of the previous Keystone 3.15 pull request [1]

The following changes since commit 3babe30608dcfec811d64268bd9dc30b7c638e69:

  ARM: dts: keystone: use common "ti,keystone" compatible instead of -evm (2014-03-20 17:00:27 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-dts-fixes

for you to fetch changes up to 3babe30608dcfec811d64268bd9dc30b7c638e69:

  ARM: dts: keystone: use common "ti,keystone" compatible instead of -evm (2014-03-20 17:00:27 -0400)

----------------------------------------------------------------
Keystone DTS fixes for 3.15

- Few fixes found during NAND ubifs testing
- Fix to build all dtbs together with dtbs
- Last patch is follow up comment from previous pull request

----------------------------------------------------------------

Ivan Khoronzhuk (3):
  ARM: dts: keystone: Fix domain register range for clkfftc1
  ARM: dts: keystone: Fix control register range for clktsip
  ARM: dts: keystone: use common "ti,keystone" compatible instead of
    -evm

Murali Karicheri (1):
  ARM: dts: k2hk-evm: set ubifs partition size for 512M NAND

Santosh Shilimkar (1):
  ARM: dts: Build all keystone dt blobs

 .../devicetree/bindings/arm/keystone/keystone.txt  |    6 +++---
 arch/arm/boot/dts/Makefile                         |    3 +++
 arch/arm/boot/dts/k2e-evm.dts                      |    2 +-
 arch/arm/boot/dts/k2hk-clocks.dtsi                 |    4 ++--
 arch/arm/boot/dts/k2hk-evm.dts                     |    4 ++--
 arch/arm/boot/dts/k2l-evm.dts                      |    2 +-
 arch/arm/mach-keystone/keystone.c                  |    5 +----
 7 files changed, 13 insertions(+), 13 deletions(-)

Regards,
Santosh

[1] http://www.spinics.net/lists/arm-kernel/msg313078.html


-- 
1.7.9.5
