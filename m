From: jason.hui@linaro.org (Jason Liu)
Date: Wed, 24 Aug 2011 13:04:31 +0800
Subject: [[PATCH v2 0/6] imx soc revision clean up
Message-ID: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patchset make some clean up for the imx soc revision display by
- introudce the generic function for displaying silicon revision
- update the imx SoCs to adopt the same usage

The patchset is based on Fabio's initial commit and I did some update

V2: Address comments from Sascha
- Remove the EXPORT_SYMBOL from imx_print_silicon_rev
- Fix the mx31 print twice issue

Fabio Estevam (1):
  ARM: imx: Introduce generic function for displaying silicon revision

Jason Liu (5):
  ARM: mx25: Print silicon revision on boot
  ARM: mx27: Print silicon revision on boot
  ARM: mx31: use generic function for displaying silicon revision
  ARM: mx35: use generic function for displaying silicon revision
  ARM: mx5: use generic function for displaying silicon revision

 arch/arm/mach-imx/Makefile              |    2 +-
 arch/arm/mach-imx/clock-imx25.c         |    6 +++
 arch/arm/mach-imx/clock-imx27.c         |    2 +
 arch/arm/mach-imx/clock-imx31.c         |    4 +-
 arch/arm/mach-imx/clock-imx35.c         |    3 +-
 arch/arm/mach-imx/cpu-imx25.c           |   41 +++++++++++++++++
 arch/arm/mach-imx/cpu-imx27.c           |   28 +++++------
 arch/arm/mach-imx/cpu-imx31.c           |   48 +++++++++++---------
 arch/arm/mach-imx/cpu-imx35.c           |   30 ++++++-------
 arch/arm/mach-mx5/clock-mx51-mx53.c     |    6 +--
 arch/arm/mach-mx5/cpu.c                 |   74 +++++++------------------------
 arch/arm/plat-mxc/cpu.c                 |    9 ++++
 arch/arm/plat-mxc/include/mach/common.h |    1 +
 arch/arm/plat-mxc/include/mach/mx25.h   |    4 ++
 arch/arm/plat-mxc/include/mach/mx3x.h   |   18 +-------
 15 files changed, 142 insertions(+), 134 deletions(-)
 create mode 100644 arch/arm/mach-imx/cpu-imx25.c

-- 
1.7.4.1
