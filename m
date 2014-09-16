From: monstr@monstr.eu (Michal Simek)
Date: Tue, 16 Sep 2014 13:07:41 +0200
Subject: [GIT PULL] Xilinx Zynq changes for v3.18
Message-ID: <541819FD.5000301@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

please pull these patches to your arm-soc tree.

Thanks,
Michal

The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.xilinx.com/linux-xlnx.git tags/zynq-cleanup-for-3.18

for you to fetch changes up to 8097171e19bb69f3e2226827440b71ececa5d74f:

  ARM: zynq: Remove useless L2C AUX setting (2014-09-16 12:55:12 +0200)

----------------------------------------------------------------
arm: Xilinx Zynq cleanup patches for v3.18

- PM support
- Fix L2 useless setting

----------------------------------------------------------------
Daniel Lezcano (2):
      ARM: zynq: Remove invalidate cache for cpu die
      ARM: zynq: cpuidle: Remove pointless code

Michal Simek (1):
      ARM: zynq: Remove useless L2C AUX setting

Soren Brinkmann (7):
      ARM: zynq: PM: Enable A9 internal clock gating feature
      Documentation: devicetree: Add binding for Synopsys DDR controller
      ARM: zynq: DT: Add DDRC node
      ARM: zynq: PM: Enable DDR clock stop
      ARM: zynq: Synchronise zynq_cpu_die/kill
      ARM: zynq: Remove hotplug.c
      ARM: zynq: Rename 'zynq_platform_cpu_die'

 Documentation/devicetree/bindings/memory-controllers/synopsys.txt | 11 +++++++++
 arch/arm/boot/dts/zynq-7000.dtsi                                  |  5 ++++
 arch/arm/mach-zynq/Makefile                                       |  3 +--
 arch/arm/mach-zynq/common.c                                       | 11 +++++++--
 arch/arm/mach-zynq/common.h                                       | 16 ++++++++++--
 arch/arm/mach-zynq/hotplug.c                                      | 47 +-----------------------------------
 arch/arm/mach-zynq/platsmp.c                                      | 41 ++++++++++++++++++++++++++++++-
 arch/arm/mach-zynq/pm.c                                           | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-zynq/slcr.c                                         | 43 ++++++++++++++++++++++++++++++++-
 drivers/cpuidle/cpuidle-zynq.c                                    | 10 +-------
 10 files changed, 207 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt
 create mode 100644 arch/arm/mach-zynq/pm.c

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140916/bed3d296/attachment.sig>
