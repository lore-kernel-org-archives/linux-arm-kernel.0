From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 4 Apr 2013 09:47:09 +0200
Subject: [GIT PULL] arm-soc: Xilinx zynq core - smp for v3.10
Message-ID: <890ef3b8-f536-4b00-9bd8-5ea50de3bf51@DB8EHSMHS032.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

please pull the following smp support to your arm-soc tree.

This branch is based on zynq/clksrc/cleanup parts because
there are some dependencies on moving timer to generic location.

I could based it on standard Linux tagged version but you will get
several conflicts you will have to resolve.
If you are OK to resolving these problems, please let me know
I will create another branch with core-smp changes which are not based
on zynq/clksrc/cleanup branch.

Thanks,
Michal


The following changes since commit 4f0f234fce1d263cc9881456352e8fd56ead0514:

   arm: zynq: Move timer to generic location (2013-04-04 09:22:09 +0200)

are available in the git repository at:

   git://git.xilinx.com/linux-xlnx.git zynq/core-smp

for you to fetch changes up to c7c28b0fdd06d8eb9414d21f8956b7c773ceea93:

   arm: zynq: Add hotplug support (2013-04-04 09:24:00 +0200)

----------------------------------------------------------------
Michal Simek (7):
       arm: zynq: Load scu baseaddress at run time
       arm: zynq: Move slcr initialization to separate file
       arm: zynq: Add support for system reset
       arm: zynq: Get rid of xilinx function prefix
       arm: zynq: Add smp_twd timer
       arm: zynq: Add smp support
       arm: zynq: Add hotplug support

  arch/arm/boot/dts/zynq-7000.dtsi |    7 ++
  arch/arm/mach-zynq/Kconfig       |    1 +
  arch/arm/mach-zynq/Makefile      |    6 +-
  arch/arm/mach-zynq/common.c      |   67 +++++++++--------
  arch/arm/mach-zynq/common.h      |   20 +++++
  arch/arm/mach-zynq/headsmp.S     |   24 ++++++
  arch/arm/mach-zynq/hotplug.c     |  104 ++++++++++++++++++++++++++
  arch/arm/mach-zynq/platsmp.c     |  152 ++++++++++++++++++++++++++++++++++++++
  arch/arm/mach-zynq/slcr.c        |  125 +++++++++++++++++++++++++++++++
  9 files changed, 476 insertions(+), 30 deletions(-)
  create mode 100644 arch/arm/mach-zynq/headsmp.S
  create mode 100644 arch/arm/mach-zynq/hotplug.c
  create mode 100644 arch/arm/mach-zynq/platsmp.c
  create mode 100644 arch/arm/mach-zynq/slcr.c
