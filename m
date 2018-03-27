From: davem@davemloft.net (David Miller)
Date: Tue, 27 Mar 2018 13:28:22 -0400 (EDT)
Subject: [PATCH 0/7] net: thunderx: implement DMAC filtering support
In-Reply-To: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
References: <20180327150736.10718-1-Vadim.Lomovtsev@caviumnetworks.com>
Message-ID: <20180327.132822.403377635482599502.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
Date: Tue, 27 Mar 2018 08:07:29 -0700

> From: Vadim Lomovtsev <Vadim.Lomovtsev@cavium.com>
> 
> By default CN88XX BGX accepts all incoming multicast and broadcast
> packets and filtering is disabled. The nic driver doesn't provide
> an ability to change such behaviour.
> 
> This series is to implement DMAC filtering management for CN88XX
> nic driver allowing user to enable/disable filtering and configure
> specific MAC addresses to filter traffic.

This doesn't even compile:

drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function ?bgx_lmac_save_filter?:
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:286:3: warning: ?return? with no value, in function returning non-void [-Wreturn-type]
   return;
   ^~~~~~
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:281:12: note: declared here
 static int bgx_lmac_save_filter(struct lmac *lmac, u64 dmac, u8 vf_id)
            ^~~~~~~~~~~~~~~~~~~~
In file included from drivers/net/ethernet/cavium/thunder/nic.h:15:0,
                 from drivers/net/ethernet/cavium/thunder/thunder_bgx.c:21:
drivers/net/ethernet/cavium/thunder/thunder_bgx.c: In function ?bgx_set_dmac_cam_filter_mac?:
drivers/net/ethernet/cavium/thunder/thunder_bgx.h:61:38: warning: left shift count >= width of type [-Wshift-count-overflow]
 #define  RX_DMACX_CAM_LMACID(x)   (x << 49)
                                      ^
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:324:8: note: in expansion of macro ?RX_DMACX_CAM_LMACID?
  cfg = RX_DMACX_CAM_LMACID(lmacid & LMAC_ID_MASK) |
        ^~~~~~~~~~~~~~~~~~~
