From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Tue, 27 Mar 2018 08:07:29 -0700
Subject: [PATCH 0/7] net: thunderx: implement DMAC filtering support
Message-ID: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>

By default CN88XX BGX accepts all incoming multicast and broadcast
packets and filtering is disabled. The nic driver doesn't provide
an ability to change such behaviour.

This series is to implement DMAC filtering management for CN88XX
nic driver allowing user to enable/disable filtering and configure
specific MAC addresses to filter traffic.

Vadim Lomovtsev (7):
  net: thunderx: move filter register related macro into proper place
  net: thunderx: add MAC address filter tracking for LMAC
  net: thunderx: add multicast filter management support
  net: thunderx: add new messages for handle ndo_set_rx_mode callback
  net: thunderx: add XCAST messages handlers for PF
  net: thunderx: add workqueue control structures for handle
    ndo_set_rx_mode request
  net: thunderx: add ndo_set_rx_mode callback implementation for VF

 drivers/net/ethernet/cavium/thunder/nic.h         |  29 ++++
 drivers/net/ethernet/cavium/thunder/nic_main.c    |  45 ++++-
 drivers/net/ethernet/cavium/thunder/nicvf_main.c  | 108 +++++++++++-
 drivers/net/ethernet/cavium/thunder/thunder_bgx.c | 196 ++++++++++++++++++++--
 drivers/net/ethernet/cavium/thunder/thunder_bgx.h |  17 +-
 5 files changed, 366 insertions(+), 29 deletions(-)

-- 
2.14.3
