From: eddie.huang@mediatek.com (Eddie Huang)
Date: Thu, 6 Aug 2015 15:22:09 +0800
Subject: [PATCH v2 0/2] Mediatek I2C fixup 
Message-ID: <1438845731-17805-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provide two patches to optimize mediatek i2c driver.
The first patch will reset dma hardware in init function to make sure
hardware work in good state. The second patch fix i2c interrupt handling
for ACK error. All these patches base on 4.2-rc1.

Change in v2:
Fix multi-transfer fail bug - in mtk_i2c_irq(), call complete()
if get I2C_RS_TRANSFER interrupt

Eddie Huang (2):
  i2c: mediatek: Reset DMA engine in hardware init function
  i2c: mediatek: Fixup i2c ack error interrupt handling

 drivers/i2c/busses/i2c-mt65xx.c |   21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

-- 
1.7.9.5
