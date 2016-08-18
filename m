From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:11:03 +0200
Subject: [PATCH 10/13] scpi: grow MAX_DVFS_OPPS to 16 entries
In-Reply-To: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
References: <1471515066-3626-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471515066-3626-11-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Amlogic SoCs reports more than 8 OPPs per domains, grow the structure
size to 16.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/firmware/arm_scpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index d73db7c..699bed7 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -74,7 +74,7 @@
 #define SCPI_SLOT		0
 
 #define MAX_DVFS_DOMAINS	8
-#define MAX_DVFS_OPPS		8
+#define MAX_DVFS_OPPS		16
 #define DVFS_LATENCY(hdr)	(le32_to_cpu(hdr) >> 16)
 #define DVFS_OPP_COUNT(hdr)	((le32_to_cpu(hdr) >> 8) & 0xff)
 
-- 
1.9.1
