From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Mon,  7 Mar 2016 13:05:55 +0530
Subject: [PATCH 0/2] net: thunderx: Performance enhancement changes
Message-ID: <1457336157-31508-1-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

Below patches attempts to improve performance by reducing
no of atomic operations while allocating new receive buffers
and reducing cache misses by adjusting nicvf structure elements.

Sunil Goutham (2):
  net: thunderx: Set recevie buffer page usage count in bulk
  net: thunderx: Adjust nicvf structure to reduce cache misses

 drivers/net/ethernet/cavium/thunder/nic.h          |   51 ++++++++++++--------
 drivers/net/ethernet/cavium/thunder/nicvf_queues.c |   31 +++++++++---
 2 files changed, 53 insertions(+), 29 deletions(-)
