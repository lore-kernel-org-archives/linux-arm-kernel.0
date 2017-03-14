From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 14 Mar 2017 11:52:08 +0100
Subject: [GIT PULL] ARM: at91: fixes for 4.11
Message-ID: <20170314105208.gamqtnumihav7tbf@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are two fixes for 4.11. The revert is reverting a DT patch that
went through the USB tree but should have never been applied.

The second patch fixes an issue were the SoC hangs when using
at91_cpuidle.


The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-fixes

for you to fetch changes up to 60b89f1928af80b546b5c3fd8714a62f6f4b8844:

  ARM: at91: pm: cpu_idle: switch DDR to power-down mode (2017-03-14 11:09:50 +0100)

----------------------------------------------------------------
Fixes for 4.11:

 - Fix USB host for sama5d2
 - Fix cpuidle on sama5

----------------------------------------------------------------
Nicolas Ferre (1):
      ARM: at91: pm: cpu_idle: switch DDR to power-down mode

Romain Izard (1):
      Revert "ARM: at91/dt: sama5d2: Use new compatible for ohci node"

 arch/arm/boot/dts/sama5d2.dtsi |  2 +-
 arch/arm/mach-at91/pm.c        | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/afc6d989/attachment.sig>
