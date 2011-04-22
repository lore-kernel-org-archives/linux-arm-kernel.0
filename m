From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Fri, 22 Apr 2011 17:38:23 +0530
Subject: [PATCH v4 05/11] mfd: pruss SUART private data.
In-Reply-To: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <1303474109-6212-6-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PRUSS SUART data.

Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>
---
 include/linux/mfd/pruss.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/pruss.h b/include/linux/mfd/pruss.h
index 8ef25b3..c5e2af2 100644
--- a/include/linux/mfd/pruss.h
+++ b/include/linux/mfd/pruss.h
@@ -87,6 +87,11 @@
 #define PRU_INTC_CHANMAP12_HALF		(0x00010908)
 #define PRU_INTC_REGMAP_MASK		(0xFFFFFFFF)
 
+struct da850_evm_pruss_suart_data {
+	u32 version;
+	int (*setup)(void);
+};
+
 s32 pruss_enable(struct device *dev, u8 pruss_num);
 
 s32 pruss_load(struct device *dev, u8 pruss_num,
-- 
1.7.2.3
