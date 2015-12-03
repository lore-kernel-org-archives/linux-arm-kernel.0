From: mw@semihalf.com (Marcin Wojtas)
Date: Thu,  3 Dec 2015 15:20:48 +0100
Subject: [PATCH net 0/3] Marvell Armada 375 mvpp2 fixes
Message-ID: <1449152451-2939-1-git-send-email-mw@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

During my work on mvneta driver I revised mvpp2, and it occurred that the
initial version of Marvell Armada 375 SoC comprised bugs around
DMA-unmapping in both ingress and egress paths - not all buffers were
umapped in TX path and none(!) in RX. Three patches that I send fix
this situation.

Any feedback would be welcome.

Best regards,
Marcin Wojtas

Marcin Wojtas (3):
  net: mvpp2: fix missing DMA region unmap in egress processing
  net: mvpp2: fix buffers' DMA handling on RX path
  net: mvpp2: fix refilling BM pools in RX path

 drivers/net/ethernet/marvell/mvpp2.c | 52 +++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 19 deletions(-)

-- 
1.8.3.1
