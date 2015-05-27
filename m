From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 May 2015 16:01:51 +0200
Subject: [PATCH 0/2] dmaengine: hdmac: Implement interleaved transfers support
Message-ID: <1432735313-481-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This patchset implements the interleaved transfer capability found on
some AT91 SoCs.

The hardware actually support a somewhat similar mode called
picture-in-picture, that allows to transfer a squared portion of a
framebuffer.

That actually means that the interleaved transfer that this hardware
support will need to have the same size and ICGs across all its
chunks.

It has been tested on the SAMA5D36.

Let me know what you think!
Maxime

Maxime Ripard (2):
  dmaengine: Move icg helpers to global header
  dmaengine: hdmac: Implement interleaved transfers

 drivers/dma/at_hdmac.c      | 106 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/at_hdmac_regs.h |   5 +++
 drivers/dma/at_xdmac.c      |  46 ++-----------------
 include/linux/dmaengine.h   |  27 +++++++++++
 4 files changed, 142 insertions(+), 42 deletions(-)

-- 
2.4.1
