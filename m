From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Tue, 25 Jun 2013 10:54:43 +0200
Subject: [PATCH 0/6] Various ux500 crypto updates
Message-ID: <1372150489-25594-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Herbert,

these are some fixes to issue pointed out by sparse and dmaengine API
udpates on the recently enabled ux500 hw crypto drivers.

These are based on recent linux-next, and can probably be applied on an
architecture specific branch with your ack, or just skip to the next
merge window.

Thanks,
Fabio


Fabio Baltieri (6):
  crypto: ux500/hash: use readl on iomem addresses
  crypto: ux500/hash: add missing static qualifiers
  crypto: ux500/crypt: add missing __iomem qualifiers
  crypto: ux500: use dmaengine_device_control API
  crypto: ux500: use dmaengine_prep_slave_sg API
  crypto: ux500: use dmaengine_submit API

 drivers/crypto/ux500/cryp/cryp.c      |  4 ++--
 drivers/crypto/ux500/cryp/cryp_core.c | 26 +++++++++++++-------------
 drivers/crypto/ux500/hash/hash_core.c | 33 ++++++++++++++++-----------------
 3 files changed, 31 insertions(+), 32 deletions(-)

-- 
1.8.2
