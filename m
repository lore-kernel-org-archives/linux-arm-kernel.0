From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  6 Jul 2015 12:19:22 +0200
Subject: [PATCH 0/2] dmaengine: Add scatter-gathered memset support
Message-ID: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

Here is a patch serie that adds a new dmaengine operation for
scatter-gathered memset.

Indeed, doing a memset over a discontiguous buffer is quite
inefficient at the moment, since you have to create and submit each
chunk separately, which might result in a huge list of transfers,
while some controllers can handle that just fine.

Let me know what you think,
Maxime

Maxime Ripard (2):
  dmaengine: Add scatter-gathered memset
  dmaengine: xdmac: Add scatter gathered memset support

 drivers/dma/at_xdmac.c    | 166 +++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/dmaengine.h |   5 ++
 2 files changed, 170 insertions(+), 1 deletion(-)

-- 
2.4.5
