From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 25 Sep 2014 13:48:34 -0400
Subject: [PATCH v5 0/3] net: Add Keystone NetCP ethernet driver support
Message-ID: <1411667317-1163-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v4->v5
Sorry to spin v5 quickly but I missed few check-patch warnings which
were pointed by Joe Perches(thanks). I folded his changes [5] along with
few more check-patch warning fixes. I would like get this in for v3.18
merge window if David is happy with this version.

v3->v4
Couple of fixes in in error path as pointed [4] out by David. Rest of
the patches are unchanged from v3. 

v2->v3
Update v3 after incorporating Jamal and David Miller's comment/suggestion
from earlier versions [1] [2].  After per the discussion here [3], the
controversial custom exports have been dropped now. And for future
future offload support additions, we will plug into generic frameworks
as an when they are available.

The network coprocessor (NetCP) is a hardware accelerator that processes
Ethernet packets. NetCP has a gigabit Ethernet (GbE) subsystem with a ethernet
switch sub-module to send and receive packets. NetCP also includes a packet
accelerator (PA) module to perform packet classification operations such as
header matching, and packet modification operations such as checksum
generation. NetCP can also optionally include a Security Accelerator(SA)
capable of performing IPSec operations on ingress/egress packets.
    
Keystone SoC's also have a 10 Gigabit Ethernet Subsystem (XGbE) which
includes a 3-port Ethernet switch sub-module capable of 10Gb/s and
1Gb/s rates per Ethernet port.
    
Both GBE and XGBE network processors supported using common driver. It
is also designed to handle future variants of NetCP.

Cc: David Miller <davem@davemloft.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Sandeep Nair <sandeep_n@ti.com>

Sandeep Nair (3):
  Documentation: dt: net: Add binding doc for Keystone NetCP ethernet
    driver
  net: Add Keystone NetCP ethernet driver
  MAINTAINER: net: Add TI NETCP Ethernet driver entry

 .../devicetree/bindings/net/keystone-netcp.txt     |  197 ++
 MAINTAINERS                                        |    7 +
 drivers/net/ethernet/ti/Kconfig                    |   12 +-
 drivers/net/ethernet/ti/Makefile                   |    4 +
 drivers/net/ethernet/ti/netcp.h                    |  227 ++
 drivers/net/ethernet/ti/netcp_core.c               | 2262 ++++++++++++++++++++
 drivers/net/ethernet/ti/netcp_ethss.c              | 2173 +++++++++++++++++++
 drivers/net/ethernet/ti/netcp_sgmii.c              |  130 ++
 drivers/net/ethernet/ti/netcp_xgbepcsr.c           |  502 +++++
 9 files changed, 5513 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/net/keystone-netcp.txt
 create mode 100644 drivers/net/ethernet/ti/netcp.h
 create mode 100644 drivers/net/ethernet/ti/netcp_core.c
 create mode 100644 drivers/net/ethernet/ti/netcp_ethss.c
 create mode 100644 drivers/net/ethernet/ti/netcp_sgmii.c
 create mode 100644 drivers/net/ethernet/ti/netcp_xgbepcsr.c

Regards,
Santosh
[1] https://lkml.org/lkml/2014/4/22/805
[2] https://lkml.org/lkml/2014/8/15/218
[3] https://lkml.org/lkml/2014/9/11/691
[4] https://lkml.org/lkml/2014/9/15/403
[5] https://lkml.org/lkml/2014/9/25/332
-- 
1.7.9.5
