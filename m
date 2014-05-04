From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sun,  4 May 2014 15:42:57 -0700
Subject: [PATCH 0/5] net: macb: Fixes
Message-ID: <1399243382-12528-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Nicolas,

I think I found the cause of the issue I told you about. Looks like
driver and HW are racing (a few more details in the commit message).
On my way finding that, I found a few more minor issues which are fixed
in the first patches.
The last one is "fixing" the actual race. I don't know if I overlooked
anything here, but this seems to work fine on Zynq.

	Thanks,
	S?ren


Soren Brinkmann (5):
  net: macb: Pass same size to DMA_UNMAP as used for DMA_MAP
  net: macb: Clear interrupt flags
  net: macb: Re-enable RX interrupt only when RX is done
  net: macb: Remove 'unlikely' optimization
  net: macb: Fix race between HW and driver

 drivers/net/ethernet/cadence/macb.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

-- 
1.9.2.1.g06c4abd
