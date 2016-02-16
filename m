From: sunil.kovvuri@gmail.com (sunil.kovvuri at gmail.com)
Date: Tue, 16 Feb 2016 16:29:49 +0530
Subject: [PATCH 1/3] net: thunderx: Fix for multiqset not configured upon
 interface toggle
In-Reply-To: <1455620391-31619-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1455620391-31619-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <1455620391-31619-2-git-send-email-sunil.kovvuri@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sunil Goutham <sgoutham@cavium.com>

When a interface is assigned morethan 8 queues and the logical interface
is toggled i.e down & up, additional queues or qsets are not initialized
as secondary qset count is being set to zero while tearing down.

Signed-off-by: Sunil Goutham <sgoutham@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index c24cb2a..f8012c4 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1125,7 +1125,6 @@ int nicvf_stop(struct net_device *netdev)
 
 	/* Clear multiqset info */
 	nic->pnicvf = nic;
-	nic->sqs_count = 0;
 
 	return 0;
 }
-- 
1.7.1
