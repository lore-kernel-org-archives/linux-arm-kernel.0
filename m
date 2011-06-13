From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jun 2011 15:37:19 +0800
Subject: [PATCH 0/6] Some fixes and cleanup on imx-dma device registration
Message-ID: <1307950645-26529-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch set makes some small fixes on imx-dma device registration
code, and then cleans up the code by breaking the concentrated
imx-dma device registration into soc specific setup function.
This is basically what gpio-mxc device registration is doing.
In this way, we can avoid the churn of "#ifdef" and the cpu_is_mx
checking on such a long list of soc family, which makes no sense,
considering more soc supports need to be added and we need to
support single image for multiple socs in the long run.

Shawn Guo (6):
      ARM: mxc: imx-sdma device gets 16K iosize than 4K
      ARM: mxc: sdma on imx25 is a V2 block
      ARM: mxc: change imx-dma default to_version to 1
      ARM: mxc: imx-dma on imx25 has no other TO version but TO1
      ARM: mxc: all three imx51 TOs use TO1 version of sdma script
      ARM: mxc: clean up imx-dma device registration

 arch/arm/mach-imx/mm-imx21.c                    |    3 +
 arch/arm/mach-imx/mm-imx25.c                    |   26 +++
 arch/arm/mach-imx/mm-imx27.c                    |    3 +
 arch/arm/mach-imx/mm-imx31.c                    |   24 +++
 arch/arm/mach-imx/mm-imx35.c                    |   44 +++++
 arch/arm/mach-mx5/mm.c                          |   23 +++
 arch/arm/plat-mxc/devices.c                     |   16 ++-
 arch/arm/plat-mxc/devices/platform-imx-dma.c    |  204 ++---------------------
 arch/arm/plat-mxc/include/mach/devices-common.h |    6 +
 9 files changed, 157 insertions(+), 192 deletions(-)
