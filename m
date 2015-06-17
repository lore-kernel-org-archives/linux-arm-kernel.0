From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 17 Jun 2015 15:28:01 +0100
Subject: [PATCH v2 0/7] xen: Clean up
Message-ID: <1434551288-14113-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thoses patches was originally part of the Xen 64KB series [1]. Although,
I think they can go without waiting the rest of the 64KB series.

Patch #1-#4 should go through the Xen tree, even though patch #1 touches
multiple part.

Patch #5-#7 should go through the Block tree.

Regards,

[1] http://lkml.org/lkml/2015/5/14/533

Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Ian Campbell <ian.campbell@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: netdev at vger.kernel.org
Cc: Roger Pau Monn? <roger.pau@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Wei Liu <wei.liu2@citrix.com>

Julien Grall (7):
  xen: Include xen/page.h rather than asm/xen/page.h
  xen/xenbus: client: Fix call of virt_to_mfn in xenbus_grant_ring
  xen/grant-table: Remove unused macro SPP
  arm/xen: Drop duplicate define mfn_to_virt
  block/xen-blkfront: Remove unused macro MAXIMUM_OUTSTANDING_BLOCK_REQS
  block/xen-blkfront: Remove invalid comment
  block/xen-blkback: s/nr_pages/nr_segs/

 arch/arm/include/asm/xen/page.h     |  1 -
 arch/arm/xen/mm.c                   |  2 +-
 arch/arm/xen/p2m.c                  |  2 +-
 drivers/block/xen-blkback/blkback.c | 10 +++++-----
 drivers/block/xen-blkback/common.h  |  2 +-
 drivers/block/xen-blkfront.c        |  8 --------
 drivers/net/xen-netback/netback.c   |  2 +-
 drivers/net/xen-netfront.c          |  1 -
 drivers/xen/events/events_base.c    |  2 +-
 drivers/xen/events/events_fifo.c    |  2 +-
 drivers/xen/gntdev.c                |  2 +-
 drivers/xen/grant-table.c           |  1 -
 drivers/xen/manage.c                |  2 +-
 drivers/xen/tmem.c                  |  2 +-
 drivers/xen/xenbus/xenbus_client.c  |  8 ++++----
 15 files changed, 18 insertions(+), 29 deletions(-)

-- 
2.1.4
