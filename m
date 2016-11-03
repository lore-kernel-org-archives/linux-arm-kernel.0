From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  2 Nov 2016 22:52:05 -0600
Subject: [PATCH v5 2/8] firmware: arm_scpi: increase MAX_DVFS_OPPS to 16
 entries
In-Reply-To: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
References: <1478148731-11712-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1478148731-11712-3-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

Since Amlogic SoCs supports more than 8 OPPs per domains, we need increase
the OPP structure size.

This patch increases the MAX_DVFS_OPPS to 16.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 9e9b022450eb..21542a32ad9f 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -63,7 +63,7 @@
 #define SCPI_SLOT		0
 
 #define MAX_DVFS_DOMAINS	8
-#define MAX_DVFS_OPPS		8
+#define MAX_DVFS_OPPS		16
 #define DVFS_LATENCY(hdr)	(le32_to_cpu(hdr) >> 16)
 #define DVFS_OPP_COUNT(hdr)	((le32_to_cpu(hdr) >> 8) & 0xff)
 
-- 
1.9.1
