From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 27 Jan 2014 10:50:37 +0000
Subject: [PATCH] drivers: bus: fix CCI driver kcalloc call parameters swap
Message-ID: <1390819837-32196-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a bug/typo in the CCI driver kcalloc usage
that inadvertently swapped the parameters order in the
kcalloc call and went unnoticed.

Reported-by: Xia Feng <xiafeng@allwinnertech.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/bus/arm-cci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b6739cb..962fd35 100644
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -979,7 +979,7 @@ static int cci_probe(void)
 
 	nb_cci_ports = cci_config->nb_ace + cci_config->nb_ace_lite;
 
-	ports = kcalloc(sizeof(*ports), nb_cci_ports, GFP_KERNEL);
+	ports = kcalloc(nb_cci_ports, sizeof(*ports), GFP_KERNEL);
 	if (!ports)
 		return -ENOMEM;
 
-- 
1.8.2.2
