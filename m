From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 21 Dec 2016 12:16:34 +0100
Subject: [PATCH net-next 27/27] net: mvpp2: finally add the PPv2.2 compatible
 string
In-Reply-To: <1482318994-23488-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1482318994-23488-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1482318994-23488-28-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the mvpp2 driver has been modified to accommodate the support
for PPv2.2, we can finally advertise this support by adding the
appropriate compatible string.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index d9368d6..2dc1003 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -7014,6 +7014,10 @@ static const struct of_device_id mvpp2_match[] = {
 		.compatible = "marvell,armada-375-pp2",
 		.data = (void *)MVPP21,
 	},
+	{
+		.compatible = "marvell,armada-7k-pp22",
+		.data = (void *)MVPP22,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mvpp2_match);
-- 
2.7.4
