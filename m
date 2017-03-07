From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue,  7 Mar 2017 16:53:02 +0100
Subject: [PATCHv3 net-next 04/22] net: mvpp2: remove unused register
 definition MVPP2_TXQ_THRESH_REG
In-Reply-To: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1488902000-2658-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1488902000-2658-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This register is no longer used since commit edc660fa09e2 ("net: mvpp2:
replace TX coalescing interrupts with hrtimer").

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index fb8b5e9..60cc020 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -117,9 +117,6 @@
 #define MVPP2_TXQ_DESC_SIZE_REG			0x2088
 #define     MVPP2_TXQ_DESC_SIZE_MASK		0x3ff0
 #define MVPP2_AGGR_TXQ_UPDATE_REG		0x2090
-#define MVPP2_TXQ_THRESH_REG			0x2094
-#define     MVPP2_TRANSMITTED_THRESH_OFFSET	16
-#define     MVPP2_TRANSMITTED_THRESH_MASK	0x3fff0000
 #define MVPP2_TXQ_INDEX_REG			0x2098
 #define MVPP2_TXQ_PREF_BUF_REG			0x209c
 #define     MVPP2_PREF_BUF_PTR(desc)		((desc) & 0xfff)
-- 
2.7.4
