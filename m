From: olof@lixom.net (Olof Johansson)
Date: Mon,  9 Nov 2015 19:33:19 -0800
Subject: [GIT PULL 1/6] ARM: SoC non-urgent fixes for v4.4
In-Reply-To: <1447126404-10567-1-git-send-email-olof@lixom.net>
References: <1447126404-10567-1-git-send-email-olof@lixom.net>
Message-ID: <1447126404-10567-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A handful of fixes that came in and didn't seem warranted to go in through
the 4.3-rc cycle.

- MAINTAINERS updates for one of the Broadcom platforms and lpc18xx
- A couple of non-critical Davinci bugfixes
- A fix to reset irq affinity for TI platforms (silences a warning at reboot)



Conflicts:

None

----------------------------------------------------------------

The following changes since commit ce5c2d2c256a4c8b523036537cd6be2d6af8f69d:

  arm64: fixup for mm renames

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc

for you to fetch changes up to 19c1c32c66514fabeffa029507cdd808b3ee854c:

  MAINTAINERS: update lpc18xx entry with more drivers

----------------------------------------------------------------

Andy Shevchenko (1):
      ARM: davinci: re-use %*ph specifier

Arnd Bergmann (3):
      ARM: cns3xxx: pci: avoid potential stack overflow
      Merge tag 'davinci-for-v4.4/fixes' of git://git.kernel.org/.../nsekhar/linux-davinci into next/fixes-non-critical
      Merge tag 'arm-soc/for-4.4/maintainers' of http://github.com/Broadcom/stblinux into next/fixes-non-critical

Joachim Eastwood (1):
      MAINTAINERS: update lpc18xx entry with more drivers

Jon Mason (1):
      MAINTAINERS: add entry for the Broadcom Northstar Plus SoCs

Murali Karicheri (1):
      soc: ti: reset irq affinity before freeing irq

Peter Ujfalusi (1):
      ARM: davinci: clock: Correct return values for API functions


 MAINTAINERS                              | 19 ++++++-
 arch/arm/mach-cns3xxx/pcie.c             | 71 +++++++++++----------------
 arch/arm/mach-davinci/board-dm644x-evm.c |  4 +-
 arch/arm/mach-davinci/clock.c            | 16 ++++--
 drivers/soc/ti/knav_qmss_acc.c           |  4 ++
 5 files changed, 63 insertions(+), 51 deletions(-)
