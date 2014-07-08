From: s-anna@ti.com (Suman Anna)
Date: Tue, 8 Jul 2014 11:21:59 -0500
Subject: [PATCH 0/2] couple of generic remoteproc enhancements
Message-ID: <1404836521-59637-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

The following are couple of generic enhancements to the remoteproc core.
The changes are developed to support adding new rproc drivers for processors
like the WkupM3 processor on AM335/AM437, but are generic enough to apply to
non-OMAP devices as well.

The first patch allows MMU-enabled processors like OMAP IPU/DSP as well as
other non-MMU enabled processors on multi-arch kernel images.

The second-patch was developed as part of enabling internal memory loading
of firmware segments on OMAP DSPs, but will also be used by the WkupM3 
remoteproc driver that Dave Gerlach is gonna submit soon.

The two patches are based on 3.16-rc4 and are technically independent of each
other, but submitting them together as the WkupM3 remoteproc driver would need
both of them.

regards
Suman

Suman Anna (2):
  remoteproc: use a flag to detect the presence of IOMMU
  remoteproc: add support to handle internal memories

 drivers/remoteproc/omap_remoteproc.c |   6 +++
 drivers/remoteproc/remoteproc_core.c | 100 ++++++++++++++++++++++++++++++-----
 include/linux/remoteproc.h           |  45 +++++++++++++++-
 3 files changed, 136 insertions(+), 15 deletions(-)

-- 
2.0.0
