From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 11:40:58 +0200
Subject: [PATCH v2 0/2] dmaengine: hdmac: Add scatter-gathered memset support
Message-ID: <1445506860-22619-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Here is a patch serie that adds support in the Atmel HDMAC for memset
over a discontiguous memory area.

Just like for the memset, it's used on those SoCs to support
framebuffer related operations that cannot be performed either by the
display engine or the (non-existent) GPU.

Let me know what you think,
Maxime

Changes from v1:
  - Cosmetic change in the first patch to not wrap a line anymore
  - Rebased on top of current dma/next

Maxime Ripard (2):
  dmaengine: hdmac: factorise memset descriptor allocation
  dmaengine: hdmac: Add scatter-gathered memset support

 drivers/dma/at_hdmac.c      | 168 ++++++++++++++++++++++++++++++++++----------
 drivers/dma/at_hdmac_regs.h |   2 +-
 2 files changed, 133 insertions(+), 37 deletions(-)

-- 
2.6.2
