From: haimdaniel@gmail.com (Haim Daniel)
Date: Wed, 29 Mar 2017 10:58:56 +0300
Subject: [PATCH v3] staging: vc04_services: add parenthesis to macros
In-Reply-To: <20170329073849.GB17585@kroah.com>
References: <20170329073849.GB17585@kroah.com>
Message-ID: <1490774336-7781-1-git-send-email-haimdaniel@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

vchi_cfg.h: fix checkpatch ERROR: Macros with complex values should be enclosed in parenthesis

Signed-off-by: Haim Daniel <haimdaniel@gmail.com>
---
 drivers/staging/vc04_services/interface/vchi/vchi_cfg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
index 26bc2d3..b6f42b8 100644
--- a/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
+++ b/drivers/staging/vc04_services/interface/vchi/vchi_cfg.h
@@ -173,7 +173,7 @@
  * under the carpet. */
 #if VCHI_RX_MSG_QUEUE_SIZE < (VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS
 #  undef VCHI_RX_MSG_QUEUE_SIZE
-#  define VCHI_RX_MSG_QUEUE_SIZE (VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS
+#  define VCHI_RX_MSG_QUEUE_SIZE ((VCHI_MAX_MSG_SIZE/16 + 1) * VCHI_NUM_READ_SLOTS)
 #endif
 
 /* How many bulk transmits can we have pending. Once exhausted, vchi_bulk_queue_transmit
-- 
1.9.1
