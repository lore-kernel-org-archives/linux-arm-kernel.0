From: zhangfei.gao@linaro.org (Zhangfei Gao)
Date: Wed, 18 Jun 2014 12:54:09 +0800
Subject: [PATCH RFC 2/2] ahci: remove AHCI_HFLAG_NO_FBS setting
In-Reply-To: <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
References: <xuwei5@hisilicon.com, kefeng.wang@linaro.org,>
 <1403067249-8021-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <1403067249-8021-3-git-send-email-zhangfei.gao@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AHCI_HFLAG can be set directly in dts.

For example
ahci:sata at f9900000 {
	no-fbs;
	no-ncq;
};

Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 drivers/ata/ahci_platform.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/ahci_platform.c b/drivers/ata/ahci_platform.c
index ebe505c17763..d6dedaa94280 100644
--- a/drivers/ata/ahci_platform.c
+++ b/drivers/ata/ahci_platform.c
@@ -57,9 +57,6 @@ static int ahci_probe(struct platform_device *pdev)
 			goto disable_resources;
 	}
 
-	if (of_device_is_compatible(dev->of_node, "hisilicon,hisi-ahci"))
-		hflags |= AHCI_HFLAG_NO_FBS;
-
 	rc = ahci_platform_init_host(pdev, hpriv, &ahci_port_info,
 				     hflags, 0, 0);
 	if (rc)
-- 
1.7.9.5
