From: bengt.g.jonsson@stericsson.com (Bengt Jonsson)
Date: Tue, 23 Nov 2010 19:25:52 +0100
Subject: [PATCH 1/3] mfd: Added new regulator_data pointer to ab8500 board
	configuration
In-Reply-To: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
References: <1290536754-21775-1-git-send-email-bengt.g.jonsson@stericsson.com>
Message-ID: <1290536754-21775-2-git-send-email-bengt.g.jonsson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ab8500 regulator board configuration will be better separated
from the MFD board configuration. This patch adds a void pointer
for this purpose.

Signed-off-by: Bengt Jonsson <bengt.g.jonsson@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@stericsson.com>
---
 include/linux/mfd/ab8500.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/mfd/ab8500.h b/include/linux/mfd/ab8500.h
index d63b605..70d8d9a 100644
--- a/include/linux/mfd/ab8500.h
+++ b/include/linux/mfd/ab8500.h
@@ -146,6 +146,7 @@ struct ab8500_platform_data {
 	int irq_base;
 	void (*init) (struct ab8500 *);
 	struct regulator_init_data *regulator[AB8500_NUM_REGULATORS];
+	void *regulator_data;
 };
 
 extern int __devinit ab8500_init(struct ab8500 *ab8500);
-- 
1.7.2.2
