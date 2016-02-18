From: rrichter@caviumnetworks.com (Robert Richter)
Date: Thu, 18 Feb 2016 13:39:09 +0100
Subject: [PATCH 2/2] net, thunderx: Use bool in structs where possible
In-Reply-To: <1455799149-19590-1-git-send-email-rrichter@caviumnetworks.com>
References: <1455799149-19590-1-git-send-email-rrichter@caviumnetworks.com>
Message-ID: <1455799149-19590-3-git-send-email-rrichter@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

Looks like the :1 notation was accidentally introduced (this still
uses 1 byte per flag). Using bool instead, which is the common use.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/net/ethernet/cavium/thunder/nic.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
index 688828865c48..fa5b1d2d8e23 100644
--- a/drivers/net/ethernet/cavium/thunder/nic.h
+++ b/drivers/net/ethernet/cavium/thunder/nic.h
@@ -262,9 +262,9 @@ struct nicvf {
 	struct pci_dev		*pdev;
 	u8			vf_id;
 	u8			node;
-	u8			tns_mode:1;
-	u8			sqs_mode:1;
-	u8			loopback_supported:1;
+	bool			tns_mode;
+	bool                    sqs_mode;
+	bool			loopback_supported;
 	bool			hw_tso;
 	u16			mtu;
 	struct queue_set	*qs;
@@ -353,9 +353,9 @@ struct nic_cfg_msg {
 	u8    msg;
 	u8    vf_id;
 	u8    node_id;
-	u8    tns_mode:1;
-	u8    sqs_mode:1;
-	u8    loopback_supported:1;
+	bool  tns_mode;
+	bool  sqs_mode;
+	bool  loopback_supported;
 	u8    mac_addr[ETH_ALEN];
 };
 
-- 
2.7.0.rc3
