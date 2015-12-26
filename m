From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Sat, 26 Dec 2015 02:43:48 -0800
Subject: [PATCH LINUX v5 0/8] tty: xuartps: Fix lock ups
Message-ID: <1451126636-13699-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

as requested by Peter, this is the first part of my series which has the
patches reviewed by Peter. I'll submit the second part separately. There
are no new changes within the patches.

	Thanks,
	S?ren

S?ren Brinkmann (8):
  tty: xuartps: Beautify read-modify writes
  tty: xuartps: Use spinlock to serialize HW access
  tty: xuartps: Don't consider circular buffer when enabling transmitter
  tty: xuartps: Clear interrupt status register in shutdown
  tty: xuartps: Improve startup function
  tty: xuartps: Keep lock for whole ISR
  tty: xuartps: Acquire port lock for shutdown
  tty: xuartps: Move RX path into helper function

 drivers/tty/serial/xilinx_uartps.c | 117 +++++++++++++++++++++----------------
 1 file changed, 66 insertions(+), 51 deletions(-)

-- 
2.6.3.3.g9bb996a
