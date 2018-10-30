From: kurt@linutronix.de (Kurt Kanzenbach)
Date: Tue, 30 Oct 2018 10:31:37 +0100
Subject: [PATCH 0/2] net: xlinx: mdio: recheck condition after timeout
Message-ID: <20181030093139.10226-1-kurt@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the Xilinx mdio wait functions may return false positives under certain
circumstances: If the functions get preempted between reading the corresponding
mdio register and checking for the timeout, they could falsely indicate a
timeout.

In order to avoid the issue, the condition should be rechecked in the timeout
case.

Kurt Kanzenbach (2):
  net: axienet: recheck condition after timeout in mdio_wait()
  net: xilinx_emaclite: recheck condition after timeout in mdio_wait()

 drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c | 21 ++++++++++++++++-----
 drivers/net/ethernet/xilinx/xilinx_emaclite.c     | 20 +++++++++++++++-----
 2 files changed, 31 insertions(+), 10 deletions(-)

-- 
2.11.0
