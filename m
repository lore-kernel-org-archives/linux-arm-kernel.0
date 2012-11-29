From: mcgrof@do-not-panic.com (Luis R. Rodriguez)
Date: Thu, 29 Nov 2012 12:45:07 -0800
Subject: [PATCH 3/6] s5p-fimc: convert struct spinlock to spinlock_t
In-Reply-To: <1354221910-22493-1-git-send-email-mcgrof@do-not-panic.com>
References: <1354221910-22493-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <1354221910-22493-4-git-send-email-mcgrof@do-not-panic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>

spinlock_t should always be used.

Could not get this to build with allmodconfig:

mcgrof at frijol ~/linux-next (git::(no branch))$ make C=1 M=drivers/media/platform/s5p-fimc/

  WARNING: Symbol version dump /home/mcgrof/linux-next/Module.symvers
           is missing; modules will have no dependencies and modversions.

  LD      drivers/media/platform/s5p-fimc/built-in.o
  Building modules, stage 2.
  MODPOST 0 modules

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-media at vger.kernel.org
Reported-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Luis R. Rodriguez <mcgrof@do-not-panic.com>
---
 drivers/media/platform/s5p-fimc/mipi-csis.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/s5p-fimc/mipi-csis.c b/drivers/media/platform/s5p-fimc/mipi-csis.c
index 4c961b1..86c8775 100644
--- a/drivers/media/platform/s5p-fimc/mipi-csis.c
+++ b/drivers/media/platform/s5p-fimc/mipi-csis.c
@@ -187,7 +187,7 @@ struct csis_state {
 	const struct csis_pix_format *csis_fmt;
 	struct v4l2_mbus_framefmt format;
 
-	struct spinlock slock;
+	spinlock_t slock;
 	struct csis_pktbuf pkt_buf;
 	struct s5pcsis_event events[S5PCSIS_NUM_EVENTS];
 };
-- 
1.7.10.4
