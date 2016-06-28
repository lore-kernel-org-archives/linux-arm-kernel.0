From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 20:46:17 +0800
Subject: [GIT PULL 2/5] i.MX soc updates for 4.8
In-Reply-To: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
References: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1467117980-20063-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.8

for you to fetch changes up to 18245c24259acaea4584464bf0215bf413dc7d23:

  ARM: imx: add support for i.MX 7Solo (2016-06-28 10:44:44 +0800)

----------------------------------------------------------------
The i.MX SoC changes for 4.8:
 - A patch series including both cpuidle and FEC driver changes to
   disable deeper idle states when FEC is active while board level
   workaround for ERR006687 is not available
 - A number patches to fix sparse warnings and spell errors
 - A fix for TZIC FIQ translation from VIRQ to HWIRQ
 - Support compatible of i.MX7 Solo SoC which has a subset of i.MX7 Dual

----------------------------------------------------------------
Alexander Shiyan (2):
      ARM: i.MX: Fix FIQ interrupt handling for TZIC
      ARM: i.MX: Disable supervisor protect for i.MX51

Ben Dooks (4):
      ARM: imx: fix missing includes
      ARM: imx: fix missing include of common.h
      ARM: imx6: fix static declaration in include/soc/imx/cpuidle.h
      ARM: imx6: fix missing <soc/imx/cpuidle.h> in cpuidle-imx6q.c

Jean Guyomarc'h (1):
      ARM: mach-imx6q: fix spelling mistake in error message

Lucas Stach (1):
      ARM: imx6: disable deeper idle states when FEC is active w/o HW workaround

Shawn Guo (1):
      ARM: imx6q: export cpuidle functions needed by fec driver

Stefan Agner (1):
      ARM: imx: add support for i.MX 7Solo

 Documentation/devicetree/bindings/net/fsl-fec.txt |  3 +++
 arch/arm/mach-imx/avic.c                          | 19 ++++++++---------
 arch/arm/mach-imx/cpuidle-imx6q.c                 | 20 ++++++++++++++++++
 arch/arm/mach-imx/devices/devices.c               |  3 +++
 arch/arm/mach-imx/devices/platform-gpio-mxc.c     |  1 +
 arch/arm/mach-imx/irq-common.c                    |  6 ++++--
 arch/arm/mach-imx/mach-imx51.c                    |  2 ++
 arch/arm/mach-imx/mach-imx6q.c                    |  2 +-
 arch/arm/mach-imx/mach-imx7d.c                    |  1 +
 arch/arm/mach-imx/tzic.c                          |  6 +++---
 drivers/net/ethernet/freescale/fec.h              |  2 ++
 drivers/net/ethernet/freescale/fec_main.c         | 12 +++++++++++
 include/soc/imx/cpuidle.h                         | 25 +++++++++++++++++++++++
 13 files changed, 85 insertions(+), 17 deletions(-)
 create mode 100644 include/soc/imx/cpuidle.h
