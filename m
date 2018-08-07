From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Tue, 7 Aug 2018 18:15:32 -0500
Subject: [PATCH 09/33] net: thunderx: mark expected switch fall-through
In-Reply-To: <cover.1533675546.git.gustavo@embeddedor.com>
References: <cover.1533675546.git.gustavo@embeddedor.com>
Message-ID: <c6613aa9afb1e3849036d73827ae07f3fbf56549.1533675546.git.gustavo@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 114781 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
index 5603f5a..92ba958 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_ethtool.c
@@ -527,6 +527,7 @@ static int nicvf_get_rss_hash_opts(struct nicvf *nic,
 	case SCTP_V4_FLOW:
 	case SCTP_V6_FLOW:
 		info->data |= RXH_L4_B_0_1 | RXH_L4_B_2_3;
+		/* Fall through */
 	case IPV4_FLOW:
 	case IPV6_FLOW:
 		info->data |= RXH_IP_SRC | RXH_IP_DST;
-- 
2.7.4
