From: liguo.zhang@mediatek.com (Liguo Zhang)
Date: Tue, 27 Oct 2015 16:59:25 +0800
Subject: [PATCH 0/2] Mediatek I2C driver fixup 
Message-ID: <1445936367-30141-1-git-send-email-liguo.zhang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contain two patches, first is to optimize Mediatek I2C driver to use WRRD
if hardware support auto restart. Because auto restart will issue auto restart
interrupt, change to use WRRD can reduce interrupt latency. The second is to fix
multi transfer error in high speed mode. If hardware support auto restart, need driver
to send master code first.

Liguo Zhang (2):
  i2c: mediatek: add i2c first write then read optimization
  i2c: mediatek: fix i2c multi transfer issue in high speed mode

 drivers/i2c/busses/i2c-mt65xx.c | 77 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 6 deletions(-)

--
1.8.1.1.dirty
