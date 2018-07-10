From: yibin.gong@nxp.com (Robin Gong)
Date: Wed, 11 Jul 2018 00:23:09 +0800
Subject: [PATCH v1 0/4] add memcpy support for sdma
Message-ID: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset is to add memcpy interface for imx-sdma, besides,to
support dmatest and enable config related, so that easily test dma
without any other device support such as uart/audio/spi...

Robin Gong (4):
  dmaengine: imx-sdma: add memcpy interface
  dmaengine: imx-sdma: add check_bd_buswidth() to kill the dulicated
    code
  dmaengine: imx-sdma: support dmatest
  ARM: configs: imx_v6_v7_defconfig: add DMATEST support

 arch/arm/configs/imx_v6_v7_defconfig |   3 +-
 drivers/dma/imx-sdma.c               | 172 ++++++++++++++++++++++++++++-------
 2 files changed, 139 insertions(+), 36 deletions(-)

-- 
2.7.4
