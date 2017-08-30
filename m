From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 30 Aug 2017 15:54:17 +0530
Subject: [net-next PATCHv6 0/2] net: ethernet: Socionext Netsec
Message-ID: <1504088657-6102-1-git-send-email-jaswinder.singh@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

  The OGMA/Netsec controller is used in latest SoC from Socionext/Fujitsu.

I am refreshing the patchset by basically using official name of the IP
from 'OGMA' to 'Netsec'. And the company is renamed too, from Fujitsu
to Socionext to better reflect the reality.

 I have addressed comments (that could be) on the last revision -->
https://patchwork.kernel.org/patch/4540651/

 Of course, I have scanned changes to the drivers/net/ethernet since
last submission and integrated whichever applicable and rebased the
driver on top of last rc.

Thanks.

Jassi Brar (2):
  dt-bindings: net: Add DT bindings for Socionext Netsec
  net: socionext: Add NetSec driver

 .../devicetree/bindings/net/socionext-netsec.txt   |  46 ++
 drivers/net/ethernet/Kconfig                       |   1 +
 drivers/net/ethernet/Makefile                      |   1 +
 drivers/net/ethernet/socionext/Kconfig             |  29 +
 drivers/net/ethernet/socionext/Makefile            |   1 +
 drivers/net/ethernet/socionext/netsec/Makefile     |   6 +
 drivers/net/ethernet/socionext/netsec/netsec.h     | 386 +++++++++++++
 .../socionext/netsec/netsec_desc_ring_access.c     | 618 +++++++++++++++++++++
 .../net/ethernet/socionext/netsec/netsec_ethtool.c |  76 +++
 .../ethernet/socionext/netsec/netsec_gmac_access.c | 329 +++++++++++
 .../net/ethernet/socionext/netsec/netsec_netdev.c  | 558 +++++++++++++++++++
 .../ethernet/socionext/netsec/netsec_platform.c    | 330 +++++++++++
 12 files changed, 2381 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/socionext-netsec.txt
 create mode 100644 drivers/net/ethernet/socionext/Kconfig
 create mode 100644 drivers/net/ethernet/socionext/Makefile
 create mode 100644 drivers/net/ethernet/socionext/netsec/Makefile
 create mode 100644 drivers/net/ethernet/socionext/netsec/netsec.h
 create mode 100644 drivers/net/ethernet/socionext/netsec/netsec_desc_ring_access.c
 create mode 100644 drivers/net/ethernet/socionext/netsec/netsec_ethtool.c
 create mode 100644 drivers/net/ethernet/socionext/netsec/netsec_gmac_access.c
 create mode 100644 drivers/net/ethernet/socionext/netsec/netsec_netdev.c
 create mode 100644 drivers/net/ethernet/socionext/netsec/netsec_platform.c

-- 
2.7.4
