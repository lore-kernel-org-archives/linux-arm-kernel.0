From: olof@lixom.net (Olof Johansson)
Date: Sun, 19 Jan 2014 19:56:54 -0800
Subject: [PATCH 2/3] mmc: dw_mmc: call mmc_of_parse to fill in common options
In-Reply-To: <1390190215-22700-1-git-send-email-olof@lixom.net>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
Message-ID: <1390190215-22700-3-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shared of parse function fills in common options for capabilities,
etc, but it needs to be called from each driver that wants to make use
of it. dw_mmc was missing the call.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/mmc/host/dw_mmc.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a776f24..7119f63 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2137,6 +2137,8 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	if (!mmc)
 		return -ENOMEM;
 
+	mmc_of_parse(mmc);
+
 	slot = mmc_priv(mmc);
 	slot->id = id;
 	slot->mmc = mmc;
-- 
1.7.10.4
