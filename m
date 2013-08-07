From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:23:55 +0900
Subject: [GIT PULL 0/4] Renesas ARM based SoC defconfig updates for v3.12
Message-ID: <cover.1375842392.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider these Renesas ARM based SoC defconfig updates for v3.12.


In relation to adding a new defconfig I would like to note that Magnus and
I are aware of your ongoing requests to reduce the number of shmobile
defconfigs and that we are making progress on that front in two ways:

* Two boards, and their defconfigs were scheduled for removal in v3.11
  and a further two boards and their defconfigs are scheduled for removal
  in v3.12.

  For reference the boards are: ap5evb, bonito, ag5evm and kota2

* More importantly, we are making significant progress towards being
  able to use multiplatform and thus consolidate most if not all
  of the shmobile defconfigs into either a single shmobile defconfig
  or a more generic ARM defconfig.

  The removal of the boards mentioned above helps this process
  by removing the need to update as much code. In particular code
  which we have limited or no access to hardware to test.

  The main remaining barrier here is common clocks which I current
  expect to take a few more release cycles to get in order.


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v3.12

for you to fetch changes up to 461cd47a65f5d8513a983ebd21ef7c23d4b4730f:

  ARM: shmobile: ape6evm: Enable gpio-leds in defconfig (2013-08-06 10:14:09 +0900)

----------------------------------------------------------------
Renesas ARM based SoC defconfig updates for v3.12

* Enable GPIO LEDs and keys for ape6evm board
* Enable ARM_APPENDED_DTB for marzen board
* Add lager defconfig board

----------------------------------------------------------------
Simon Horman (4):
      ARM: shmobile: marzen: Enable ARM_APPENDED_DTB in defconfig
      ARM: shmobile: Add lager defconfig
      ARM: shmobile: ape6evm: Enable gpio-keys in defconfig
      ARM: shmobile: ape6evm: Enable gpio-leds in defconfig

 arch/arm/configs/ape6evm_defconfig |   6 +-
 arch/arm/configs/lager_defconfig   | 120 +++++++++++++++++++++++++++++++++++++
 arch/arm/configs/marzen_defconfig  |   1 +
 3 files changed, 126 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/configs/lager_defconfig
