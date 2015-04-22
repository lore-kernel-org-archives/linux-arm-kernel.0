From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 22 Apr 2015 20:58:12 +0800
Subject: [PATCH 0/2] PCI: designware: improve iATU programming and usage
Message-ID: <1429707494-2732-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The outbound iATU programming functions are similar, so PATCH1 consolidates
them into one.

Most transactions' type are cfg0 and MEM, so current iATU usage is not
balanced. PATCH2 adopts idea from Minghuan Lian <Minghuan.Lian@freescale.com>:

 http://www.spinics.net/lists/linux-pci/msg40440.html

to change the iATU allocation: iATU0 for cfg and IO, iATU1 for MEM.

Jisheng Zhang (2):
  PCI: designware: consolidate outbound iATU programming functions
  PCI: designware: use iATU0 for cfg and IO, iATU1 for MEM

 drivers/pci/host/pcie-designware.c | 144 ++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 82 deletions(-)

-- 
2.1.4
