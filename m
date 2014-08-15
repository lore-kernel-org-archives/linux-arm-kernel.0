From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 15 Aug 2014 11:12:39 -0400
Subject: [PATCH v2 0/3] net: Add Keystone NetCP ethernet driver support
Message-ID: <1408115562-22487-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update version after incorporating David Miller's comment from earlier
posting [1]. I would like to get these merged for upcoming 3.18 merge
window if there are no concerns on this version.

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
    
NetCP driver has a plug-in module architecture where each of the NetCP
sub-modules exist as a loadable kernel module which plug in to the netcp
core. These sub-modules are represented as "netcp-devices" in the dts
bindings. It is mandatory to have the ethernet switch sub-module for
the ethernet interface to be operational. Any other sub-module like the
PA is optional.

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
 MAINTAINERS                                        |    6 +
 drivers/net/ethernet/ti/Kconfig                    |   15 +-
 drivers/net/ethernet/ti/Makefile                   |    4 +
 drivers/net/ethernet/ti/netcp.h                    |  227 ++
 drivers/net/ethernet/ti/netcp_core.c               | 2276 ++++++++++++++++++++
 drivers/net/ethernet/ti/netcp_ethss.c              | 2178 +++++++++++++++++++
 drivers/net/ethernet/ti/netcp_sgmii.c              |  130 ++
 drivers/net/ethernet/ti/netcp_xgbepcsr.c           |  502 +++++
 9 files changed, 5532 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/keystone-netcp.txt
 create mode 100644 drivers/net/ethernet/ti/netcp.h
 create mode 100644 drivers/net/ethernet/ti/netcp_core.c
 create mode 100644 drivers/net/ethernet/ti/netcp_ethss.c
 create mode 100644 drivers/net/ethernet/ti/netcp_sgmii.c
 create mode 100644 drivers/net/ethernet/ti/netcp_xgbepcsr.c

regards,
Santosh

[1] https://lkml.org/lkml/2014/4/22/805

-- 
1.7.9.5
