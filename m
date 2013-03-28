From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Mar 2013 10:44:14 +0800
Subject: [GIT PULL] imx fixes for 3.9, take 4
In-Reply-To: <20130328024256.GG5429@S2101-09.ap.freescale.net>
References: <20130328024256.GG5429@S2101-09.ap.freescale.net>
Message-ID: <CAAQ0ZWRJpjHekAsALm09Scqiz+0XoZLbVDRKiNvseuX5xkx6GA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 287939a3690c8da6fd3310d7593ff0448cb9447c:

  ARM: imx: add dependency check for DEBUG_IMX_UART_PORT (2013-03-19
13:56:05 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-fixes-3.9-4

for you to fetch changes up to 2f3edfd7e27ad4206acbc2ae99c9df5f46353024:

  ARM: imx: fix sync issue between imx_cpu_die and imx_cpu_kill
(2013-03-26 20:25:45 +0800)

----------------------------------------------------------------
The imx fixes for 3.9, take 4:

Running suspend/resume without no_console_suspend setting on kernel
cmdline will likely makes system hang.  It causesd by the sync issue
between imx_cpu_die() and imx_cpu_kill() call.  Fix the issue by
synchronizing the calls using cpu jumping argument register which is
free to use in kernel.

----------------------------------------------------------------
Shawn Guo (1):
      ARM: imx: fix sync issue between imx_cpu_die and imx_cpu_kill

 arch/arm/mach-imx/common.h  |    2 ++
 arch/arm/mach-imx/hotplug.c |   12 ++++++++++++
 arch/arm/mach-imx/src.c     |   12 ++++++++++++
 3 files changed, 26 insertions(+)
