From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 13:00:27 +0100
Subject: [PATCH 219/222] mmc: dw_mmc: call mmc_of_parse to fill in common
 options
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wdenr-0007SP-Aa@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Olof Johansson <olof@lixom.net>
To: linux-arm-kernel at lists.infradead.org

The shared of parse function fills in common options for capabilities,
etc, but it needs to be called from each driver that wants to make use
of it. dw_mmc was missing the call.

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mmc/host/dw_mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cced599d5aeb..a2c12ebb376e 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2140,6 +2140,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (!mmc)
 		return -ENOMEM;
 
+	mmc_of_parse(mmc);
+
 	slot = mmc_priv(mmc);
 	slot->id = id;
 	slot->mmc = mmc;
-- 
1.8.3.1
