From: manish.narani@xilinx.com (Manish Narani)
Date: Mon, 23 Jul 2018 20:31:59 +0530
Subject: [PATCH v2 0/4] iio: adc: xilinx: XADC driver Enhancements and bug
 fixes
Message-ID: <1532358123-23485-1-git-send-email-manish.narani@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series resolves code style problems as reported by code analysis
tools.

Changes in v2:
	- From the first version of patches, 2 patches are dropped in this
	  series.
	- In the v1 patch set, 1/4 was not required as the issue is in
	  checkpatch.pl script and not in the code.
	- In the v1 patch set 2/4 was applied on togreg branch of iio.git
	- for 3/4 patch in v1 patch set, the patch is broken up in 2 patches
	  in this series as per review comments. They are now 1/4 and 2/4 in
	  this series.
	- 4/4 patch in the v1 patch set was basically to resolve coverity
	  warning for platform_get_irq() in xadc_remove function, but that was
	  causing potential race condition. Fixed that in this series (3/4).
	- A new patch is added in this series for moving request_irq() before
	  enabling interrupts.


Manish Narani (4):
  iio: adc: xilinx: Check for return values in clk related functions
  iio: adc: xilinx: limit pcap clock frequency value
  iio: adc: xilinx: Remove platform_get_irq from xadc_remove function
  iio: adc: xilinx: Move request_irq before enabling interrupts

 drivers/iio/adc/xilinx-xadc-core.c | 40 +++++++++++++++++++++++++++++---------
 drivers/iio/adc/xilinx-xadc.h      |  1 +
 2 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.1.1
