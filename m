From: isubramanian@apm.com (Iyappan Subramanian)
Date: Tue,  3 Mar 2015 11:39:41 -0800
Subject: [PATCH v2 3/3] drivers: net: xgene: fix new firmware backward
 compatibility with older driver
In-Reply-To: <1425411581-25463-1-git-send-email-isubramanian@apm.com>
References: <1425411581-25463-1-git-send-email-isubramanian@apm.com>
Message-ID: <1425411581-25463-4-git-send-email-isubramanian@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the backward compatibile of the older driver with the
newer firmware by making the binding unique so that the older driver won't
recognize the non-supported interfaces.

Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
Signed-off-by: Keyur Chudgar <kchudgar@apm.com>
Tested-by: Mark Langsdorf <mlangsdo@redhat.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 4de62b2..635a83b 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -1025,6 +1025,8 @@ static int xgene_enet_remove(struct platform_device *pdev)
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id xgene_enet_acpi_match[] = {
 	{ "APMC0D05", },
+	{ "APMC0D30", },
+	{ "APMC0D31", },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, xgene_enet_acpi_match);
@@ -1033,6 +1035,8 @@ MODULE_DEVICE_TABLE(acpi, xgene_enet_acpi_match);
 #ifdef CONFIG_OF
 static struct of_device_id xgene_enet_of_match[] = {
 	{.compatible = "apm,xgene-enet",},
+	{.compatible = "apm,xgene1-sgenet",},
+	{.compatible = "apm,xgene1-xgenet",},
 	{},
 };
 
-- 
1.9.1
