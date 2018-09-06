From: jun.gao@mediatek.com (Jun Gao)
Date: Thu, 6 Sep 2018 21:15:27 +0800
Subject: [PATCH v3 0/2] Register i2c adapter driver earlier and use DMA safe
 buffers
Message-ID: <1536239729-10008-1-git-send-email-jun.gao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series based on v4.19-rc2, include i2c adapter driver register time
modification and DMA safe buffers used for i2c transactions.

changes since v2:
- Remove the patch i2c: Add helper to ease DMA handling
- Use i2c refactor function to release a DMA safe buffer

changes since v1:
- Add the initializations for DMA safe buffer pointers

Jun Gao (2):
  i2c: mediatek: Register i2c adapter driver earlier
  i2c: mediatek: Use DMA safe buffers for i2c transactions

 drivers/i2c/busses/i2c-mt65xx.c | 74 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 66 insertions(+), 8 deletions(-)

--
1.8.1.1
