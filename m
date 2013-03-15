From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 15 Mar 2013 11:36:39 +0800
Subject: [PATCH 0/2] ASoC: dmaengine_pcm: support generic DMA binding users
Message-ID: <1363318601-31505-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series adds a snd_dmaengine_generic_pcm_open() for users that
adopt generic DMA binding and helplers.

Vinod,

AS per the request from Mark, I add the first patch to mark name
parameter of dmaengine helpers as const, so that clients can mark
const on their side.

We need to have these two patches on a topic branch, as I've heard
a few people converting their ASoC driver needing the patches.  Can
you ack the first patch, so that Mark can maintain them in a branch
for anyone who needs it to pull?

Shawn Guo (2):
  dmaengine: add const for name parameter
  ASoC: dmaengine_pcm: add snd_dmaengine_generic_pcm_open()

 drivers/dma/dmaengine.c       |    2 +-
 drivers/dma/of-dma.c          |    6 +++---
 include/linux/dmaengine.h     |    7 ++++---
 include/linux/of_dma.h        |    2 +-
 include/sound/dmaengine_pcm.h |    2 ++
 sound/soc/soc-dmaengine-pcm.c |   39 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 50 insertions(+), 8 deletions(-)

-- 
1.7.9.5
